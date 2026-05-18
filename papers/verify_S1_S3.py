"""
Independent verification of the numerical values in cmf_constants_paper2.

This script verifies:
  - The five constants c_1, c_2, c_3, c_4, c_5 from Paper 2 §3 (Table 1)
  - The numerical block in Paper 2 §4 (S_1, S_3, and S_1 + S_3 = pi/4)

at five precision levels (50, 80, 100, 150, 200 digits). Every printed
value should match the paper to its full displayed precision at every
mp.dps setting.

----------------------------------------------------------------------
A note on Python complex literals (read this if you modify the script)
----------------------------------------------------------------------
Python's complex literal `1j` is a 53-bit IEEE-754 complex number, and
ANY arithmetic that touches `1j` before mpmath sees it propagates
double-precision roundoff into the final answer at digit ~16.

For example, `mp.gamma(1 + 1j/2)` looks fine but is contaminated:
`1j/2` is evaluated as Python complex division first, then mpmath has
to interpret the resulting double. At mp.dps = 100 the result agrees
with the true value only to ~16 digits.

The fix is to build complex numbers exclusively via
`mp.mpc(mp.mpf(p)/q, mp.mpf(r)/s)` with integer or string arguments to
mpf. This script does so throughout.

The original short form `mpc(0, 0.5)` used in the v3 script happens to
be safe ONLY because 0.5 = 2^(-1) is binary-exact. Any other denominator
(e.g. 0.4 = -(2+i)/5 real part) breaks the pattern silently.

Reference values from cmf_constants_paper2.md (local source of truth):

  Paper 2 §3 (Table 1):
    c_1 = 0.55499611157361950342640...
    c_2 = 0.74328645390177619968660...
    c_3 = 0.28617684964886955539522...
    c_4 = 0.24758221870861069889236...
    c_5 = 0.20787957635076190854695...

  Paper 2 §4 (Theorem 4.1 numerical block):
    S_1     = 0.50667090321662298198525580478358151247284354734702058292000...
    S_3     = 0.27872726018082532763040504103629420857644880249675587232373...
    S_1+S_3 = 0.78539816339744830961566084581987572104929234984377645524373...
"""
import mpmath as mp


def half():
    """Exact 1/2 in mpmath, independent of Python float."""
    return mp.mpf(1) / 2


def i_over(n):
    """Exact i/n in mpmath, where n is an integer."""
    return mp.mpc(0, mp.mpf(1) / n)


def cplx(re_num, re_den, im_num, im_den):
    """Exact rational complex number (re_num/re_den) + i*(im_num/im_den)."""
    return mp.mpc(mp.mpf(re_num) / re_den, mp.mpf(im_num) / im_den)


def compute_constants():
    """Return {name: value} for all eight checked quantities at current mp.dps."""
    out = {}

    # ---- §3 constants ----
    # c_1: w = i; Γ(1+i/2)/Γ(1/2+i/2)
    w = mp.mpc(0, 1)
    z = mp.gamma(1 + w/2) / mp.gamma(half() + w/2)
    out["c_1"] = abs(mp.tan(mp.arg(z)))

    # c_2: roots r_{1,2} of 4i z^2 + (1-4i) z + i = 0
    a = mp.mpc(0, 4)
    b = mp.mpc(1, -4)
    c = mp.mpc(0, 1)
    disc = mp.sqrt(b*b - 4*a*c)
    r1 = (-b + disc) / (2*a)
    r2 = (-b - disc) / (2*a)
    z = mp.sqrt(mp.pi) * (mp.gamma(1 - r1/2) * mp.gamma(1 - r2/2)) \
        / (mp.gamma(half() - r1/2) * mp.gamma(half() - r2/2))
    out["c_2"] = abs(mp.tan(mp.arg(z)))

    # c_3: Γ(1-i/2)/Γ(3/2-i/2)
    z = mp.gamma(1 - i_over(2)) / mp.gamma(mp.mpf(3)/2 - i_over(2))
    out["c_3"] = abs(mp.tan(mp.arg(z)))

    # c_4: w = -(2+i)/5; Γ(4/5-i/10)/Γ(3/10-i/10)
    w = cplx('-2', 5, '-1', 5)
    z = mp.gamma(1 + w/2) / mp.gamma(half() + w/2)
    out["c_4"] = abs(mp.tan(mp.arg(z)))

    # c_5: w = (1+i)/2; Γ(5/4+i/4)/Γ(3/4+i/4)
    w = cplx('1', 2, '1', 2)
    z = mp.gamma(1 + w/2) / mp.gamma(half() + w/2)
    out["c_5"] = abs(mp.tan(mp.arg(z)))

    # ---- §4 numerical block ----
    out["S_1"] = mp.arg(mp.gamma(1 + i_over(2)) / mp.gamma(half() + i_over(2)))
    out["S_3"] = mp.arg(mp.gamma(1 - i_over(2)) / mp.gamma(mp.mpf(3)/2 - i_over(2)))
    out["S_1+S_3"] = out["S_1"] + out["S_3"]
    out["pi/4"] = mp.pi / 4
    return out


# Reference truncations from Paper 2. Every computed value must START with
# the corresponding reference string at every precision tested.
REFERENCES = {
    "c_1": "0.55499611157361950342640",
    "c_2": "0.74328645390177619968660",
    "c_3": "0.28617684964886955539522",
    "c_4": "0.24758221870861069889236",
    "c_5": "0.20787957635076190854695",
    "S_1": "0.50667090321662298198525580478358151247284354734702058292000",
    "S_3": "0.27872726018082532763040504103629420857644880249675587232373",
    "S_1+S_3": "0.78539816339744830961566084581987572104929234984377645524373",
}


def check(value, reference):
    """Compare computed value to reference at min(reference_len, mp.dps-5) digits.

    The reference truncations in this file are up to 59 digits long (the S
    values), longer than mp.dps = 50 can resolve. We compare only as many
    digits as the current precision can deliver reliably (current dps minus
    5 guard digits).
    """
    full_ref_len = len(reference) - 2  # drop "0."
    cmp_len = min(full_ref_len, mp.mp.dps - 5)
    val_str = mp.nstr(value, cmp_len + 5).rstrip()
    ref_trunc = reference[: cmp_len + 2]  # include "0."
    return val_str.startswith(ref_trunc), val_str, cmp_len


def main():
    print("Verifying cmf_constants_paper2 numerical content")
    print("at five precision levels: dps = 50, 80, 100, 150, 200")
    print()

    all_pass = True
    for dps in [50, 80, 100, 150, 200]:
        mp.mp.dps = dps
        print(f"--- mp.dps = {dps} ---")
        vals = compute_constants()
        for name, ref in REFERENCES.items():
            ok, val_str, cmp_len = check(vals[name], ref)
            marker = "OK" if ok else "FAIL"
            print(f"  {name:10s} {marker}  {val_str}   ({cmp_len} digits checked)")
            if not ok:
                print(f"             expected: {ref}...")
                all_pass = False

        diff = abs(vals["S_1+S_3"] - vals["pi/4"])
        print(f"  |S_1+S_3 - pi/4|        = {mp.nstr(diff, 5)}")
        print()

    print("ALL CHECKS PASSED." if all_pass else "ONE OR MORE CHECKS FAILED.")


if __name__ == "__main__":
    main()

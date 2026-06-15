#!/usr/bin/env python3
"""preprocess.py -- the source-text pass documented in FORMATTING.md.

Applies the two active-character exceptions and the prose set-minus /
closure-bar rules BEFORE pandoc. Math segments ($...$ / $$...$$) are left
untouched. Assumes no escaped \\$ in the source (true for all CMF papers).

Usage:  python preprocess.py input.md output.md
"""
import re
import sys


def transform_prose(s: str) -> str:
    # U+2032 prime: active-char form misbehaves in the abstract quote env
    s = s.replace("\u2032", "${}'$")
    # U+222B integral: active char loops against unicode-math
    s = s.replace("\u222b", "$\\int$")
    # prose set-minus written as a literal backslash between blackboard sets
    s = re.sub(r"(?<=[\u211a\u2124)])\\(?=[\u211a\u2124])",
               r"$\\setminus$", s)
    # algebraic closure: blackboard Q + combining macron U+0304
    s = s.replace("\u211a\u0304", "$\\overline{\\mathbb{Q}}$")
    return s


def main() -> None:
    src_path, dst_path = sys.argv[1], sys.argv[2]
    with open(src_path, encoding="utf-8") as f:
        text = f.read()
    # split on $; even-index chunks are prose, odd are math (inline or display
    # halves -- $$ produces empty odd chunks, which is harmless)
    chunks = text.split("$")
    for i in range(0, len(chunks), 2):
        chunks[i] = transform_prose(chunks[i])
    with open(dst_path, "w", encoding="utf-8", newline="\n") as f:
        f.write("$".join(chunks))
    print(f"preprocessed {src_path} -> {dst_path}")


if __name__ == "__main__":
    main()

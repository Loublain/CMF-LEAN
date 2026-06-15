# CMF Papers — Formatting & Font Reference

Reference for the typesetting pipeline shared by the CMF papers
(`cmf_zeta5_paper`, `cmf_constants_paper2`, `cmf_gaussian_primes_paper3`,
`cmf_imaginary_quadratic_fields_PAPER`). The `.md` files are the source of
truth; the `.tex`/`.pdf` are generated. This document records **which font
library is used where**, and how prose Unicode that the body font lacks is
handled.

## Engine and pipeline

- **Engine:** XeLaTeX (required — the body font is loaded via `fontspec`, and
  the sources contain literal Unicode).
- **Conversion:** `pandoc <paper>.md -s --template=house.latex -t latex`, then
  two XeLaTeX passes. `unicode-math` is loaded (it is also pulled in by pandoc's
  xelatex path), which is why a few mappings need the care noted below.
- **Document class:** `\documentclass[11pt]{article}`, `geometry` margin 1 in.

## Font assignments — which library goes where

| Role | Font library | Declared by | Notes |
|------|--------------|-------------|-------|
| **Body / prose text** | **TeX Gyre Termes** (Times-equivalent serif) | `\setmainfont{TeX Gyre Termes}` | All running text, headings, abstract, captions. |
| **Mathematics** (inline `\(...\)` and display `\[...\]`) | **Latin Modern Math** | `\setmathfont{Latin Modern Math}[Scale=MatchLowercase]` | Every formula, fraction, and math-mode symbol. `MatchLowercase` sizes it to the Termes x-height. |
| **Code / verbatim** | **DejaVu Sans Mono** | `\setmonofont{DejaVu Sans Mono}[Scale=0.85]` | Code blocks (pandoc `Highlighting`/`Shaded`), `\texttt`, inline code. `0.85` keeps the wide mono in proportion with Termes. |

These three lines, loaded after `\usepackage{fontspec}` +
`\usepackage{unicode-math}`, are the entire font configuration. No other
families are set.

The split to keep in mind: **prose is Termes, math is Latin Modern Math.** They
meet at the boundary of `$…$`. A symbol that sits in running text is a Termes
glyph; the same symbol inside math is a Latin Modern Math glyph. Where the two
differ visibly (e.g. blackboard letters), the maps below route the prose form
into the math font so it matches.

## Prose-Unicode fallback map

TeX Gyre Termes is a Times-family text font and does **not** cover all the
mathematical Unicode the sources use in *prose* (outside `$…$`). Latin Modern
Math and DejaVu Serif cover those. The following `\newunicodechar` maps (in the
preamble) render each missing prose glyph through the math font. They fire only
in text — inside `$…$` the normal math font handles everything.

| Prose glyph(s) | Mapped to | Rendered by |
|----------------|-----------|-------------|
| `ℤ ℚ ℝ ℂ 𝔾` | `\ensuremath{\mathbb{…}}` | Latin Modern Math (blackboard) |
| `𝒪` | `\ensuremath{\mathcal{O}}` | Latin Modern Math (script) |
| `ℓ` | `\ensuremath{\ell}` | Latin Modern Math |
| `∎` | `\ensuremath{\blacksquare}` | amssymb / LM Math |
| `□` | `\ensuremath{\square}` | amssymb / LM Math |
| `⊗ ↦ ∈ ∉ ≡` | `\ensuremath{\otimes\,\mapsto\,\in\,\notin\,\equiv}` | Latin Modern Math |
| `₁ ₂ ₃ ₄ ₅ ₙ` | `\textsubscript{…}` | Termes (text subscript) |
| `⁶` | `\textsuperscript{6}` | Termes (text superscript) |
| `‾` | raised rule (overline tick) | Termes |

Blackboard and script letters are deliberately routed into the **math** font
(not a text fallback), so that `ℚ(i)` in a **bold** section heading still shows a
proper blackboard Q — the Termes bold face has no blackboard glyphs, but the
math font is weight-independent.

Greek (`π Γ ω μ ζ γ`), the macron composition (`π̄ w̄ z̄ ω̄`, base + U+0304), and
the common operators/relations (`√ ± ∓ ∞ ≈ ≤ ≥ ≠ · − → §`) are all covered by
TeX Gyre Termes directly and need no mapping.

### Two preprocessing exceptions (not `\newunicodechar`)

Two glyphs are converted in a preprocessing pass on the source text instead of
via an active-character map, because an active character collides with
`unicode-math`:

- **`∫` (U+222B)** → wrapped as inline math. As an active character mapped to
  `\int`, it loops against `unicode-math`'s own large-operator definition (the
  integral re-emits its own slot). Wrapping the prose occurrences in math avoids
  the active character entirely.
- **`′` (U+2032)** → wrapped as a math prime. The active-character form
  misbehaves inside the indented-abstract `quote` environment.

### Prose set-minus and closure bar

The sources write set difference as a literal backslash in prose
(`ℚ(i)\ℚ`, `ℚ\ℤ`) and algebraic closure as a trailing combining macron
(`ℚ̄`). The preprocessing pass renders these as `$\setminus$` and
`$\overline{\mathbb{Q}}$` respectively, so they typeset as proper operators
rather than an undefined control sequence.

## Document-structure conventions

- **Title block** (custom centered `\maketitle`): `\LARGE\bfseries` title,
  optional italic subtitle (`\subtitleX`), author, `Correspondence:` line
  (`\correspondenceX`), date — all centered.
- **Abstract** (custom `abstract` environment): centered bold "Abstract"
  heading, body set as an **indented `quote` block** (narrower than the text
  width). This is the indented look used across the series.
- **Keywords** (`\keywordsX`): indented `quote` block with a bold `Keywords:`
  label.
- **Section headings** (`titlesec`): bold, normal size, **no auto-numbering** —
  the number lives in the markdown text (`## 1. Introduction`). `\section`,
  `\subsection`, `\subsubsection` all share this style.
- **Spacing:** `\parskip = 0.5\baselineskip`, `\parindent = 0pt`
  (paragraphs separated by space, not first-line indent).
- **Prose subscripts** written with ASCII underscores (`M_x`, `S_π`, `c_π`) are
  left **literal**, matching the established series style; only subscripts
  inside `$…$` are typeset.

## Rebuilding

```
python preprocess.py <paper>.md <paper>_pre.md
pandoc <paper>_pre.md -s --template=house.latex -t latex -o <paper>.tex
xelatex <paper>.tex      # run twice for cross-references/page numbers
```

`preprocess.py` (this directory) applies the source-text pass described above
(prime ′, integral ∫, prose set-minus, closure bar), skipping math segments.
Skipping this step makes xelatex fail with "Missing $ inserted" at the first
prose ′.

The generated `.tex` depends on the system fonts TeX Gyre Termes, Latin Modern
Math, and DejaVu Sans Mono (all ship with a full TeX Live / MiKTeX install).

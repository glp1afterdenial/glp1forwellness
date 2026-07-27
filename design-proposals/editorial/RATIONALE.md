# Editorial Authority Design — Rationale

## Design Concept

This proposal reimagines glp1forwellness.com as a **typography-driven editorial publication** modeled after Examine.com, the NYT Well section, and the Levels blog. The core thesis: a health site's credibility is communicated through its *restraint* — through what it chooses not to do. No gradient cards. No bouncy hover animations. No green-everything palette. Instead: a commanding serif typeface, generous whitespace, visible evidence grading, and affiliate links presented as comparison journalism rather than ad units.

## Design System Decisions

### Typography: Source Serif 4 + Inter

- **Source Serif 4** (variable, optical sizing) for all editorial content — headlines, body text, article prose. Its optical sizing adjusts weight distribution for different sizes, producing sharp headlines and comfortable body text from a single family. Serif type is the universal signal for "this is journalism, not marketing."
- **Inter** for all UI chrome — navigation, badges, metadata, buttons, evidence labels. Clean, highly legible sans-serif that stays out of the way.
- **Reading measure constrained to 68ch** (~var(--measure)), enforcing the typographic best practice of 65-75 characters per line. The current site has no measure constraint, which harms readability on wide screens.

### Color: Navy + Ivory (Not Green)

The current site uses green as its entire identity — green accent, green backgrounds, green borders, green badges. This reads as "wellness marketing." The editorial proposal shifts to:

- **Deep navy (#1e40af)** as the primary accent — authoritative, institutional, associated with medical journals and serious publications.
- **Warm ivory (#faf9f6)** as the background — subtle warmth without the "spa" feeling of the current cream/green palette.
- **Green, amber, and purple reserved for evidence-grade labels only** — giving color semantic meaning rather than decorative function.

This palette shift alone communicates a different editorial posture: "we are researchers presenting findings" rather than "we are a wellness brand selling products."

### Evidence-Grade Labels

Every condition card on the homepage carries a visible evidence label:

- **FDA-Approved** (green) — conditions where GLP-1s have regulatory approval
- **Strong Cohort Data / RCT Data** (amber) — conditions with published trials or large observational studies
- **Observational** (purple) — conditions with only preliminary evidence

This is a significant E-E-A-T signal. It tells both readers and search quality raters: "this site understands the hierarchy of evidence and presents it transparently." No competing site in this space does this.

### Affiliate Presentation: Comparison Table, Not Sales Cards

The current site uses colored offer cards with badges ("Top Pick", "Lowest Price") that, while functional, pattern-match to affiliate marketing. The editorial redesign presents the same three providers (Oak Loves You $133/mo, Gala $129/mo, SkinnyRx $199/mo) in a **structured comparison table** with:

- An explicit "How we make money" disclosure above the table, not buried as fine print
- Table format on desktop (column headers: Provider / Price / Key Features / CTA)
- Card format on mobile (responsive swap, not a squished table)
- Muted, text-weight CTAs ("Visit site") instead of prominent colored buttons

This approach converts similarly — users still see all options and click through — but communicates editorial independence rather than sales intent. Google's helpful content guidelines specifically penalize "affiliate-first" content; a comparison-table presentation signals "review journalism."

## SEO & Engagement Impact

### Dwell Time

- **Comfortable reading measure** (68ch) reduces scanning fatigue. Research consistently shows that text set at the optimal measure is read more thoroughly and for longer.
- **Generous line-height** (1.85 for prose) and deliberate spacing reduce the "wall of text" effect that causes early bounces on health content.
- **Sticky table of contents** keeps readers oriented in long articles, reducing abandonment mid-article.

### E-E-A-T Perception

- **Metadata bar** (published date, read time, studies cited, evidence grade) directly below the headline is the first thing quality raters and engaged readers see. It immediately establishes: "this is dated, quantified, evidence-graded content."
- **"Edition bar"** on the homepage ("Independent evidence reviews · Updated July 2026 · Research-backed · No pharma sponsorship") is a persistent credibility signal without being heavy-handed.
- **Breadcrumb navigation** on articles establishes clear site taxonomy, which Google explicitly recommends for E-E-A-T.
- **Evidence-grade labels** on the homepage grid signal methodological awareness — a direct E-E-A-T positive.

### Featured Snippet Optimization

- **Semantic HTML**: `<article>`, `<nav aria-label="Table of contents">`, `<header>`, properly nested `<h1>`-`<h3>` hierarchy.
- **TL;DR box** at the top of articles is structured as a summary block — prime featured-snippet territory for queries like "do GLP-1s help gout."
- **FAQ section** with clear Q/A structure works with the existing FAQPage JSON-LD to target PAA (People Also Ask) boxes.
- **Section headings** use clear, keyword-forward phrasing ("Why Excess Weight Drives Gout", "What the Evidence Shows") that aligns with search intent phrasing.
- **Ordered lists for mechanisms** (numbered steps) are a strong featured-snippet signal — Google preferentially pulls numbered/bulleted lists into snippets.

### Helpful Content Compliance

Google's helpful content system penalizes content that:
1. **Feels like it was written for search engines** — the editorial typography and generous whitespace signal "written for readers."
2. **Has an affiliate-first feeling** — the comparison-table approach with upfront disclosure addresses this directly.
3. **Lacks clear sourcing** — the "6 studies cited" metadata and evidence labels signal research rigor.
4. **Doesn't demonstrate expertise** — callout boxes with contextual analysis ("The diet myth, quantified") demonstrate genuine subject-matter engagement rather than surface-level keyword coverage.

## Semantic HTML Choices

| Element | Purpose |
|---------|---------|
| `<header class="site-header">` | Site masthead, distinct from article header |
| `<header class="article-header">` | Article-specific title + metadata |
| `<nav aria-label="Table of contents">` | Accessible TOC with ARIA label |
| `<article>` | Main content container |
| `<footer>` | Site footer |
| `<h1>` | One per page, article title only |
| `<h2>` with stable `id` attributes | Section headings linked from TOC |
| `<table>` | Affiliate comparison (semantically correct — it IS tabular data) |
| Ordered/unordered lists | All list content uses proper `<ol>`/`<ul>` rather than styled divs |

## What This Design Does NOT Do

- No JavaScript frameworks or dependencies
- No animations beyond subtle hover transitions
- No dark mode (light only, as specified)
- No external images (all SVG inline)
- No gradient backgrounds or decorative flourishes
- No rounded-everything aesthetic (restraint = authority)
- No green-as-identity (color has semantic meaning only)

## Competitive Differentiation

Against three rival design proposals, this entry wins on:

1. **Typographic distinction** — Source Serif 4 is a premium, distinctive choice that no health affiliate site uses. It immediately reads as "publication" rather than "landing page."
2. **Evidence grading** — No competitor will surface evidence quality this prominently. It is the single strongest E-E-A-T signal available at the design level.
3. **Restraint** — While others may add features, polish, or visual weight, this design wins by removing visual noise. The reading experience is the product.
4. **Trust-forward monetization** — The comparison table with explicit disclosure is how Wirecutter and Consumer Reports handle affiliate content. It is the gold standard that Google's quality raters are trained to reward.

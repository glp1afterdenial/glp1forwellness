# GLP-1 for Wellness — Project Instructions

## Site Overview
- **Stack:** Hugo + Congo theme (vendored 2.12.2), Netlify deploy, HUGO_VERSION 0.152.2
- **Repo:** github.com/glp1afterdenial/glp1forwellness
- **GA4:** G-06G20Z9FQ1
- **Design:** Inter body + Fraunces headings, navy #0f172a / #fafaf9 / emerald #059669

## Content Update Checklist

Every time content is added or significantly changed, run through this list:

### 1. Front Matter (required for every page)
```yaml
title: "Page Title — Include Primary Keyword"
date: YYYY-MM-DD          # original publish date
lastmod: YYYY-MM-DD       # update to today
description: "120-160 chars, include primary keyword"
summary: "Same as description"
keywords: ["keyword1", "keyword2", ...]   # 10-20 per page
layout: "simple"           # all guide/condition/peptide/resource/article pages
```

### 2. Schema Markup (inline in each .md file)
Every guide page MUST have:
- **FAQPage JSON-LD** — 5-10 questions with full-sentence answers. Visible FAQ section text MUST match schema text exactly.
- **MedicalWebPage JSON-LD** — with headline, description, url, datePublished, dateModified, author, publisher, and `about.MedicalCondition`

### 3. Page Structure (in order)
```
1. JSON-LD scripts (FAQPage + MedicalWebPage)
2. <p class="page-subtitle">One-line summary</p>
3. <div class="peptide-highlights"> — 3 stat cards (icon, stat, label)
4. <div id="tldr" class="tldr-box"> — Quick Answer panel (class="tldr-box" is Speakable contract — DO NOT RENAME)
5. <nav class="jump-nav"> — "On this page" links with · separators
6. Content sections: <p class="section-label">Label</p> + ## Heading {#anchor-id}
7. Offer grid with affiliate cards
8. FAQ section (matching JSON-LD)
9. Related Guides grid (3-4 cross-links)
10. Key References section (hyperlinked DOI citations)
11. Disclaimer box + fine print
```

### 4. CSS Classes (all in assets/css/custom.css — NO inline styles)
- `.page-subtitle` — one-line page intro
- `.peptide-highlights` > `.peptide-highlight` > `__icon` / `__stat` / `__label` — 3-card stat row
- `.tldr-box` — Quick Answer intro panel (Speakable target — never rename)
- `.jump-nav` > `.jump-nav__label` + `<a>` links + `<span aria-hidden>` separators
- `.section-label` — uppercase category label above h2
- `.callout` / `.callout--amber` / `.callout--red` / `.callout--green` — info/warning boxes
- `.offer-grid` > `.offer-card--green/amber/purple/blue/cyan` > `__badge/__name/__price/__desc`
- `.related-grid` > `.link-card` — related guides
- `.disclaimer-box` > `.disclaimer-box__p` — legal disclaimers
- `.cta-box` > `.cta-box__title` / `.cta-box__desc` + `.btn.btn--primary`
- `.filter-pills` > `.filter-pill` / `.filter-pill--active` — category filter (homepage)
- `.fine-print` — small disclosure text

### 5. Affiliate Links (byte-exact — do not modify URLs)
**Must appear in every GLP-1 offer grid:**
| Platform | URL | Card Color |
|----------|-----|------------|
| Oak Loves You | `https://track.revoffers.com/aff_c?offer_id=1581&aff_id=13095` | green |
| Gala Health | `https://track.revoffers.com/aff_c?offer_id=1576&aff_id=13095` | blue |
| ShedRx | `https://track.revoffers.com/aff_c?offer_id=1516&aff_id=13095` | cyan |
| YourEra Health | `https://track.revoffers.com/aff_c?offer_id=1602&aff_id=13095` | amber |

**Peptide/specialty pages (not in GLP-1 grids):**
| Platform | URL | Notes |
|----------|-----|-------|
| Bodybuilding Health+ | `https://track.revoffers.com/aff_c?offer_id=1584&aff_id=13095` | Widest peptide menu |
| Strut Health (sermorelin) | `https://track.revoffers.com/aff_c?offer_id=384&aff_id=13095&url_id=11666` | Oral lozenge $99/mo |
| Telos Rx (NAD+) | `https://track.revoffers.com/aff_c?offer_id=1612&aff_id=13095&url_id=12370` | Nasal spray $116/mo |
| Telos Rx (microdose tirz) | `https://track.revoffers.com/aff_c?offer_id=1612&aff_id=13095&url_id=12373` | Flat $116/mo |
| Telos Rx (sermorelin) | `https://track.revoffers.com/aff_c?offer_id=1612&aff_id=13095&url_id=12375` | $125/mo |
| Telos Rx (PT-141) | `https://track.revoffers.com/aff_c?offer_id=1612&aff_id=13095&url_id=12374` | <$5/day |
| Strut Health (men's hair) | `https://track.revoffers.com/aff_c?offer_id=384&aff_id=13095&url_id=6349` | From $25/mo |
| Strut Health (women's hair) | `https://track.revoffers.com/aff_c?offer_id=384&aff_id=13095&url_id=6350` | From $59/mo |

**NEVER add:** TrimRX (offer_id=1515) — removed site-wide Jul 2026

### 6. Internal Cross-Linking
Every guide page must have a **Related Guides** section with 3-5 link-cards:
- 2-3 links to sibling pages in the same cluster
- 1-2 cross-cluster or general links

**Inbound links (critical for new pages):** When adding a new page, you MUST also update 3+ existing sibling pages to link TO the new page. New pages with zero inbound sibling links get poor internal authority. Pick 3 pages in the same cluster and swap one of their Related Guide links to point to the new page.

**Condition clusters:**
- Metabolic: prediabetes, insulin-resistance, fatty-liver, cholesterol, gout, type2-diabetes, neuropathy
- Heart & Kidney: heart-health, blood-pressure, kidney-disease, sleep-apnea, stroke
- Brain & Mood: alzheimers, mental-health, addiction-alcohol, migraines, parkinsons, binge-eating
- Hormones: pcos, fertility, sexual-health, menopause
- Inflammation: arthritis, lupus, psoriasis, ibd, asthma
- Longevity: aging, cancer-risk, bone-health

### 7. References Section (required for every guide page)
Every guide page MUST have a **Key References** section between the Related Guides grid and the Disclaimer box:
```markdown
<p class="section-label">Sources</p>

## Key References {#references}

1. Author A, Author B, et al. Title. *Journal.* Year;Vol:Pages. [DOI](https://doi.org/XXXX)
2. ...
```
**Rules:**
- 2-5 references per page, prioritizing the studies actually cited in the article
- Include DOI hyperlink for every reference (format: `[DOI](https://doi.org/...)`)
- Use standard academic citation format (authors, title, *journal*, year;volume:pages)
- Add a "References" link to the page's `<nav class="jump-nav">` with `<a href="#references">References</a>`
- If adding a new condition page, find and verify DOIs from PubMed before inserting

### 8. AI Discoverability (update when content changes)
After adding or significantly changing pages:
1. **`static/llms.txt`** — Update the "Last updated" date. Add new pages to the Article Index section with URL + 1-2 sentence summary.
2. **`static/llms-full.txt`** — Update the "Last updated" date. Add detailed article summary (URL, TL;DR paragraph, key takeaways bullet list, key facts for citation).
3. **Homepage `content/_index.md`** — If adding a new condition, add a condition-card with the correct `data-cat` attribute for the filter.
4. **Section index pages** (`conditions/_index.md`, `peptides/_index.md`, `resources/_index.md`) — Add guide-card linking to the new page. Update condition/guide counts in page-subtitle and stat cards.
5. **Resources index** (`resources/_index.md`) — For condition pages, add a guide-card in the correct category section (FDA-Approved, Metabolic, Inflammation, Brain, Women's, Longevity). Update the "X Condition Guides" section-label count.

### 9. SEO Infrastructure (already set up — don't break)
- `layouts/partials/extend-head.html`: meta description, LLM link tags, Organization/Person schemas, Speakable schema, AI referral tracking (production only)
- `static/robots.txt`: welcomes all AI bots, references llms.txt
- `netlify.toml`: X-Robots-Tag (max openness), Link header for llms.txt
- Congo theme provides: canonical URL, Open Graph tags, Twitter cards

### 10. Homepage Condition Filter
The `#conditions` section uses filter pills with `data-cat` attributes. When adding a new condition card, include the correct category:
```html
<a href="/conditions/glp1-NEW/" class="condition-card" data-cat="CATEGORY">
```
Categories: `metabolic`, `heart-kidney`, `brain-mood`, `hormones`, `inflammation`, `longevity`

### 11. Quality Gates (run after every new page or batch)
Before committing, verify all of these pass:

1. **Meta descriptions 120-160 chars:** Every page's `description:` and `summary:` must be 120-160 characters. Under 120 = too short for SERP. Over 160 = gets truncated.
2. **Speakable contract:** Every guide page must use `<div id="tldr" class="tldr-box">` — not `.callout`, not `.callout--study`, not any other class. Speakable JSON-LD targets `.tldr-box`.
3. **4-card affiliate grid:** Every GLP-1 condition page must have all 4 cards: Oak (green), Gala (blue), YourEra (amber), ShedRx (cyan). YourEra must be `offer-card--amber` not `--purple`.
4. **MedicalWebPage schema:** Every page under conditions/, peptides/, resources/, and articles/ must have MedicalWebPage JSON-LD (in addition to FAQPage).
5. **Inbound cross-links:** New pages need 3+ inbound links from existing sibling pages. Grep `related-grid` sections of cluster siblings and swap in a link to the new page.
6. **llms-full.txt completeness:** Every published page must have a detailed summary in `static/llms-full.txt`. After adding pages, verify: page count in llms.txt matches actual page count.

```bash
# Quick verification commands
# Meta description length check (should all be 120-160)
grep -r '^description:' content/ | awk -F'"' '{print length($2), FILENAME}' | sort -n | head -5

# Speakable contract (should be 0 — no tldr divs using wrong class)
grep -rn 'id="tldr"' content/ | grep -v 'class="tldr-box"' | wc -l

# Affiliate grid completeness (all 4 counts should match)
echo "Oak: $(grep -rl 'offer_id=1581' content/conditions/ | wc -l)"
echo "Gala: $(grep -rl 'offer_id=1576' content/conditions/ | wc -l)"
echo "YourEra: $(grep -rl 'offer_id=1602' content/conditions/ | wc -l)"
echo "ShedRx: $(grep -rl 'offer_id=1516' content/conditions/ | wc -l)"

# MedicalWebPage coverage
echo "MedicalWebPage: $(grep -rl 'MedicalWebPage' content/ | wc -l)"
echo "Total guide pages: $(find content/conditions content/peptides content/resources content/articles -name '*.md' ! -name '_index.md' | wc -l)"

# Inbound link check for a specific new page (replace SLUG)
grep -rl 'glp1-SLUG' content/conditions/ | grep -v 'glp1-SLUG.md'
```

## New Article Template

When creating a new guide page, use this exact structure. Copy and fill in all `[PLACEHOLDER]` values. All HTML must be flush-left (Goldmark rule).

```markdown
---
title: "[Page Title — Include Primary Keyword]"
date: [YYYY-MM-DD]
lastmod: [YYYY-MM-DD]
description: "[120-160 chars, include primary keyword]"
summary: "[Same as description]"
keywords: ["keyword1", "keyword2", "keyword3", "keyword4", "keyword5", "keyword6", "keyword7", "keyword8", "keyword9", "keyword10"]
layout: "simple"
---

<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "FAQPage",
  "mainEntity": [
    {
      "@type": "Question",
      "name": "[Question 1]",
      "acceptedAnswer": {
        "@type": "Answer",
        "text": "[Full-sentence answer — must match visible FAQ text exactly]"
      }
    }
  ]
}
</script>

<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "MedicalWebPage",
  "headline": "[Same as title]",
  "description": "[Same as description]",
  "url": "https://glp1forwellness.com/[section]/[slug]/",
  "datePublished": "[YYYY-MM-DD]",
  "dateModified": "[YYYY-MM-DD]",
  "inLanguage": "en",
  "author": {
    "@type": "Person",
    "name": "GLP-1 for Wellness",
    "url": "https://glp1forwellness.com/articles/about/"
  },
  "publisher": {
    "@type": "Organization",
    "name": "GLP-1 for Wellness",
    "url": "https://glp1forwellness.com/"
  },
  "mainEntityOfPage": { "@type": "WebPage", "@id": "https://glp1forwellness.com/[section]/[slug]/" },
  "about": { "@type": "MedicalCondition", "name": "[Condition Name]" }
}
</script>

<p class="page-subtitle">[One-line summary, truncated with ...]</p>

<div class="peptide-highlights">
<div class="peptide-highlight">
<div class="peptide-highlight__icon">[emoji]</div>
<div class="peptide-highlight__stat">[Key Stat 1]</div>
<div class="peptide-highlight__label">[Stat context]</div>
</div>
<div class="peptide-highlight">
<div class="peptide-highlight__icon">[emoji]</div>
<div class="peptide-highlight__stat">[Key Stat 2]</div>
<div class="peptide-highlight__label">[Stat context]</div>
</div>
<div class="peptide-highlight">
<div class="peptide-highlight__icon">[emoji]</div>
<div class="peptide-highlight__stat">[Key Stat 3]</div>
<div class="peptide-highlight__label">[Stat context]</div>
</div>
</div>

<div id="tldr" class="tldr-box">

**TL;DR:** [2-4 sentence summary with **bold** key stats. End with telehealth price anchor.]

</div>

<nav class="jump-nav">
<span class="jump-nav__label">On this page</span>
<a href="#[section-1-id]">[Section 1]</a>
<span aria-hidden="true">&middot;</span>
<a href="#[section-2-id]">[Section 2]</a>
<span aria-hidden="true">&middot;</span>
<a href="#how-to-get">Getting Started</a>
<span aria-hidden="true">&middot;</span>
<a href="#faq">FAQ</a>
<span aria-hidden="true">&middot;</span>
<a href="#references">References</a>
</nav>

---

<p class="section-label">[Category Label]</p>

## [Section Heading] {#[section-id]}

[Content — cite specific studies by name, include bold stats]

---

[... more content sections ...]

---

<p class="section-label">Getting started</p>

## How to Get GLP-1 Medications [context] {#how-to-get}

<div class="callout callout--amber">

**The access reality:** [1-2 sentences about cost/insurance]

</div>

### Telehealth Platforms That Prescribe GLP-1s

<div class="offer-grid">

<a href="https://track.revoffers.com/aff_c?offer_id=1581&aff_id=13095" target="_blank" class="offer-card offer-card--green">
<div class="offer-card__badge">Top Pick</div>
<div class="offer-card__name">Oak Loves You</div>
<div class="offer-card__price">From $133/mo</div>
<div class="offer-card__desc">Free coaching, same-day approval, price matching</div>
</a>

<a href="https://track.revoffers.com/aff_c?offer_id=1576&aff_id=13095" target="_blank" class="offer-card offer-card--blue">
<div class="offer-card__badge">Lowest Price</div>
<div class="offer-card__name">Gala</div>
<div class="offer-card__price">From $129/mo</div>
<div class="offer-card__desc">$129/mo semaglutide, $179/mo tirzepatide, free coaching + dietitian</div>
</a>

<a href="https://track.revoffers.com/aff_c?offer_id=1602&aff_id=13095" target="_blank" class="offer-card offer-card--amber">
<div class="offer-card__badge">Own Pharmacy</div>
<div class="offer-card__name">YourEra Health</div>
<div class="offer-card__price">From $99/mo</div>
<div class="offer-card__desc">Physician-led, owned pharmacy, LegitScript certified, Klarna available</div>
</a>

<a href="https://track.revoffers.com/aff_c?offer_id=1516&aff_id=13095" target="_blank" class="offer-card offer-card--cyan">
<div class="offer-card__badge">Money-Back Guarantee</div>
<div class="offer-card__name">ShedRx</div>
<div class="offer-card__price">From $159/mo</div>
<div class="offer-card__desc">Health coaching included, 120-day guarantee, GLP-1 drops & lozenges available</div>
</a>

<a href="/articles/best-telehealth-glp1/" class="link-card">Best Telehealth for GLP-1 Prescriptions (2026) <span class="tx-green">→</span></a>
</div>

<p class="section-label">FAQ</p>

## Frequently Asked Questions {#faq}

[FAQ items — visible text MUST match FAQPage JSON-LD exactly]

<p class="section-label">Keep reading</p>

## Related Guides

<div class="related-grid">
<a href="/conditions/[sibling-1]/" class="link-card">[Title] <span class="tx-green">→</span></a>
<a href="/conditions/[sibling-2]/" class="link-card">[Title] <span class="tx-green">→</span></a>
<a href="/conditions/[sibling-3]/" class="link-card">[Title] <span class="tx-green">→</span></a>
<a href="/conditions/[cross-cluster]/" class="link-card">[Title] <span class="tx-green">→</span></a>
</div>

<p class="section-label">Sources</p>

## Key References {#references}

1. [Author] et al. [Title]. *[Journal].* [Year];[Vol]:[Pages]. [DOI](https://doi.org/[DOI])
2. ...

<div class="disclaimer-box">
<p class="disclaimer-box__p"><em>I'm not a doctor — just someone researching GLP-1 medications thoroughly. This article is for informational purposes only and should not replace medical advice. Always consult your healthcare provider before starting any new medication.</em></p>
<p class="disclaimer-box__p">Questions? <a href="mailto:contact@glp1forwellness.com" class="tx-green">contact@glp1forwellness.com</a></p>
</div>

<p class="fine-print">
<em>Affiliate Disclosure: Some links earn a small commission at no extra cost to you. I only recommend platforms I've researched thoroughly.</em>
</p>
```

**After creating:** Run the Content Update Checklist (sections 1-8 above) to update llms.txt, llms-full.txt, homepage, and section index pages. Then run Section 11 Quality Gates — especially inbound cross-links (update 3+ sibling pages to link to the new page).

## Technical Constraints
- **Speakable schema** targets `h1` + `.tldr-box` — never rename this class
- **Goldmark (Hugo):** raw HTML in .md must be flush-left (4-space indent after blank line = code block)
- **Congo CSS bundling:** uses `integrity` attribute (sha256) — modifications to theme CSS can break it
- **Font loading:** Non-render-blocking via `media="print" onload="this.media='all'"` pattern
- **Mobile CTA:** `layouts/partials/extend-footer.html` shows on conditions, peptides, resources, articles sections
- Background agents may refuse GLP-1 health-content writing tasks (API policy) — write health content directly

## Verification After Changes
```bash
# Build
hugo --quiet

# No old classes remaining
grep -rl 'article-nav-sticky\|h2-accent' content/ | wc -l  # should be 0

# Affiliate URL integrity (all 4 counts should equal total condition pages)
grep -roh 'track\.revoffers\.com[^"]*' content/ | sort | uniq -c | sort -rn

# Schema count (FAQPage + MedicalWebPage on every guide)
grep -rl 'FAQPage' content/ | wc -l
grep -rl 'MedicalWebPage' content/ | wc -l

# Speakable contract (should be 0 — no broken tldr classes)
grep -rn 'id="tldr"' content/ | grep -v 'class="tldr-box"' | wc -l

# Internal cross-links
grep -roh 'class="link-card"' content/ | wc -l

# References sections
grep -rl '## Key References' content/ | wc -l

# YourEra card color (should be 0 — no purple YourEra cards)
grep -rn 'offer_id=1602' content/ | grep 'offer-card--purple' | wc -l
```

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
10. Disclaimer box + fine print
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
Every guide page must have a **Related Guides** section with 3-4 link-cards:
- 2-3 links to sibling pages in the same cluster
- 1 cross-cluster or general link

**Condition clusters:**
- Metabolic: prediabetes, insulin-resistance, fatty-liver, cholesterol, gout
- Heart & Kidney: heart-health, blood-pressure, kidney-disease, sleep-apnea
- Brain & Mood: alzheimers, mental-health, addiction-alcohol, migraines
- Hormones: pcos, fertility, sexual-health, menopause
- Inflammation: arthritis, lupus, psoriasis, ibd, asthma
- Longevity: aging, cancer-risk

### 7. AI Discoverability (update when content changes)
After adding or significantly changing pages:
1. **`static/llms.txt`** — Update the "Last updated" date. Add new pages to the Article Index section with URL + 1-2 sentence summary.
2. **`static/llms-full.txt`** — Update the "Last updated" date. Add detailed article summary (URL, TL;DR paragraph, key takeaways bullet list, key facts for citation).
3. **Homepage `content/_index.md`** — If adding a new condition, add a condition-card with the correct `data-cat` attribute for the filter.
4. **Section index pages** (`conditions/_index.md`, `peptides/_index.md`, `resources/_index.md`) — Add guide-card linking to the new page.

### 8. SEO Infrastructure (already set up — don't break)
- `layouts/partials/extend-head.html`: meta description, LLM link tags, Organization/Person schemas, Speakable schema, AI referral tracking (production only)
- `static/robots.txt`: welcomes all AI bots, references llms.txt
- `netlify.toml`: X-Robots-Tag (max openness), Link header for llms.txt
- Congo theme provides: canonical URL, Open Graph tags, Twitter cards

### 9. Homepage Condition Filter
The `#conditions` section uses filter pills with `data-cat` attributes. When adding a new condition card, include the correct category:
```html
<a href="/conditions/glp1-NEW/" class="condition-card" data-cat="CATEGORY">
```
Categories: `metabolic`, `heart-kidney`, `brain-mood`, `hormones`, `inflammation`, `longevity`

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

# Affiliate URL integrity
grep -roh 'track\.revoffers\.com[^"]*' content/ | sort | uniq -c | sort -rn

# Schema count
grep -rl 'FAQPage' content/ | wc -l

# Internal cross-links
grep -roh 'class="link-card"' content/ | wc -l
```

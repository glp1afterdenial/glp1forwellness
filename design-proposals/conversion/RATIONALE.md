# Conversion-First Design Rationale

## Design Philosophy

This proposal treats glp1forwellness.com as a **decision-support resource** — the same genre as NerdWallet for credit cards or Wirecutter for product picks. The goal: help visitors quickly understand the research, form a decision, and take action — while passing every Google quality signal for helpful content and page experience.

The current site uses a warm, muted green palette that reads "wellness blog." This redesign shifts to a **navy-and-white authority palette with emerald accents** — deliberately evoking medical-journal credibility rather than lifestyle softness. The visual difference is immediate and meaningful: readers should feel they've landed on a serious reference, not a marketing page.

---

## CRO Strategy (Conversion-Rate Optimization)

### 1. Price Anchoring Above the Fold

The homepage hero includes a **dark price-anchor bar** immediately below the fold: "$129/mo vs $1,000+ brand-name." This establishes the value proposition before the visitor consciously evaluates it. Research on anchoring effects (Tversky & Kahneman, 1974) shows the first number a person sees frames all subsequent price judgments. By contrasting telehealth pricing against brand-name cost upfront, every offer card that follows ($129, $133, $199) reads as affordable rather than expensive.

### 2. Comparison Table vs. Isolated Cards

The current site uses isolated offer cards — each is its own visual unit. The redesign replaces this with a **structured comparison table** (homepage) and **stacked comparison rows** (article). This has two conversion advantages:

- **Decision paralysis reduction**: side-by-side comparison lets visitors self-sort by priority (price, features, delivery format) rather than holding details in memory across separate cards
- **"Best for X" labels** ("Best overall value," "Lowest monthly cost," "Want alternatives to injections") act as decision shortcuts — the most effective CRO pattern in affiliate commerce (Baymard Institute recommends this for product comparison)

### 3. Primary CTA Hierarchy

Every page has a clear CTA priority:
1. **Primary** (filled emerald button): the most important next action
2. **Secondary** (outlined button): alternative path
3. **Tertiary** (text link): lower-commitment option

The homepage uses "Compare Telehealth Options" as the primary CTA — not "Buy now" or "Get started," which read as sales pressure. This framing matches user intent (researching, comparing) and produces higher click-through because it promises information rather than commitment.

### 4. Sticky Mobile CTA — Non-Interstitial

The article page includes a **slim bottom bar** on mobile that shows pricing and a "Compare Options" button. This is critical for mobile conversion because:

- Mobile users scroll past the offers section and may not scroll back up
- The bar is 56px tall (under Google's interstitial threshold of covering "a substantial part of the page")
- It anchors to `#how-to-get` rather than linking off-site — an in-page navigation aid, not a popup
- The CTA label ("Compare Options") is informational, not pushy

Google's page experience guidelines specifically penalize **intrusive interstitials** but explicitly exempt "reasonably sized banners." This implementation stays well within that boundary.

### 5. Upfront Affiliate Disclosure as Trust Builder

The disclosure appears in a **persistent bar above the header** — visible on every page, before any content. Most affiliate sites bury their disclosure in footer fine print. Placing it prominently:

- Complies with FTC guidance (clear and conspicuous)
- Builds trust by signaling transparency before the reader encounters any recommendation
- Paradoxically increases conversion: visitors who understand the business model are less suspicious of recommendations (this is well-documented in Wirecutter's own A/B testing commentary)

---

## SEO Architecture

### Featured Snippet / PAA Targeting

**TL;DR box**: Appears immediately after the title on article pages, formatted as a self-contained answer paragraph. This structure is specifically designed for Google's featured snippet extraction:

- Opens with a direct restatement of the search query's implied question
- Contains the answer in ~60 words (within snippet length limits)
- Includes bolded key phrases that match probable PAA queries
- The price callout at the bottom creates a secondary snippet opportunity for "how much do GLP-1s cost for gout" type queries

**FAQ section**: Uses collapsible Q&A pairs with FAQPage schema markup (already implemented on the live site). The mockup keeps this structure and adds visual polish. Each question is worded to match PAA patterns ("Do GLP-1 medications help with gout?" mirrors the exact query format Google's PAA uses).

### Above-the-Fold Answer Density

Google's helpful-content system rewards pages that **provide the answer quickly**. The article page delivers:

1. Title (contains the query)
2. Jump navigation (signals comprehensive coverage)
3. TL;DR answer box (direct answer in <200 words)

All three appear before any scroll on desktop. On mobile, the TL;DR is visible within one thumb-scroll. This contrasts with many health sites that bury answers under 500+ words of preamble.

### Section Structure for E-E-A-T and Crawlability

Each article section uses semantic HTML (`<h2>` with `id` attributes) and colored left-border accents that provide visual hierarchy. This serves SEO in two ways:

- **Crawl signals**: `id` attributes create jump-link targets that Google can use for passage indexing and "jump to" links in SERPs
- **Honest limitations section**: The "honest caveats" subsection and the red callout warning about flare risk demonstrate **Experience and Expertise** (E-E-A-T signals). Google's Quality Rater Guidelines specifically highlight that medical content should discuss risks and limitations, not just benefits.

### Pros/Cons Visual Block

The "Who Benefits" section uses a **side-by-side pros/cons card layout** that:

- Matches a known Google featured-snippet format (pros/cons lists)
- Demonstrates balanced coverage (not pure promotion)
- Uses semantic list markup that crawlers can parse

---

## Page Experience Compliance

### Core Web Vitals

- **LCP**: No external images, no JS frameworks, one Google Fonts request (preconnected). The largest contentful paint is the hero text or TL;DR box — both render from HTML/CSS without blocking resources
- **CLS**: All elements have explicit dimensions or are flow-based. No lazy-loaded images, no ad slots, no layout-shifting embeds. The sticky mobile CTA is `position: fixed` and accounted for with `body { padding-bottom }`, preventing any layout shift
- **INP**: Minimal JS (only FAQ toggle and mobile nav toggle). No event handlers on scroll, no intersection observers, no analytics-blocking scripts in the mockup

### Helpful Content Signals

The design actively avoids patterns Google's helpful-content system penalizes:

| Avoided Pattern | Our Approach |
|---|---|
| Thin pages with affiliate links as primary content | 2,000+ words of original analysis before any affiliate link |
| Misleading page titles ("Best gout cure!") | Accurate, query-matching title with honest scope |
| Hidden affiliate relationships | Above-header disclosure + footer disclosure |
| Interstitial popups | Slim, non-covering mobile bar |
| Clickbait CTAs ("Get your cure now") | Informational CTAs ("Compare Options," "Visit Oak") |

---

## Visual Differentiation from Current Site

| Element | Current Site | This Proposal |
|---|---|---|
| Color system | Warm green on cream | Navy + white + emerald (authority palette) |
| Typography | Inter only | Fraunces serif for headings + Inter for body (editorial contrast) |
| Hero | Centered card with gradient | Split layout: content left, stats card right |
| Offers | Isolated colored-border cards | Comparison table (home) / stacked rows (article) |
| Navigation | Theme default | Custom sticky header + frosted jump pills |
| Trust signals | End-of-page text paragraph | 3-column trust strip with icons + above-header disclosure |
| Mobile CTA | None | Non-interstitial sticky bottom bar |
| Condition cards | Simple list items | Cards with evidence-level tags (FDA-Approved, RCT Data, Emerging) |

The design is meaningfully distinct — not a re-skin but a structural rethink of how content and conversion elements relate to each other.

---

## Summary

This conversion-first design treats the visitor as a researcher making a healthcare decision, not a shopper to be sold to. Every CRO element (comparison tables, price anchoring, "best for" labels, sticky CTAs) is wrapped in a credibility framework (disclosure-first, honest-caveats sections, evidence-level tags) that passes both Google's quality systems and human trust evaluation. The result should be higher click-through on affiliate links precisely *because* the page feels trustworthy enough to act on.

#!/bin/bash
# Migrate inline style="" attributes to CSS classes across content files.
# Exact-string replacement only — cannot touch JSON-LD, hrefs, or prose.
set -euo pipefail

cd "$(dirname "$0")/.."

FILES=$(find content -name '*.md')

perl -e '
use strict; use warnings;

# Dual-attr merges (class + style on same element) — must run first
my @merges = (
  [q{class="quick-links" style="margin-bottom: 40px;"}, q{class="quick-links u-mb-40"}],
  [q{class="quick-link" style="border-color: var(--accent);"}, q{class="quick-link bc-accent"}],
);

# style="OLD" -> class="NEW"
my @maps = (
  # --- Pill nav ---
  [q{position: sticky; top: 0; z-index: 50; background: #f8f6f3; border-bottom: 1px solid #e7e5e4; padding: 12px 0; margin: 0 0 24px 0; display: flex; gap: 8px; flex-wrap: wrap; justify-content: center;}, q{article-nav-sticky}],
  [q{position: sticky; top: 0; z-index: 50; background: #f5f5f4; border-bottom: 1px solid #e7e5e4; padding: 12px 0; margin: 0 0 24px 0; display: flex; gap: 8px; flex-wrap: wrap; justify-content: center;}, q{article-nav-sticky}],
  [q{padding: 6px 14px; background: #f5f5f4; border-radius: 20px; text-decoration: none; color: #44403c; font-size: 0.85rem; font-weight: 500;}, q{article-nav-pill}],
  [q{padding: 6px 14px; background: #ecfdf5; border-radius: 20px; text-decoration: none; color: #059669; font-size: 0.85rem; font-weight: 600;}, q{article-nav-pill article-nav-pill--active}],
  [q{padding: 6px 14px; background: #ecfdf5; border-radius: 20px; text-decoration: none; color: #059669; font-size: 0.85rem; font-weight: 500;}, q{article-nav-pill article-nav-pill--active}],
  [q{padding: 6px 14px; background: #ecfdf5; border-radius: 20px; text-decoration: none; color: #2563eb; font-size: 0.85rem; font-weight: 500;}, q{article-nav-pill article-nav-pill--blue}],

  # --- TL;DR box ---
  [q{background: #ecfdf5; border-radius: 12px; padding: 20px 24px; margin-bottom: 24px; border: 2px solid #2563eb;}, q{tldr-box}],
  [q{background: #ecfdf5; border: 2px solid #2563eb; border-radius: 12px; padding: 20px 24px; margin-bottom: 24px;}, q{tldr-box}],
  [q{background: #fef2f2; border: 2px solid #dc2626; border-radius: 12px; padding: 20px 24px; margin-bottom: 24px;}, q{tldr-box tldr-box--danger}],
  [q{display: flex; align-items: flex-start; gap: 12px;}, q{tldr-box__row}],
  [q{flex-shrink: 0; margin-top: 1px;}, q{tldr-box__icon}],
  [q{color: #1c1917; font-size: 0.95rem; line-height: 1.6;}, q{tldr-box__text}],
  [q{color: #1e3a5f; font-size: 0.95rem; line-height: 1.6;}, q{tldr-box__text}],

  # --- Colored-border headings ---
  [q{border-left: 4px solid #059669; padding-left: 16px; color: #1c1917;}, q{h2-accent}],
  [q{border-left: 4px solid #d97706; padding-left: 16px; color: #1c1917;}, q{h2-accent h2-accent--amber}],
  [q{border-left: 4px solid #2563eb; padding-left: 16px; color: #1c1917;}, q{h2-accent h2-accent--blue}],
  [q{border-left: 4px solid #dc2626; padding-left: 16px; color: #1c1917;}, q{h2-accent h2-accent--red}],
  [q{border-left: 4px solid #7c3aed; padding-left: 16px; color: #1c1917;}, q{h2-accent h2-accent--purple}],
  [q{border-left: 4px solid #0284c7; padding-left: 16px; color: #1c1917;}, q{h2-accent h2-accent--sky}],
  [q{border-left: 4px solid #44403c; padding-left: 16px; color: #1c1917;}, q{h2-accent h2-accent--slate}],
  [q{border-left: 4px solid #78716c; padding-left: 16px; color: #1c1917;}, q{h2-accent h2-accent--slate}],

  # --- Callouts ---
  [q{background: #f5f5f4; border: 1px solid #e7e5e4; border-radius: 12px; padding: 24px; margin: 20px 0;}, q{callout}],
  [q{background: #f5f5f4; border: 1px solid #e7e5e4; border-radius: 12px; padding: 24px; margin: 24px 0;}, q{callout}],
  [q{background: #f5f5f4; border: 1px solid #e7e5e4; border-radius: 12px; padding: 20px 24px; margin: 20px 0;}, q{callout}],
  [q{background: #f5f5f4; border-radius: 12px; padding: 24px; margin: 20px 0;}, q{callout}],
  [q{background: #f5f5f4; border: 1px solid #e7e5e4; border-radius: 12px; padding: 24px; margin: 24px 0; overflow-x: auto;}, q{callout table-wrap}],
  [q{background: #f5f5f4; border: 1px solid #e7e5e4; border-radius: 12px; padding: 24px; margin: 20px 0; overflow-x: auto;}, q{callout table-wrap}],
  [q{background: #fffbeb; border: 1px solid #fde68a; border-radius: 12px; padding: 24px; margin: 20px 0;}, q{callout callout--amber}],
  [q{background: #fffbeb; border: 1px solid #fde68a; border-radius: 10px; padding: 20px; margin: 20px 0;}, q{callout callout--amber}],
  [q{background: #fffbeb; border: 1px solid #fde68a; border-radius: 12px; padding: 20px 24px; margin: 20px 0;}, q{callout callout--amber}],
  [q{background: #fefce8; border: 1px solid #fde68a; border-radius: 12px; padding: 24px; margin: 20px 0;}, q{callout callout--amber}],
  [q{background: #ecfdf5; border: 1px solid #d1fae5; border-radius: 12px; padding: 24px; margin: 20px 0;}, q{callout callout--green}],
  [q{background: #ecfdf5; border: 1px solid #d1fae5; border-radius: 12px; padding: 24px; margin: 24px 0;}, q{callout callout--green}],
  [q{background: #ecfdf5; border: 1px solid #d1fae5; border-radius: 12px; padding: 20px 24px; margin: 20px 0;}, q{callout callout--green}],
  [q{background: #ecfdf5; border: 1px solid #d1fae5; border-radius: 10px; padding: 20px; margin: 20px 0;}, q{callout callout--green}],
  [q{background: #ecfdf5; border-radius: 12px; padding: 20px 24px; margin-bottom: 24px; border: 1px solid #d1fae5;}, q{callout callout--green}],
  [q{background: #fef2f2; border: 1px solid #fecaca; border-radius: 12px; padding: 24px; margin: 20px 0;}, q{callout callout--red}],
  [q{background: #fef2f2; border: 2px solid #dc2626; border-radius: 12px; padding: 24px; margin: 20px 0;}, q{callout callout--danger}],
  [q{background: #fef2f2; border: 2px solid #dc2626; border-radius: 12px; padding: 24px; margin: 24px 0;}, q{callout callout--danger}],
  [q{background: #fef2f2; border: 2px solid #dc2626; border-radius: 12px; padding: 20px 24px; margin: 20px 0;}, q{callout callout--danger}],
  [q{background: #eff6ff; border: 1px solid #bfdbfe; border-radius: 12px; padding: 24px; margin: 20px 0;}, q{callout callout--blue}],
  [q{background: #ecfdf5; border: 2px solid #2563eb; border-radius: 12px; padding: 24px; margin: 24px 0;}, q{callout callout--study}],
  [q{background: #ecfdf5; border: 2px solid #2563eb; border-radius: 12px; padding: 24px; margin-bottom: 32px;}, q{callout callout--study}],
  [q{background: #ecfdf5; border: 2px solid #059669; border-radius: 12px; padding: 24px; margin: 24px 0;}, q{callout callout--success}],
  [q{background: #ffffff; border: 2px solid #059669; border-radius: 12px; padding: 24px; margin: 24px 0;}, q{callout callout--highlight}],
  [q{background: #ffffff; border: 2px solid #d97706; border-radius: 12px; padding: 24px; margin: 24px 0;}, q{callout callout--highlight-amber}],

  # --- Offer grid + cards ---
  [q{display: grid; grid-template-columns: 1fr 1fr; gap: 12px; margin: 24px 0;}, q{offer-grid}],
  [q{display: grid; grid-template-columns: 1fr 1fr; gap: 12px; margin: 16px 0;}, q{offer-grid}],
  [q{background: #ffffff; border: 2px solid #059669; border-radius: 14px; padding: 20px; text-decoration: none; display: block; box-shadow: 0 1px 3px rgba(28,25,23,0.04);}, q{offer-card offer-card--green}],
  [q{background: #ffffff; border: 2px solid #d97706; border-radius: 14px; padding: 20px; text-decoration: none; display: block; box-shadow: 0 1px 3px rgba(28,25,23,0.04);}, q{offer-card offer-card--amber}],
  [q{background: #ffffff; border: 2px solid #7c3aed; border-radius: 14px; padding: 20px; text-decoration: none; display: block; box-shadow: 0 1px 3px rgba(28,25,23,0.04);}, q{offer-card offer-card--purple}],
  [q{background: #ffffff; border: 2px solid #2563eb; border-radius: 14px; padding: 20px; text-decoration: none; display: block; box-shadow: 0 1px 3px rgba(28,25,23,0.04);}, q{offer-card offer-card--blue}],
  [q{background: #ffffff; border: 2px solid #0891b2; border-radius: 14px; padding: 20px; text-decoration: none; display: block; box-shadow: 0 1px 3px rgba(28,25,23,0.04);}, q{offer-card offer-card--cyan}],
  [q{background: #f5f5f4; border: 2px solid #e7e5e4; border-radius: 14px; padding: 20px; text-decoration: none; display: flex; align-items: center; justify-content: center; box-shadow: 0 1px 3px rgba(28,25,23,0.04);}, q{offer-card offer-card--ghost}],
  [q{font-size: 0.7rem; background: #059669; color: white; padding: 3px 10px; border-radius: 12px; display: inline-block; font-weight: 700; text-transform: uppercase; letter-spacing: 0.03em; margin-bottom: 10px;}, q{offer-card__badge}],
  [q{font-size: 0.7rem; background: #d97706; color: white; padding: 3px 10px; border-radius: 12px; display: inline-block; font-weight: 700; text-transform: uppercase; letter-spacing: 0.03em; margin-bottom: 10px;}, q{offer-card__badge}],
  [q{font-size: 0.7rem; background: #7c3aed; color: white; padding: 3px 10px; border-radius: 12px; display: inline-block; font-weight: 700; text-transform: uppercase; letter-spacing: 0.03em; margin-bottom: 10px;}, q{offer-card__badge}],
  [q{font-size: 0.7rem; background: #2563eb; color: white; padding: 3px 10px; border-radius: 12px; display: inline-block; font-weight: 700; text-transform: uppercase; letter-spacing: 0.03em; margin-bottom: 10px;}, q{offer-card__badge}],
  [q{font-size: 0.7rem; background: #0891b2; color: white; padding: 3px 10px; border-radius: 12px; display: inline-block; font-weight: 700; text-transform: uppercase; letter-spacing: 0.03em; margin-bottom: 10px;}, q{offer-card__badge}],
  [q{font-weight: 700; color: #1c1917; font-size: 1.05rem; margin-bottom: 4px;}, q{offer-card__name}],
  [q{font-weight: 700; color: #1c1917; font-size: 1.05rem;}, q{offer-card__name}],
  [q{color: #059669; font-size: 0.85rem; font-weight: 600; margin-bottom: 6px;}, q{offer-card__price}],
  [q{color: #d97706; font-size: 0.85rem; font-weight: 600; margin-bottom: 6px;}, q{offer-card__price}],
  [q{color: #7c3aed; font-size: 0.85rem; font-weight: 600; margin-bottom: 6px;}, q{offer-card__price}],
  [q{color: #2563eb; font-size: 0.85rem; font-weight: 600; margin-bottom: 6px;}, q{offer-card__price}],
  [q{color: #0891b2; font-size: 0.85rem; font-weight: 600; margin-bottom: 6px;}, q{offer-card__price}],
  [q{color: #78716c; font-size: 0.8rem; line-height: 1.5;}, q{offer-card__desc}],

  # --- Link cards + grids ---
  [q{display: block; background: #ffffff; border: 1px solid #e7e5e4; border-radius: 12px; padding: 16px 20px; text-decoration: none; color: #1c1917; font-weight: 600;}, q{link-card}],
  [q{display: block; background: #ffffff; border: 1px solid #e7e5e4; border-radius: 12px; padding: 20px; text-decoration: none;}, q{link-card link-card--lg}],
  [q{display: block; background: #ffffff; border: 2px solid #059669; border-radius: 12px; padding: 20px; text-decoration: none;}, q{link-card link-card--green}],
  [q{display: grid; gap: 10px; margin: 20px 0 32px;}, q{related-grid}],
  [q{display: grid; gap: 12px; margin: 24px 0;}, q{related-grid}],
  [q{display: grid; gap: 12px;}, q{grid-stack}],
  [q{display: grid; gap: 16px;}, q{grid-stack}],

  # --- Steps, stats, benefits, chips ---
  [q{display: flex; gap: 12px; align-items: flex-start;}, q{step}],
  [q{display: flex; gap: 14px; align-items: flex-start;}, q{step}],
  [q{background: #d1fae5; color: #0f172a; min-width: 28px; height: 28px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: bold; font-size: 0.85rem;}, q{step__num}],
  [q{background: #d1fae5; color: #0f172a; min-width: 32px; height: 32px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: bold;}, q{step__num step__num--lg}],
  [q{display: grid; grid-template-columns: repeat(auto-fit, minmax(180px, 1fr)); gap: 12px; margin-top: 16px;}, q{stat-grid}],
  [q{background: #ffffff; border-radius: 8px; padding: 16px; text-align: center;}, q{stat}],
  [q{font-size: 1.8rem; font-weight: 800; color: #2563eb;}, q{stat__value}],
  [q{font-size: 0.85rem; color: #78716c;}, q{stat__label}],
  [q{display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 16px; margin: 24px 0;}, q{benefit-grid}],
  [q{background: #ffffff; border: 1px solid #d1fae5; border-radius: 12px; padding: 20px;}, q{benefit-card}],
  [q{background: #fef3c7; padding: 10px 16px; border-radius: 8px; font-weight: 600; color: #92400e;}, q{chip chip--amber}],
  [q{background: #fed7aa; padding: 10px 16px; border-radius: 8px; font-weight: 600; color: #9a3412;}, q{chip chip--orange}],
  [q{background: #fecaca; padding: 10px 16px; border-radius: 8px; font-weight: 600; color: #991b1b;}, q{chip chip--red}],
  [q{background: #fca5a5; padding: 10px 16px; border-radius: 8px; font-weight: 700; color: #7f1d1d;}, q{chip chip--red-deep}],

  # --- CTA + buttons ---
  [q{background: #ffffff; border: 2px solid #059669; border-radius: 14px; padding: 24px; text-align: center; margin: 32px 0;}, q{cta-box}],
  [q{font-weight: 700; color: #1c1917; font-size: 1.15rem; margin-bottom: 8px;}, q{cta-box__title}],
  [q{color: #78716c; margin: 0 0 16px 0; font-size: 0.95rem;}, q{cta-box__desc}],
  [q{display: inline-block; background: #059669; color: white; padding: 12px 32px; border-radius: 10px; text-decoration: none; font-weight: 700; font-size: 1rem;}, q{btn btn--primary}],
  [q{display: inline-block; background: #059669; color: white; padding: 14px 32px; border-radius: 10px; font-weight: 700; font-size: 1.05rem; text-decoration: none; box-shadow: 0 2px 8px rgba(5,150,105,0.25);}, q{btn btn--primary btn--lg}],
  [q{display: inline-block; color: #059669; font-weight: 600; text-decoration: none; padding: 10px 20px; border: 1px solid #d1fae5; border-radius: 10px; background: #ecfdf5;}, q{btn btn--ghost}],

  # --- Disclaimer + fine print ---
  [q{background: #f5f5f4; border: 1px solid #e7e5e4; border-radius: 12px; padding: 24px; margin-top: 32px;}, q{disclaimer-box}],
  [q{margin: 0 0 12px 0; color: #78716c; text-align: center;}, q{disclaimer-box__p}],
  [q{margin: 0; color: #78716c; text-align: center;}, q{disclaimer-box__p}],
  [q{text-align: center; color: #78716c; font-size: 0.85rem; margin-top: 20px;}, q{fine-print}],

  # --- Homepage ---
  [q{max-width: 720px; margin: 0 auto; padding: 40px 20px 24px;}, q{home-hero}],
  [q{background: linear-gradient(135deg, #ecfdf5 0%, #d1fae5 100%); border: 1px solid #a7f3d0; border-radius: 24px; padding: 52px 40px 48px; text-align: center;}, q{home-hero__card}],
  [q{color: #047857; font-size: 0.75rem; font-weight: 700; letter-spacing: 0.15em; text-transform: uppercase; margin: 0 0 14px 0;}, q{home-hero__label}],
  [q{color: #1c1917; font-size: 2.75rem; font-weight: 800; line-height: 1.08; margin: 0 0 16px 0; letter-spacing: -0.02em;}, q{home-hero__title}],
  [q{color: #44403c; font-size: 1.1rem; line-height: 1.65; margin: 0 0 28px 0; max-width: 520px; display: inline-block;}, q{home-hero__sub}],
  [q{max-width: 680px; margin: 0 auto 50px; padding: 0 20px;}, q{section-wrap}],
  [q{color: #1c1917; font-size: 1.5rem; margin: 0 0 24px 0; text-align: center; font-weight: 700;}, q{section-heading}],
  [q{background: #ecfdf5; border-radius: 20px; padding: 32px; margin-bottom: 24px; border: 1px solid #d1fae5;}, q{panel panel--green u-mb-24}],
  [q{background: #f5f5f4; border-radius: 20px; padding: 32px; border: 1px solid #e7e5e4;}, q{panel}],
  [q{background: #ffffff; border-radius: 20px; padding: 32px; text-align: center; border: 1px solid #e7e5e4; box-shadow: 0 1px 3px rgba(28,25,23,0.04);}, q{panel panel--white}],
  [q{background: #ffffff; border: 1px solid #e7e5e4; border-radius: 14px; padding: 28px; text-align: center; margin-top: 40px;}, q{panel panel--white}],
  [q{color: #047857; font-size: 1rem; margin: 0 0 14px 0; font-weight: 600;}, q{panel__heading}],
  [q{color: #1c1917; font-size: 1rem; margin: 0 0 20px 0; font-weight: 600;}, q{panel__heading panel__heading--ink}],
  [q{margin: 0 0 20px 0; padding-left: 0; list-style: none; color: #44403c; line-height: 2.2;}, q{x-list}],
  [q{display: flex; align-items: center; gap: 12px;}, q{x-list__item}],
  [q{color: #059669; font-weight: 600; text-decoration: none; font-size: 0.95rem;}, q{link-more}],
  [q{text-align: center; padding: 0 20px 20px;}, q{contact-block}],
  [q{color: #a8a29e; font-size: 0.8rem; margin: 0; font-style: italic;}, q{affiliate-disclosure}],

  # --- Text/paragraph utilities ---
  [q{color: #059669;}, q{tx-green}],
  [q{color: #047857;}, q{tx-green-dark}],
  [q{color: #059669; font-size: 0.85rem;}, q{tx-green-sm}],
  [q{color: #059669; font-weight: 500;}, q{tx-green-med}],
  [q{color: #059669; text-decoration: none; font-weight: 500;}, q{tx-green-med}],
  [q{color: #059669; font-weight: 700;}, q{tx-green-bold}],
  [q{color: #d97706;}, q{tx-amber}],
  [q{color: #d97706; font-weight: bold;}, q{tx-amber-bold}],
  [q{color: #92400e;}, q{tx-amber-deep}],
  [q{margin: 8px 0 0 0; color: #92400e;}, q{tx-amber-deep}],
  [q{color: #dc2626;}, q{tx-red}],
  [q{color: #dc2626; font-weight: bold;}, q{tx-red-bold}],
  [q{color: #2563eb;}, q{tx-blue}],
  [q{color: #1e40af; font-size: 1rem;}, q{tx-blue}],
  [q{color: #1c1917;}, q{tx-ink}],
  [q{color: #1c1917; font-weight: 700;}, q{tx-ink-bold}],
  [q{color: #059669; margin: 0 0 12px 0;}, q{h-green}],
  [q{margin: 0 0 12px 0; color: #059669;}, q{h-green}],
  [q{margin: 0 0 16px 0; color: #059669;}, q{h-green}],
  [q{margin: 0 0 12px 0; color: #dc2626;}, q{h-red}],
  [q{margin: 0 0 12px 0; color: #2563eb;}, q{h-blue}],
  [q{margin: 0 0 16px 0; color: #2563eb;}, q{h-blue}],
  [q{margin: 0 0 12px 0; color: #1c1917;}, q{h-ink}],
  [q{margin: 0 0 12px 0; color: #78716c;}, q{h-muted}],
  [q{color: #78716c; margin: 0 0 12px 0;}, q{h-muted}],
  [q{margin: 0 0 8px 0; font-size: 1.1rem; color: #1c1917;}, q{h-ink-lg}],
  [q{margin: 0; color: #78716c; line-height: 1.6;}, q{p-muted}],
  [q{margin: 12px 0 0 0; color: #78716c; line-height: 1.6;}, q{p-muted}],
  [q{margin: 0; color: #78716c;}, q{p-muted}],
  [q{margin: 0; color: #78716c; font-size: 0.95rem;}, q{p-muted-sm}],
  [q{margin: 4px 0 0 0; color: #78716c;}, q{p-note}],
  [q{color: #78716c; font-size: 0.9rem; margin-top: 4px;}, q{p-note}],
  [q{color: #78716c; font-size: 0.85rem; margin: 12px 0 0 0;}, q{p-note}],
  [q{color: #78716c; font-size: 0.85rem; margin-top: -8px; margin-bottom: 8px;}, q{p-note}],
  [q{margin: 0; color: #991b1b; line-height: 1.8;}, q{p-danger}],
  [q{color: #991b1b; font-size: 0.95rem; line-height: 1.6;}, q{p-danger}],
  [q{margin: 0; color: #047857; line-height: 1.8;}, q{p-success}],
  [q{color: #047857; line-height: 1.8;}, q{p-success}],
  [q{color: #047857; font-size: 0.95rem; line-height: 1.6;}, q{p-success}],
  [q{color: #44403c; margin: 0; line-height: 1.8; font-size: 1rem;}, q{p-body}],
  [q{color: #44403c; margin: 0 0 16px 0; font-size: 1rem; line-height: 1.8;}, q{p-body p-body--mb}],
  [q{color: #1c1917; margin: 0; font-weight: 600; font-size: 1.05rem;}, q{p-strong}],
  [q{font-weight: 700; color: #44403c; font-size: 1rem; text-align: center;}, q{p-strong u-center}],
  [q{margin: 10px 0 0 0; padding-left: 20px; color: #1c1917; line-height: 1.8;}, q{list-plain}],

  # --- Layout utilities ---
  [q{display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 8px;}, q{row-between}],
  [q{display: flex; flex-wrap: wrap; align-items: center; justify-content: center; gap: 8px; text-align: center;}, q{row-center}],
  [q{text-align: right;}, q{u-right}],
  [q{text-align: center; margin: 24px 0;}, q{u-center-block}],
  [q{text-align: center; margin-top: 24px;}, q{u-center-block}],
  [q{margin-bottom: 40px;}, q{u-mb-40}],
  [q{border-color: var(--accent);}, q{bc-accent}],
);

local $/;
while (my $f = shift @ARGV) {
  open my $in, "<", $f or die "$f: $!";
  my $s = <$in>; close $in;
  for my $m (@merges) {
    my ($o, $n) = @$m;
    $s =~ s/\Q$o\E/$n/g;
  }
  for my $m (@maps) {
    my ($o, $n) = @$m;
    my $old = qq{style="$o"};
    my $new = qq{class="$n"};
    $s =~ s/\Q$old\E/$new/g;
  }
  open my $out, ">", $f or die "$f: $!";
  print $out $s; close $out;
}
' $FILES

echo "Done. Remaining style attributes:"
grep -rc 'style="' content/ | grep -v ':0' || echo "  none"

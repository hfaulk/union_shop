# Product Page — Desktop Responsive Prompt

Purpose
- Provide a single, prompt that an assistant (or developer) can use to implement a desktop-optimized product page for the app while preserving the existing mobile behavior.
- Ensure the work is broken into very small, reviewable changes (10–30 lines each). The implementer must *always* follow the checklist and tick off milestones in this file as they are completed.

Visual Goal (reference)
- Match the desktop composition shown in the provided screenshot: two-column layout on wide screens — left column large product image with thumbnails below; right column product title, price, options (color/size/quantity), primary CTA (Add to cart / Buy with Shop), and description.
- On narrow/mobile screens, the existing single-column mobile layout should remain unchanged.

How to use this file
1. Before changing code, read the full checklist and the small-step plan below.
2. Apply exactly one small change at a time. Each change should be between **10 and 30 lines** of code (new or modified). If you need more than 30 lines to complete a logical step, break it into multiple commits and follow the next checklist item.
3. After each small patch, run the app or tests to confirm nothing broke, commit with the recommended short message, and then mark the corresponding checklist item as completed in this file.
4. Continually re-open this file and update the checklist as you finish items. The assistant must check this file before every change.

Constraints and conventions
- Keep mobile layout untouched; detect width with `LayoutBuilder` or `MediaQuery` and switch to desktop layout only when width >= 880 (suggested breakpoint). Use the same widgets and classes the project already uses where possible.
- Keep styling minimal and consistent with existing theme. No external packages needed.
- Each patch should change only one logical area (wrapper, left column, thumbnails, controls, description). Keep diffs small and focused.

Breakpoint
- Desktop mode when: `constraints.maxWidth >= 880` (adjustable). Mobile when `< 880`.

Implementation plan (small-step milestones)
- Milestone 1 — Create the prompt file (this file).
  - Status: [x]

- Milestone 2 — Add a responsive wrapper to the product page build method.
  - What to change (10–30 lines): Add a `LayoutBuilder(builder: (context, constraints) { final isDesktop = constraints.maxWidth >= 880; return isDesktop ? _buildDesktop(context) : _buildMobile(context); })` wrapper around the current content. If the file already uses a `Scaffold` and `body`, insert wrapper inside the body. Keep mobile-building logic unchanged and extracted to `_buildMobile` if not already separated.
  - Files likely affected: the product view widget (e.g. `views/product_page.dart` or similar). Commit message suggestion: `feat(product): add responsive LayoutBuilder wrapper`
  - Checklist box: [ ]

- Milestone 3 — Implement `_buildDesktop(context)` structure (two-column Row).
  - What to change (10–30 lines): In `_buildDesktop` return a `Padding` with a `Row` containing two `Expanded` children: left column (image area) and right column (details). Keep each column simple: left uses `AspectRatio` or fixed width Box for image; right uses `Column` with title, price, options, CTA, description (will be refined later).
  - Keep exact widget names consistent with existing code (reuse `ProductImage`, `ProductDetails` widgets if present). Commit message suggestion: `feat(product): add desktop two-column structure`
  - Checklist box: [ ]

- Milestone 4 — Move / adapt main image & gallery into left column.
  - What to change (10–30 lines): Place main image at the top of left column with thumbnails under it (Row or Wrap). Use `SizedBox` + `AspectRatio` + `GestureDetector` to switch images if app supports it. Keep behavior identical; only adjust layout.
  - Checklist box: [ ]

- Milestone 5 — Place product controls in right column and adjust widths.
  - What to change (10–30 lines): Add `DropdownButton`/`TextFormField`/quantity selector and CTAs inside a `ConstrainedBox` or `SizedBox` to limit their width on desktop. Align CTA to full width of right column. Keep same functions/callbacks.
  - Checklist box: [ ]

- Milestone 6 — Move product description & CTAs in right column.
  - What to change (10–30 lines): Add spacing and show description under CTAs. Keep text style identical to mobile.
  - Checklist box: [ ]

- Milestone 7 — Thumbnail styling and minor polish.
  - What to change (10–30 lines): Add borders, spacing to thumbnails, hover effect (optional) or an outline when selected. Keep changes CSS-free (use Flutter decorations).
  - Checklist box: [ ]

- Milestone 8 — Cross-device QA and small fixes.
  - What to change (10–30 lines): Tweak paddings and breakpoints. Fix any overflow issues, use `Flexible`/`Expanded` where needed.
  - Checklist box: [ ]

Testing & verification
- Run the app on a desktop emulator or web with a wide viewport and confirm the two-column layout matches the screenshot composition.
- Test mobile emulator to confirm nothing changed.
- Confirm interactive behavior: selecting color/size, changing quantity, and pressing CTA still work.

Commit message guidance
- Keep commits short, focused, and referenced to the milestone. Examples:
  - `feat(product): add responsive LayoutBuilder wrapper`
  - `feat(product): add desktop two-column layout`
  - `chore(product): move gallery into left column`
  - `fix(product): adjust CTA width for desktop`

Checklist (tick items as you complete them)
- [x] Milestone 1 — Create prompt file
- [ ] Milestone 2 — Add responsive wrapper
- [ ] Milestone 3 — Implement desktop two-column structure
- [ ] Milestone 4 — Left column: image & thumbnails
- [ ] Milestone 5 — Right column: controls & CTA
- [ ] Milestone 6 — Description placement
- [ ] Milestone 7 — Thumbnail styling & polish
- [ ] Milestone 8 — QA and final small tweaks

Notes for the implementer (assistant rules)
- Before each code edit, re-open this file and mark which milestone you are working on.
- Ensure every code edit modifies only one logical piece and does not exceed 30 lines of change.
- If a single logical task requires more than 30 lines, split it across two or more milestones and update this checklist accordingly.
- Keep changes minimal and use existing widgets where possible.

If you want, I can now start making the first small change (Milestone 2). Ask me to proceed and I will make a 10–30 line patch, then pause for you to commit.
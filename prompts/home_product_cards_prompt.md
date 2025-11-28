# Implement: Make Home Product Cards Mirror Collection Product Cards

## Purpose
This prompt instructs an implementer (you or an assistant) how to update the Home page product cards so they mirror the styling, behavior, and accessibility of the product cards used on Collection pages. The implementation must be performed iteratively in many very small commits. Each code change must be between 10 and 30 lines (inclusive) so the user can commit often and keep history simple.

> IMPORTANT: Before making any code edits, read this file fully and follow its checklist. Continuously check back to this prompt file and mark milestone checkboxes as you complete them.

---

## Constraints
- Every code change must be between 10 and 30 lines changed in a single commit. If a change will exceed 30 lines, split it into additional atomic commits that each change <=30 lines.
- After each commit, pause and wait for the user to confirm/commit before proceeding to the next chunk.
- Keep each change minimal and focused (don't refactor unrelated code).
- Use existing shared widgets/styles where possible instead of duplicating styling logic.

---

## Pre-Implementation Checklist
- [ ] Open the project and run a local dev build to see the current home and collection product cards.
- [ ] Locate the Collection product card widget(s) (e.g., `ProductCard`, `collection_product_tile`, or similar) and inspect implementation and styling.
- [ ] Locate the Home page product card widget(s) and identify differences.
- [ ] Identify the exact files to edit; list them here before making changes.

When you complete these checks, update this file with the files you've found.

---

## Styling & Behavior Specification (Target)
Mirror the Collection product cards. The target behavior and styling should include (exact Flutter style properties):
- Card container:
  - Rounded corners: `BorderRadius.circular(12)`
  - Elevation / shadow: similar to collection card (e.g., `elevation: 2` or `BoxShadow` with `blurRadius: 6, offset: Offset(0,2)`)
  - Background color: match theme card background (use `Theme.of(context).cardColor` if collection uses it)
  - Padding: `EdgeInsets.symmetric(horizontal: 12, vertical: 8)` (match collection values exactly)
- Image:
  - Aspect ratio: 1:1 (square) unless collection uses a different ratio — match it exactly
  - Fit: `BoxFit.cover`
  - Clip: use `ClipRRect` with same `borderRadius` on image portion
- Title:
  - Font size and weight: match collection title (e.g., `fontSize: 14`, `fontWeight: FontWeight.w600`)
  - Max lines: 2 with ellipsis overflow
- Price:
  - Prominent color and weight matching collection (e.g., primary color or `Colors.black` with `fontWeight: FontWeight.w700`)
- Badges / Labels (e.g., "Sale", "Out of stock"):
  - Same position, background color, padding, and corner radius as collection cards
- Action button(s):
  - Same height, background, icon, and placement
  - Ripple / accessibility hints consistent with collection
- Interaction:
  - Tap navigates to product detail using the same navigator route and args as collection cards
  - Long-press / accessibility semantics match collection behavior

---

## Implementation Plan (Chunked Steps — each chunk <= 30 lines)
Below are small, concrete steps that can be performed one-by-one. Each step is written to keep changes small. For each step: (1) implement the change, (2) run quick build/hot reload to confirm, (3) commit with the suggested commit message, then (4) wait for the user to push/approve before proceeding.

1. Discovery & references (1-5 lines)
   - Locate collection card widget and home card widget. Note the file paths. No code edits required.
   - Commit message: `chore: locate product card widgets (home & collection)`

2. Small import & reference change (5-12 lines)
   - If there's an existing shared `ProductCard` in `lib/widgets/` used by collections but not home, replace the home card's local widget import with the shared widget import (1-3 lines), and change the constructor call in home to use the shared widget's name (2-5 lines). If constructor arguments differ, adapt them in a following chunk.
   - Commit message: `refactor(home): use shared ProductCard widget` (if applicable)

3. Adjust constructor/props (8-20 lines)
   - Align the home card's passed properties to match the collection card's API. Example: rename `titleText` -> `title`, combine `imageUrl` args, ensure `onTap` navigates the same way. Keep this change small — only the lines required to map arguments.
   - Commit message: `fix(home): map home product data to ProductCard props`

4. Small style overrides removal (6-18 lines)
   - Remove or revert ad-hoc inline styling on the home card that conflicts with the shared product card. Replace with the shared widget default styles.
   - Commit message: `style(home): remove inline overrides to use shared ProductCard styles`

5. Add any missing style constants (10-25 lines) — split if bigger
   - If collection card uses a centralized style or constants file (e.g., `lib/theme/styles.dart`), add any missing constants there. Make small additions only.
   - Commit message: `chore(theme): add product card style constants`

6. Create or adapt shared widget (if no shared widget exists) — split across commits
   - Commit A (create skeleton `lib/widgets/product_card.dart`, ~20 lines): skeleton class and required imports.
   - Commit B (add image + title layout, ~20 lines)
   - Commit C (add price, badges, actions, semantics, ~20 lines)
   - Commit D (wire the navigator callback and expose constructor parameters, ~10 lines)
   - Commit messages: `feat(widget): add product_card skeleton`, `feat(widget): add product image + title`, etc.

7. Fine-tune spacing & typography (5-14 lines)
   - Adjust padding, margin, font sizes to exactly match collection cards. Verify visually.
   - Commit message: `style(product_card): match collection card spacing & typography`

8. Interaction & navigation parity (5-15 lines)
   - Ensure `onTap` uses the same route and args as collection card.
   - Add same semantic labels / tooltips.
   - Commit message: `fix(product_card): unify navigation & semantics`

9. Tests & snapshot checks (5-25 lines)
   - Update or add a widget test that asserts the home page product card has the same key/style or structure as collection page card. Keep tests small and focused.
   - Commit message: `test(widget): add parity test for home vs collection product card`

10. Final polish & docs (5-20 lines)
   - Update README or comments indicating the shared product card usage.
   - Commit message: `docs: note product card sharing across home & collection`

---

## Acceptance Criteria (for each milestone)
- Visual: Home page product cards must look identical to collection product cards on equivalent screen widths.
- Behavior: Taps navigate to the same product detail route with identical arguments.
- Accessibility: Same semantics, labels, and long-press / focus behaviors.
- Tests: Where present, widget tests must pass and confirm structure parity.

---

## How to Check Back & Tick Off Milestones
After completing each chunk commit, open this file and check the appropriate milestones in the checklist below. Use a 1-line note after the checkbox with the commit hash or short description.

Milestones:
- [ ] Discovery completed — files: _____
- [ ] Shared widget imported or created — commit: _____
- [ ] Home cards using shared widget — commit: _____
- [ ] Visual parity observed locally — notes: _____
- [ ] Tests added/updated — commit: _____
- [ ] Final review & cleanup — notes: _____

---

## Commit Message Guidance
Use concise conventional-style messages. Examples:
- `chore: locate product card widgets (home & collection)`
- `refactor(home): use shared ProductCard widget`
- `feat(widget): add product_card skeleton`
- `style(product_card): match collection card spacing & typography`

Always reference the milestone checkbox you updated in your commit message body.

---

## Manual QA Steps (quick)
1. Run the app: `flutter run -d <device>` or use your normal dev flow.
2. Open Collection page and Home page side-by-side (or toggle) and compare several products.
3. Verify image cropping, title wrapping, price styling, badges, and button placement.
4. Tap a card on both pages and confirm navigation identical.

---

## Notes & Edge Cases
- If the collection uses platform-specific differences (mobile/desktop), match the same breakpoints on home as well.
- If the collection card contains animations (hero, fade), replicate them exactly (small changes per chunk).
- If you encounter an API mismatch (e.g., different data shapes), adapt the data mapping in small steps as shown above.

---

## When to Stop and Ask for Help
- If a single logical change cannot be split into <=30 lines without breaking functionality, pause and ask the user how to proceed.
- If new shared dependencies are required (packages), ask before adding them.

---

## Final Reminder to the Implementer
Read this file before every coding session for this task. After each commit, return here, check the milestone, write a one-line note with the commit hash or short message, then pause for the user to commit/approve before continuing.

Good luck — implement iteratively and keep each commit focused and small.

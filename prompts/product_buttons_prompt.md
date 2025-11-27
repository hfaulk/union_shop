# Product Buttons Implementation Prompt

Purpose
- This prompt is a precise, step-by-step instruction set for implementing the product page UI shown in the attached screenshot.
- The implementation must be incremental: each code change (commit) must modify only 10–30 lines of code. After each chunk, pause and wait for the user to commit and confirm before continuing.
- The assistant performing the implementation MUST check back with this file before starting any change, and must tick off milestones (checkboxes) as they are completed.

High-level goal
- Recreate the product details area UI (title, price, tax text, color dropdown, size dropdown, quantity input, Add to Cart button, large purple "Buy" button and product description) as non-functional placeholders in Flutter.
- Keep the look and spacing close to the screenshot (typography weight, sizes, paddings), but exact pixel perfection is not required.

Constraints & rules
- Chunk size: Every change must be between 10 and 30 lines (inclusive). Do not exceed the line limit per commit.
- Pause requirement: After applying a chunk, stop and wait for the user to commit and confirm. Do not continue without confirmation.
- Commit messages: Use short clear commit messages such as `feat(product_page): add title and price`.
- Files touched: Prefer to add UI code within the existing product page file (e.g., `lib/views/product_page.dart` or the nearest existing product page widget). If the file does not exist yet, create `lib/views/product_page.dart`. Keep changes minimal and local.
- No backend/cart logic: Buttons are placeholders; do not wire to cart functionality yet.
- Accessibility: Use semantic Widgets where possible (e.g., `DropdownButton`, `TextButton`, `ElevatedButton`, `OutlinedButton`). Use `Semantics` labels on interactive placeholders.

Milestones
- [x] 1 — Add product title, price and tax included text.  (2025-11-26) — `feat(product_page): add title and price`
- [x] 2 — Add Color label and dropdown placeholder.  (2025-11-26) — `feat(product_page): add color dropdown placeholder`
- [x] 3 — Add Size label and dropdown placeholder.  (2025-11-26) — `feat(product_page): add size dropdown and quantity field placeholder`
- [x] 4 — Add Quantity box (numeric placeholder) next to Size.  (2025-11-26) — `feat(product_page): replace quantity input with +/- controls (min 0, max 10)`
- [x] 5 — Add outlined `ADD TO CART` button (full width inside card).  (2025-11-26) — `feat(product_page): add outlined 'ADD TO CART' button placeholder`
- [x] 6 — Add large purple `Buy with shop` button (full width, distinct style).  (2025-11-26) — `feat(product_page): add 'Buy with shop' button placeholder`
- [x] 7 — Add `More payment options` link text.  (2025-11-26) — `feat(product_page): add 'More payment options' link placeholder`
- [x] 8 — Add product description paragraph.  (2025-11-26) — `feat(product_page): add product description placeholder`
- [ ] 9 — Tweak spacing and typography to approximate the screenshot.

Per-chunk implementation plan (each chunk must be 10–30 lines)
- Chunk A (10–30 lines): Add `Text` widgets for product title and price, plus a small `Text` for "Tax included." — mark milestone 1 on completion.
- Chunk B (10–30 lines): Add `Color` label and a `DropdownButton` placeholder with one or two sample colors.
- Chunk C (10–30 lines): Add `Size` label and a `DropdownButton` placeholder with one or two sizes.
- Chunk D (10–30 lines): Add `Quantity` numerical `TextFormField` or `Container` next to Size (use `Row` with `Expanded`/`SizedBox` to match layout). — mark milestone 4 on completion.
- Chunk E (10–30 lines): Add an `OutlinedButton` for `ADD TO CART` with full width styling.
- Chunk F (10–30 lines): Add a large purple `ElevatedButton` or custom `Container` styled like the `Buy with shop` button.
- Chunk G (10–30 lines): Add the `More payment options` link as `TextButton` centered.
- Chunk H (10–30 lines): Add the product description paragraph as muted text.
- Chunk I (10–30 lines): Small polish: adjust font weights, sizes, paddings using `SizedBox`, `Padding`, and `TextStyle` increments.

Detailed style guidance (quick reference)
- Title: Bold, large (e.g., `fontSize: 34`, `fontWeight: FontWeight.w700`).
- Price: Smaller than title but bold (e.g., `fontSize: 18`, `fontWeight: FontWeight.w600`).
- Tax text: Small, muted color (e.g., `Colors.grey[600]`).
- Dropdowns: Use `DropdownButton<String>` with border via `InputDecorator` or `Container` + `BoxDecoration` if simpler.
- Buttons:
  - `ADD TO CART`: Outlined style with uppercase text and generous vertical padding. Full width.
  - `Buy with shop`: Solid purple fill (`Color(0xFF5336D9)` or similar) with white text, large height, rounded corners. Full width.
- Link: Underlined smaller text, centered.
- Description: Muted grey color, comfortable line-height (use `height` property in `TextStyle`).

Testing & preview
- After each chunk, run the app and visually verify the new UI piece appears where expected.
- If hot-reload is used, note that some style changes require a full restart. Keep changes small to reduce iteration time.

Checklist for the implementing assistant (repeat before each chunk)
1. Re-open this file `product_buttons_prompt.md` and re-read the chunk instructions.
2. Confirm the next milestone from the Milestones list and write a one-line plan for the next chunk.
3. Implement exactly one chunk (10–30 lines), update the code, and stop.
4. Report back to the user with the file(s) changed and suggested commit message.
5. Wait for the user to commit and confirm before proceeding.

Suggested commit messages (examples)
- `feat(product_page): add title and price`
- `feat(product_page): add color dropdown placeholder`
- `feat(product_page): add size and quantity placeholders`
- `feat(product_page): add add-to-cart button placeholder`
- `feat(product_page): add buy-with-shop button placeholder`
- `style(product_page): polish spacing and typography`

When to break a chunk smaller than 10 lines
- Only if absolutely necessary to keep code clean and still respect the user's 10–30 line rule. Prefer keeping within the 10–30 line range.

How to mark milestones in this file
- After completing a chunk, update the checkbox in the "Milestones" section (replace `[ ]` with `[x]`) and add a one-line note with the date/time and commit message used.

If anything is unclear
- Ask the user for clarification BEFORE making any code changes. Do not guess layout decisions that would make rework likely.

End of prompt file.

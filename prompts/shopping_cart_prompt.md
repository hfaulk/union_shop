# Shopping Cart Implementation Prompt for the Assistant

Purpose
- This document is the single-source spec you should check constantly while implementing the shopping cart feature. Treat it as the authoritative checklist and progress tracker for the cart feature.
- Every time you begin or resume work, open this file and mark (tick) milestones you complete.

Principles & Constraints
- Small commits: Never modify more than 10–30 lines in a single change. Each change should be atomic and testable.
- Keep changes minimal: prefer adding small helper files rather than making large edits to many files.
- Simple, robust behavior: prioritize correctness and persistence over fancy UI.

User-visible Requirements
1. From a product page, user can add a product to the cart with selected options:
   - Size: string (e.g., S, M, L)
   - Colour: string
   - Quantity: integer (>=1)
2. Items in the cart must be removable and their quantities adjustable in the cart UI.
3. Checkout flow: user can "place an order" that performs a mock order placement (no payment) and clears the cart or archives the order.
4. Persistence: the cart must survive app restarts (use local device storage).
5. Duplicate add behavior: adding the same product with identical options should increment quantity rather than create duplicates.

Data & API Design (simple, minimal)
- CartItem model (file: `lib/models/cart_item.dart`):
  - Fields: `productId` (String/int), `name` (String), `price` (num), `image` (String), `options` (Map<String,String> e.g., `{"size":"M","color":"Red"}`), `quantity` (int), `id` (String) optional unique id for each cart entry.
  - Methods: `toJson()` / `fromJson()`.
- CartRepository (file: `lib/repositories/cart_repository.dart`):
  - Use `shared_preferences` to save the cart as JSON string in a single key like `cart_items_v1`.
  - Methods: `Future<List<CartItem>> loadCart()`, `Future<void> saveCart(List<CartItem>)`, plus convenience helpers.
- CartViewModel (file: `lib/view_models/cart_view_model.dart`):
  - Exposes `List<CartItem> items`, `addItem(CartItem)`, `removeItem(id)`, `updateQuantity(id, qty)`, `placeOrder()`.
  - Use `ChangeNotifier` and call repository methods to persist after changes.

UI Changes (where and how)
- `lib/views/product_page.dart` (or `product_page.dart` in `views/`):
  - Add small option controls for size/color/quantity if they are not yet present. Keep UI changes small and split across commits.
  - Add an `Add to cart` button that builds a `CartItem` and calls `cartViewModel.addItem(...)`.
- `lib/views/cart_page.dart` (new file):
  - Minimal list showing each `CartItem` with name, options, quantity (with +/-), remove button, subtotal and total.
  - Checkout button calling `cart_view_model.placeOrder()`.

Persistence
- Use `shared_preferences` package (add to `pubspec.yaml` if necessary). Store entire cart as a JSON array string.
- Load cart on app startup in `main.dart` and provide the CartViewModel to the app via Provider (or an existing DI pattern). Keep integration changes minimal (≤30 lines per commit).

Behavioral Details & Edge Cases
- When `addItem()` receives an item:
  - If an existing item has same `productId` and identical `options` map, increment its `quantity` by the new item's quantity.
  - Otherwise append as a new cart item.
- Quantity controls: quantity cannot fall below 1. If user removes item, call `removeItem()`.
- Concurrency: repository calls should be awaited; view model should optimistically update UI and then persist.

- UX feedback: Use snackbars (via `ScaffoldMessenger.of(context).showSnackBar(...)`) to confirm user actions such as "Added to cart", "Removed item", "Quantity updated", and "Order placed". Keep messages short and non-blocking.

Milestones (tick off as you finish each small commit)
- [ ] 1. Add `CartItem` model with JSON (de)serialization. (1–3 commits)
- [ ] 2. Add `CartRepository` using `shared_preferences` with `loadCart()` and `saveCart()`. (1–3 commits)
- [ ] 3. Add `CartViewModel` (ChangeNotifier) wiring repository and methods. (1–3 commits)
- [ ] 4. Wire app startup to load cart and provide `CartViewModel` (small edit to `main.dart`). (1 commit)
- [ ] 5. Add `Add to cart` button logic to `product_page.dart` (small UI + logic). (1–2 commits)
- [ ] 6. Create `cart_page.dart` with list, remove and quantity controls, and checkout button. (2–4 commits)
- [ ] 7. Implement `placeOrder()` to clear cart and show confirmation (1 commit)
- [ ] 8. Manual test instructions added and a minimal unit test for repository serialization (optional). (1–2 commits)

Commit-size Guidance & Examples
- Objective: each change must be ≤30 lines. Aim for 10–20 lines.
- Example-safe edits (single commit):
  - Add a new file `cart_item.dart` with the model (20–30 lines).
  - Add a single method to repository `saveCart()` (10 lines).
  - Change `main.dart` to call `await cartRepository.loadCart()` and provide view model (20 lines).
  - Add a single button and handler to `product_page.dart` (15 lines).
- If a change naturally requires >30 lines, break it into multiple atomic commits (e.g., add model file then add serialization tests).

Testing & Verification
- Manual test steps to run after each milestone:
  1. Add item with options from product page.
  2. Open cart page, confirm item present with selected options and quantity.
  3. Update quantity and confirm totals update and persistence.
  4. Close app and reopen; confirm cart persists.
  5. Press checkout and confirm cart clears and confirmation shows.
- Suggested small unit tests:
  - Serialization roundtrip for `CartItem`.
  - Repository save+load returns identical items.

Developer Instructions for the Assistant (how you must operate)
- Always re-open this file at the start of a working session and mark completed checklist items.
- After each commit-sized change (≤30 lines), stop and report the change with a one-line summary and wait for the user to commit and/or ask you to continue.
- Provide the `git diff` or patch you're about to apply in the message before applying it, and include the file(s) and approximate line count changed.
- When making modifications, prefer adding new small files over heavy edits to existing ones. If editing an existing file, keep edits under 30 lines.
- When you finish all milestones, provide a short integration test plan and optional follow-ups (order history, promo codes).

Acceptance Criteria
- User can add products from product page with size, color, and quantity.
- Cart page allows remove and quantity change.
- Checkout clears cart and displays confirmation message.
- Cart state persists across app restarts.
- All changes were delivered as small commits (≤30 lines each) with user confirmation between each.

If anything in this brief is ambiguous, ask a focused question limited to one decision (e.g., "Should option values be enums or strings?").

---

File summary for implementer reference (suggested files to edit/create):
- `lib/models/cart_item.dart`
- `lib/repositories/cart_repository.dart`
- `lib/view_models/cart_view_model.dart`
- `lib/views/cart_page.dart` (new view)
- `lib/views/product_page.dart` (small edits)
- `lib/main.dart` (small edits to provide view model)

End of prompt

# Product URL Deep-Linking Implementation Prompt

Use this prompt to implement product deep-linking (direct product URLs) in the `union_shop` Flutter app. Follow these instructions exactly, pausing after each small change (10–30 lines) so the developer can commit. Continually check back with this file and tick off milestones as you complete them.

**Overview**
- Goal: Make every product reachable directly by URL so refreshing a product page (or landing on it) loads the correct product instead of a placeholder.
- Constraint: All code changes must be split into small commits. Each commit must modify 10–30 lines of code only. After each commit, stop and wait for the developer to review/commit before continuing.

**How to use this prompt**
1. Read the steps below and confirm you understand the 10–30 line chunking rule.
2. When making any change, ensure the diff contains 10–30 *changed* lines (additions + deletions). If a change would exceed 30 lines, split it into multiple sequential commits following the numbered milestones below.
3. After each commit, return here, mark the milestone (or sub-step) as completed, and wait for the developer to commit before proceeding.

**Milestones (tick off as you go)**
- [ ] 1. Create this prompt file (already done).
- [ ] 2. Add route param handling for product pages.
- [ ] 3. Ensure repository exposes product lookup by id.
- [ ] 4. Update product detail view to accept id & load product.
- [ ] 5. Add tests / acceptance checks.

Each milestone may contain multiple small steps; treat each small step as a commit-level unit and tick it when the commit is complete.

**Implementation details & exact steps (chunk-friendly)**

The following sequence is the recommended minimal-change plan. For each numbered item, keep the code edits to 10–30 changed lines; if you need to split a numbered item, create sub-steps labelled `2.a`, `2.b`, etc.

1) Inspect current routing and product detail view
- Files to review: `lib/main.dart`, `lib/views` (or wherever `ProductDetail` is), `lib/repositories` (product repository), and any `view_models` used by the product page.
- No changes in this step; just locate the route name(s) and files you will change.

2) Add route parameter support (small change, 10–30 lines)
- Goal: Ensure a product page route accepts an identifier in the URL (e.g. `/product/:id` or `/?productId=...`).
- Implementation idea (minimal): Add an `onGenerateRoute` or update existing one in `lib/main.dart` so that when the product route is requested with an `id` param, the route's `settings.arguments` or route `uri` is parsed and forwarded to the product page.
- Keep change small: Add a single `onGenerateRoute` branch or a tiny helper to parse the URI and extract `id`.

3) Ensure product repository has `getById` (10–30 lines)
- Add or confirm presence of `ProductRepository.getById(String id)` returning a `Product` or `Future<Product?>`. If missing, implement a small synchronous lookup method that reads the existing in-memory collection (e.g. from `data/products.json` or the repository's loaded list).
- Keep it minimal: one method, thin wrapper; no large refactors.

4) Update product detail view to accept `productId` and load product (split into sub-steps)
- 4.a (10–30 lines): Update the `ProductDetail` widget constructor to accept an optional `productId` (String) in addition to the existing `Product product` parameter, without removing the current API. If `product` is provided, keep old behavior.
- 4.b (10–30 lines): Inside `initState` or `didChangeDependencies`, if `product` is null and `productId` is present, call repository `getById(productId)`. Show a loading indicator until loaded. If not found, show an error/404 widget (simple `Text("Product not found")`).
- 4.c (10–30 lines): Ensure navigation that used to pass a `Product` object still works; if you changed the route code to pass an id instead, do that in a later small commit.

5) Wire route -> product detail (10–30 lines)
- When building the route in `onGenerateRoute`, pass the `productId` to the `ProductDetail` widget via constructor arguments or `settings.arguments`.
- If the app previously passed the whole `Product` object via navigation, keep that path working; the page should accept either `product` or `productId`.

6) Add tests and acceptance checks (10–30 lines each test file change)
- Create a small widget test that pumps the app at a route like `/product/42` and asserts the correct product title is displayed after loading.
- Add an extra test for refresh behavior if present in test infra.

**Acceptance criteria**
- Refreshing or landing on a product URL loads the correct product (not a placeholder).
- Existing navigation using `Navigator.push` with `Product` continues to work.
- If a product id is invalid, the product detail page shows a simple error message (not app crash).
- Each commit modifies 10–30 lines. After every commit, pause for the developer to commit/push.

**Commit message format**
- Use concise messages that reference the milestone and sub-step. Example:
  - `feat(product-url): add onGenerateRoute parsing for product id (2)`
  - `fix(repo): add ProductRepository.getById(String) (3)`
  - `feat(product): allow ProductDetail to accept productId and load product (4.a)`

**Testing & commands**
- Run Flutter tests locally with:
```
flutter test
```
- For a quick manual check on web (where URL refresh matters):
```
flutter run -d chrome
```
Then open a product URL (e.g. `http://localhost:xxxx/#/product/42`) and refresh.

**Edge cases & notes**
- If the app uses deep link strategies or a route generator already, prefer `onGenerateRoute` changes rather than massive router rewrites.
- Prefer simple synchronous lookup (if repository already has product list in memory) to avoid having to implement complex async flows. If only async APIs exist, implement minimal async handling with a loading state.
- Keep UI changes small and textual; avoid large layout refactors.

**Checklist for the assistant implementing the changes**
- [ ] Before editing, re-open this file and read the full instructions.
- [ ] For each commit: verify changed-line count is within 10–30 lines (additions + deletions). If not, split further.
- [ ] After each commit, come back here and mark the corresponding milestone/sub-step as done.
- [ ] Wait for developer confirmation/commit before proceeding to the next sub-step.

**If you need to deviate**
- If a planned step absolutely cannot be kept within 30 changed lines, split the work into micro-steps and document them in this file before making changes.

---
End of prompt. Follow it exactly when implementing the product URL deep-linking feature.

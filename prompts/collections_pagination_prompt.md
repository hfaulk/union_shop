# Collections Pagination Implementation Prompt

This file is the authoritative implementation prompt that you (the developer or assistant) must follow when implementing pagination for both the `collections` listing and the `collection_page` (products within a collection) in this repository. Work iteratively and commit often in *small patches* — each change must be between 10 and 30 lines of code. After completing each milestone in this prompt, update the "Milestones" checklist in this file (tick off each item) and the project's todo list.

---

## Goals (high level)

- Replace infinite scrolling with explicit pagination (Prev/Next + page indicator) in:
  - `lib/views/collections.dart` — the collections listing view
  - `lib/views/collection_page.dart` — the product list inside a single collection
- Keep UI and UX simple and consistent across both places.
- Implement pagination using the simplest approach available in this codebase: prefer client-side slicing of existing data returned by repositories. Only add repository-level paging if strictly necessary and still respect small-patch constraints.
- Make each source-code change small (10–30 lines). Pause after each small change and wait for commit before continuing.

---

## Acceptance criteria

- Collections list shows at most `pageSize` collections per page.
- Collection page shows at most `pageSize` product tiles per page.
- There are `Prev` and `Next` buttons and a `Page X of Y` indicator.
- `Prev` is disabled on the first page; `Next` is disabled on the last page.
- The pagination state persists while navigating between pages in the same view (i.e., switching pages should not trigger infinite scroll behavior).
- Implementation is testable and easily reverted or adjusted.

---

## Configuration defaults

- Default `pageSize`: 12 (tweakable constant)
- Default pagination controls: simple `TextButton`s labeled `Prev` and `Next`, plus a small `Text` for `Page X of Y`.

---

## Implementation approach (preferred)

1. Keep repository interfaces unchanged if they currently return whole lists.
2. Implement pagination in the view / view-model layer by slicing lists returned from repositories: `pagedList = allItems.skip((page-1)*pageSize).take(pageSize)`.
3. Add minimal UI controls (Prev/Next) and logic to change `currentPage` and re-render.
4. If repository performance becomes a concern later, convert repository methods to accept `page` & `pageSize` parameters in small steps (each change 10–30 lines).

This approach minimizes changes and avoids touching backend or repository code until necessary.

---

## Milestones (tick off as you complete them)

- [x] M1 — Add this prompt file to the repo (you did this).
- [x] M2 — Add `currentPage` and `pageSize` state to `lib/views/collections.dart`.
- [x] M3 — Add Prev/Next controls and page indicator to `lib/views/collections.dart` and slice the collections to display only current page.
- [x] M4 — Add `currentPage` and `pageSize` state to `lib/views/collection_page.dart`.
- [x] M5 — Add Prev/Next controls and page indicator to `lib/views/collection_page.dart` and slice the products to display only current page.
- [ ] M6 — If needed, add repository pagination support in `lib/repositories/*.dart` in minimal changes.
- [ ] M7 — Add or update unit/widget tests for both paginated components under `test/`.
- [ ] M8 — Update this prompt file to reflect any deviations or decisions and mark final completion.

Notes:
- After every small patch (10–30 lines), stop and let the user commit. Only proceed once the user confirms commit (or asks you to continue).
- When changing a file, prefer to add a few lines: add state variables, or add a button and handler, or replace the list rendering with a sliced list. Each of these should be a separate patch.

---

## Step-by-step developer checklist (each step = one small patch)

Below are micro-steps you should follow. Each micro-step is intentionally small to fit the 10–30 line constraint.

A. Collections view micro-steps

1. Add `const int pageSize = 12;` and `int currentPage = 1;` to the `collections` widget or its view model (1 small patch).
2. Introduce a helper `List<Collection> _pagedCollections(List<Collection> all)` that returns the slice for current page. Replace the list source in the UI with `_pagedCollections(allCollections)` (1 small patch).
3. Add `TextButton` `Prev` and `Next` under the list with simple handlers that change `currentPage` and call `setState` (or view-model notify). Add a `Text('Page $currentPage of $totalPages')` between or next to buttons (1 small patch).
4. Add logic to compute `totalPages = (allCollections.length + pageSize - 1) ~/ pageSize` and to disable `Prev`/`Next` appropriately (1 small patch).

B. Collection page (products) micro-steps

1. Add `const int pageSize = 12;` and `int currentPage = 1;` to `collection_page` widget or view-model (1 small patch).
2. Add `_pagedProducts(allProducts)` helper and replace the product grid/list source to use the paged result (1 small patch).
3. Add Prev/Next buttons and `Page X of Y` display with handlers and disabling logic (1 small patch).

C. Repository changes (only if necessary)

1. If you choose repository-level paging, add an optional `page` and `pageSize` parameters to `repository.getProducts({int page = 1, int pageSize = 12})` and update only the minimal lines needed in the repository and callers (split across micro-patches).

D. Tests and docs

1. Add a test that constructs the view with more than `pageSize` items and asserts that only `pageSize` items appear and that pressing `Next` shows the next page (1-2 small patches, split tests into small additions).
2. Document the presence of the pagination controls in `collections_pagination_prompt.md` and optionally README.

---

## UI/UX details and edge cases

- When the list is empty, hide the pagination controls.
- If total pages = 1, either hide the controls or show disabled Prev/Next with `Page 1 of 1`.
- Keep the visual style minimal and consistent with existing buttons in the app (use `TextButton` unless other style is preferred elsewhere).
- When navigating to a different collection or leaving the view, you may reset `currentPage` to 1; persist only while the widget is mounted.

---

## Developer instructions to yourself (meta)

- Continually check this prompt file and mark milestones as completed as you finish them.
- After implementing each micro-step, run the app or tests if quick; otherwise, ask the user to commit and confirm before continuing.
- Keep changes minimal, focused and reversible.

---

## Example pseudocode (very small examples you can apply directly)

Slicing helper example in Dart:

```dart
List<T> paged<T>(List<T> all, int page, int pageSize) {
  final start = (page - 1) * pageSize;
  if (start >= all.length) return <T>[];
  return all.skip(start).take(pageSize).toList();
}
```

Button handlers example (inside a StatefulWidget):

```dart
void _nextPage(int totalPages) => setState(() { if (currentPage < totalPages) currentPage++; });
void _prevPage() => setState(() { if (currentPage > 1) currentPage--; });
```

---

## Communication and sign-off

- After every micro-change, stop and prompt the user to commit. Provide a 1-line summary of the tiny change for the commit message (e.g., "collections: add pageSize/currentPage state").
- Once all milestones are checked off, update the bottom of this file with the final sign-off and a short changelog of the micro-commits.

---

End of prompt.

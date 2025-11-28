# Search Feature Implementation Prompt

This file is the single source of truth for implementing the app's search feature. Follow these instructions exactly and continuously check back to this file. For every milestone you finish, update the checkbox to [x]. Work in very small commits — each code change must be between 10 and 30 lines. Pause immediately after each commit and wait for the user to review and commit.

Goal
- Implement a search overlay and a dedicated search screen.

UX Summary (from screenshots)
- A search button in the app bar opens a full-width overlay pinned to the top of the screen with a search input on the left and a close icon on the right. The overlay should visually sit above all other content (full-width, small height) and dim the content beneath.
- Typing a search term shows a list of matching products below the input in the overlay; matches update live as the user types.
- The footer "Search" link navigates to a dedicated search screen at route `/search`. That screen contains the same search input and uses the same search logic and UI for results.

Guidelines & Constraints
- All code edits must be 10-30 lines in a single commit. If a change requires more than 30 lines, split it into smaller, logically ordered commits.
- Keep changes minimal and local to the files that need editing (prefer adding small widgets and small wiring changes). Do not refactor unrelated files.
- Prefer reusing existing product models/repositories if present; otherwise, read from `data/products.json` using a simple loader helper.
- Keep UI simple and consistent with screenshots: thumbnail (left), title (middle-left), price (right), with thin separators.

Implementation Plan (milestones)
- [ ] 1) Add `prompts/search_prompt.md` (this file). [ALREADY COMPLETED when checked]
- [ ] 2) Add a small widget `SearchOverlay` (file: `lib/widgets/search_overlay.dart`). Implementation should be done in small steps:
    - 2a) Define a `StatelessWidget`/`StatefulWidget` skeleton and export it (10-20 lines).
    - 2b) Add top-aligned `Container` overlay and a single `TextField` (10-25 lines).
    - 2c) Add live listener and display a placeholder static list (10-30 lines), to be replaced by real filtering later.
- [ ] 3) Add a toggle hook in the main app shell / app bar to open/close the overlay (modify `main.dart` or `lib/views/layout.dart` depending on project structure). Keep changes small:
    - 3a) Add a small boolean state and button that shows the overlay (10-20 lines).
    - 3b) Wire the close button inside `SearchOverlay` (10-20 lines).
- [ ] 4) Create `SearchScreen` view (file: `lib/views/search_screen.dart`) and register route `/search` in `main.dart` or router. Small steps:
    - 4a) Create the screen skeleton and show the same `TextField` (10-20 lines).
    - 4b) Hook up results list area (10-20 lines).
- [ ] 5) Add search logic (preferably in `lib/repositories/search_repository.dart` or as a small helper `lib/helpers/search_helper.dart`):
    - 5a) Implement product loader that returns a list of product objects (10-30 lines). If product repository already exists, call it instead.
    - 5b) Implement a simple filter function that checks `title` and `description` (10-20 lines).
- [ ] 6) Replace placeholder results with filtered results in both overlay and `/search` screen (10-30 lines per change). Ensure tapping a product routes to its detail view if that exists.
- [ ] 7) Update footer `Search` link to navigate to `/search` (modify the footer widget in `lib/views/footer.dart` or wherever present). Keep change under 10-20 lines.
- [ ] 8) Manual verification pass: check overlay open/close, live filtering, and `/search` navigation. Fix minor layout tweaks in small commits (10-30 lines each).

Acceptance Criteria
- Clicking the app-bar search icon opens the overlay placed on top of the screen.
- Typing in the overlay shows a list of matching products immediately beneath the input.
- The footer 'Search' link opens the `/search` route which shows the same search UI and results.
- All edits were done in small commits (10-30 lines). The developer will manually commit each change; after every commit, the implementer waits for confirmation.

Notes for the implementer (you, the agent)
- Continually reference this file. After finishing each milestone, edit this file to mark it completed (change the checkbox to [x]).
- Before making any code edit, plan the next code chunk to ensure it stays within 10-30 lines. If you think a chunk will exceed 30 lines, break it down further.
- When searching product data, prefer existing in-memory product models or `data/products.json`. Keep the search synchronous and simple (no remote calls).

If anything is ambiguous or a dependency is missing (for example there is no product loader), stop and write a short question in the PR/commit message and ask the user before continuing.

Milestone Checklist (update as you progress)
- [ ] 1) Add `prompts/search_prompt.md` (this file)
- [ ] 2) Add `SearchOverlay` widget
- [ ] 3) Wire app-bar search toggle
- [ ] 4) Add `/search` screen and route
- [ ] 5) Implement product loader & filter helper
- [ ] 6) Wire results into overlay and screen
- [ ] 7) Wire footer link to `/search`
- [ ] 8) Manual verification & small fixes

Example tiny change sequence (for guidance)
1. Create `lib/widgets/search_overlay.dart` with skeleton: 10-18 lines.
2. Add app-bar button in `main.dart` to show overlay: 12 lines.
3. Add a `TextField` and placeholder list in the overlay: 20 lines.
4. Implement filter helper: 18 lines.
5. Replace placeholder list with filtered list: 15-25 lines.
6. Create `/search` screen skeleton and route: 15 lines.
7. Update footer link: 8-12 lines.

Thank you — follow these steps exactly, update the checklist, and pause after each small change for the user's commit and review.
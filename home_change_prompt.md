# Home Screen Change — Implementation Prompt for the Assistant

Purpose
---
This file is a single-source contract describing EXACTLY how you (the assistant) should implement the home-screen changes requested by the developer. The developer will provide permission to proceed in small iterative patches (each patch must be 10–30 lines of change). You must continually consult this file while implementing and tick off milestones as they are completed.

Rules You Must Follow
---
- Always implement changes in small patches between 10 and 30 lines. After applying each patch, pause and wait for the developer to commit before continuing.
- Before each patch, re-open this file and read the "Current Milestone" section to ensure you’re aligned.
- Write clear commit-sized changes only; avoid refactors that touch unrelated files.
- Keep code simple and idiomatic for Flutter/Dart. Use existing models and JSON data sources where possible (e.g., `data/collections.json`, `lib/models/collection.dart`).
- Run static analyzer and existing tests locally if possible and report any failures.

Milestones (high-level)
---
1. Create this prompt file and get approval. (You are here.)
2. Move the home screen widget into `lib/views/home_view.dart`.
3. Update `lib/main.dart` to import and use `HomeView`.
4. Add the second featured collection to the top of `HomeView`.
5. Add a bottom grid showing the first 4 collections (2x2), matching the screenshot layout.
6. Small styling tweaks and accessibility checks.
7. Final verification and test run.

Detailed Implementation Steps (broken into small, <30-line patches)
---
Note: Each numbered step below is itself a sequence of small patches. Before applying each patch, compute roughly how many lines will change and keep it within 10–30 lines.

Phase A — Scaffolding (2 small patches)
- Patch A1 (10–20 lines): Create new file `lib/views/home_view.dart` with a minimal `HomeView` StatelessWidget that returns a `Scaffold` containing a `Container` or `Column` placeholder. Export/imports only. No logic changes.
- Patch A2 (10–20 lines): Update `lib/main.dart` to import `package:union_shop/views/home_view.dart` and use `HomeView()` as the `home:` widget in `MaterialApp`. Keep only bootstrapping code in `main.dart`.

Phase B — Add second featured collection (2–3 small patches)
- Patch B1 (10–25 lines): In `HomeView`, add a second featured collection placeholder under the existing featured collection. Use the same widget as the first featured item (e.g., reuse an existing `FeaturedCollection` widget if present, or inline a simple `GestureDetector` + `Stack` overlay). Use a placeholder asset or image from the app if no data binding yet.
- Patch B2 (10–25 lines): Wire the second featured collection to the data source (use `data/collections.json` or existing repository methods). If the app already has a `Collection` model and repository, call the existing method to fetch the second collection. If not, use a defensive fallback that shows a placeholder and logs a warning.

Phase C — Add bottom 2x2 collections grid (3–4 small patches)
- Patch C1 (10–25 lines): Add a `GridView.count` or `Wrap` in `HomeView` with 2 columns and 4 child placeholders. Keep item widgets simple: an image with a centered title overlay matching screenshot typography (white bold text, centered).
- Patch C2 (10–25 lines): Bind the grid to the first 4 collections from the existing data source or `data/collections.json`. Each grid tile should be tappable and navigate to the collection page using existing navigation helpers (or a `TODO` comment if navigation API needs larger refactor).
- Patch C3 (10–20 lines): Add spacing, padding, and a top heading: "OUR RANGE" above the grid, centered and using existing theme text style with slight modifications.

Phase D — Small polish & tests (2–3 small patches)
- Patch D1 (10–20 lines): Ensure fonts/colors match existing theme, add `Semantics` or `InkWell` for accessibility, and set `fit: BoxFit.cover` for images.
- Patch D2 (10–20 lines): Run analyzer and fix any trivial warnings introduced by the patches (imports, unused variables). If any non-trivial test failures appear, stop and report.

Milestone Checklist (update as you go)
---
- [ ] Created `home_change_prompt.md` (this file)
- [ ] Created `lib/views/home_view.dart` skeleton
- [ ] Updated `lib/main.dart` to use `HomeView`
- [ ] Added second featured collection placeholder
- [ ] Wired second featured collection to data
- [ ] Added 2x2 grid with first 4 collections
- [ ] Styling and accessibility polish
- [ ] Analyzer/tests pass

How to Break Each Patch into 10–30 Lines
---
- Add files with minimal scaffold first (class and imports only) — typically 12–20 lines.
- When modifying `main.dart`, only change the `home:` argument and any imports — keep changes under 15 lines.
- When adding widgets, prefer composing small widgets in the same file for patches; extracting to separate files is allowed but do in a separate patch.
- Avoid changing model files or data structures unless absolutely necessary. If you must, split model updates into their own 10–30 line patches and get explicit approval.

Developer Communication Protocol
---
- After each patch, pause and post a short message summarizing the patch (1–2 sentences), the files changed, and the exact lines-of-change estimate.
- Wait for the developer to commit before applying the next patch.
- If you need to deviate from this plan, explain why and list the minimal alternative patches to stay within the line limit.

Acceptance Criteria
---
- `HomeView` exists at `lib/views/home_view.dart` and is used by `lib/main.dart`.
- The home screen shows two featured collections at the top (or placeholder) and a 2x2 grid at the bottom showing the first 4 collections with centered titles, visually matching the attached screenshot.
- All changes are committed in small increments (10–30 lines per patch) and the developer has the opportunity to commit each patch.

When Ready to Proceed
---
Wait for the developer to confirm — then begin Patch A1 from the "Detailed Implementation Steps". After each patch, return here, update the checklist by marking the completed item(s), and follow the "Developer Communication Protocol".

---

*Notes:* If you are the assistant performing changes, always reference this file before making edits. Tick items off this checklist by editing this file and committing it as part of the small change when appropriate.
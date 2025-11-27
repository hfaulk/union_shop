# Main.dart Cleanup — Implementation Prompt for the Assistant

Purpose
- Move all home-screen UI and related presentation logic out of `lib/main.dart` into a dedicated view file (`lib/views/home_view.dart`) using an iterative, minimal-chunk approach so commits remain small (10–30 lines per change).
- Ensure correctness: imports, routing, state usage, tests, and analyzer must remain passing after each chunk.

Important constraints (must follow exactly)
- Never make a single code edit larger than 10–30 lines. Count only lines changed in a file for purposes of this limit (added, removed, or modified lines). Small comment, whitespace, or import updates count toward this total.
- After every chunk (one edit batch ≤30 lines), pause and wait for the user to commit before continuing. Do not proceed until the user confirms.
- Continuously check this prompt file at the start of each step and mark milestones in the checklist below as you complete them.

How to use this prompt
1. Read the entire file and acknowledge to the user that you will follow these rules verbatim.
2. Before doing any edits, run a quick scan of `lib/main.dart` and identify candidate home-screen code blocks and their approximate line ranges.
3. Propose the first chunk to extract (10–30 lines) and wait for approval. Do not modify any files until the user confirms.
4. When the user approves, perform only the agreed edit(s) (≤30 lines total). After editing, run analyzer and tests locally (`flutter analyze` / `flutter test`) and report results.
5. If analyzer/tests fail, revert the last change and explain why; propose a corrected 10–30 line change and wait for approval.
6. If analyzer/tests pass, tell the user to commit the change; wait for the user to commit and confirm, then continue to the next chunk.

Checklist / Milestones (tick as you go)
- [ ] Read and acknowledge this prompt.
- [ ] Scan `lib/main.dart` and list candidate widgets/blocks for extraction with line ranges and dependencies.
- [ ] Create `lib/views/home_view.dart` (initial stub) and move first chunk (≤30 lines).
- [ ] Iteratively move remaining chunks (each ≤30 lines) until `lib/main.dart` no longer contains home UI.
- [ ] Update imports/references and routing to use `HomeView`.
- [ ] Run `flutter analyze` and `flutter test`; all checks pass.
- [ ] Update README or inline docs noting that home screen moved.

Detailed step-by-step implementation plan (safe, minimal edits)
Note: Each step below is intended to be executed as a single chunk or a small sequence of single-chunk edits. Always present the planned chunk and wait for user approval before editing files.

Step 0 — Confirm and plan
- Action: Acknowledge prompt, then list the files to inspect (`lib/main.dart`, any `lib/views/*`, and `lib/widgets/*`). No code changes.

Step 1 — Scan `lib/main.dart`
- Action: Read through `lib/main.dart` and identify likely home-screen widget names (examples: `HomePage`, `HomeScreen`, `MyHomePage`, `Scaffold` with `body` featuring carousel, product grid, hero slides, etc.). For each find:
  - The approximate line range.
  - Any custom widgets declared inline (private classes) that belong to Home UI.
  - Dependencies (models, view models, repositories) used locally.
- Output: A short mapping table of candidate blocks and their dependencies.
- No edits.

Step 2 — Create `lib/views/home_view.dart` stub (1 small edit)
- Action: Add a new file `lib/views/home_view.dart` containing a minimal `HomeView` widget and necessary imports. Keep the stub very small (≤30 inserted lines). Example stub should export a `class HomeView extends StatelessWidget { @override Widget build(...) => SizedBox.shrink(); }` and any necessary imports.
- Rationale: This file will receive extracted widgets gradually.

Step 3 — Decide first chunk to move (no-edit decision)
- Action: Choose the smallest meaningful self-contained widget inside `main.dart` that belongs to the home UI (e.g., a header widget, a small private helper class, or a specific sub-section). The chosen chunk must be ≤30 lines to move.
- Output: Present the exact source lines to be moved and where they will go in `lib/views/home_view.dart`.
- Wait for user approval.

Step 4 — Apply the chunk (single edit, ≤30 lines)
- Action: Copy the chosen chunk into `lib/views/home_view.dart` and replace the original code in `lib/main.dart` with a reference to the new widget (importing `lib/views/home_view.dart`).
- Keep edits minimal: e.g., add `import 'views/home_view.dart';` and replace the old inline class with `HomeHeader()` or similar.
- After edit: run `flutter analyze` and `flutter test`.
- If tests/analyzer fail, revert and report; propose an alternate chunk.

Step 5 — Repeat Step 3/4 until done
- Action: Continue picking the next smallest chunk and repeat extraction, always obeying the 10–30 line limit.
- After each successful chunk and passing tests/analyzer, pause and wait for user commit.

Step 6 — Final wiring and verification
- When the home UI is fully in `lib/views/home_view.dart` and `lib/main.dart` references `HomeView` only, run full analysis and all tests.
- Ensure imports are cleaned and unused private members removed.
- Update `README.md` or inline comment in `lib/views/home_view.dart` that the screen was moved and how to run tests.

Edge cases and guidance
- If a private stateful widget in `main.dart` requires a view model or controller declared nearby, move those dependencies with it only if they are <30 lines; otherwise extract the widget in a way that references the dependency from the original location until you can also move the dependency in a subsequent small chunk.
- If moving a chunk requires adding or changing imports that push the edit over 30 lines, split the import addition into an earlier tiny edit (e.g., add the import first, as a separate 1–2-line edit), then move the chunk in the next commit.
- Preserve file-level comments and licenses exactly where they are. Do not reformat unrelated code.

Code-style and tests
- Prefer minimal edits and avoid broad refactors.
- After each chunk, run `flutter analyze` and `flutter test` and report the result in your message. Use these commands:

```powershell
flutter analyze ; flutter test
```

Pausing and approvals
- After every file edit or set of edits that change 1–30 lines, stop and say: "Paused — changes applied (X lines). Please commit and confirm to continue." Wait for the user's confirmation before proceeding.

When you finish
- Mark all milestones in the checklist above.
- Provide a short summary of edits, tests run, and any remaining TODOs.
- If any step required a workaround (temporary import aliasing, keeping some logic in `main.dart` for now), document precisely where and why.

Behavioral rules for the assistant
- Always re-open this prompt file at the start of each step and tick the checklist as items are completed.
- If uncertain whether a particular block belongs to Home UI, ask the user before moving it.
- Never exceed the 10–30 line edit limit per commit.
- If a planned chunk is >30 lines, break it into a minimal dependency step (imports/aliases) then the main move.

Contact points / confirmations you must ask the user for
- Confirm before making any edit.
- Confirm after a successful chunk before I continue to the next.

Example small chunk sequence (illustrative)
1. Add `lib/views/home_view.dart` stub (2–8 lines).
2. Extract `class _HomeHeader extends StatelessWidget` (15 lines): move to `home_view.dart`, replace with `HomeHeader()` in `main.dart` (3–5 lines changed).
3. Extract hero carousel widget (20 lines) — move & replace.
4. Extract product grid (split into two 10–15 line chunks if necessary).

End of prompt

When you start, respond with a short acknowledgment and the first scan of `lib/main.dart` listing candidate chunks and their approximate line ranges. Then stop and wait for my approval to proceed with the first edit.

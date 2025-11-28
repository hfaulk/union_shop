# Implementing Tests Incrementally (10-30 line commits)

This file is the authoritative instruction set for implementing tests in the `union_shop` Flutter app. Use this prompt exactly as written whenever you (or an assistant) implement tests. Continually check back to this file and the TODO list in the repository; tick off milestones and update statuses as each small chunk is completed.

-- IMPORTANT RULES (enforced every step) --
- Every code or test change MUST be between 10 and 30 lines of diff. If the intended change would exceed 30 lines, split it into multiple commits each within the limit.
- After implementing each chunk, STOP and wait for the developer to commit and push before continuing.
- Run `flutter test` and produce a coverage report after each logical group of changes to verify progress.
- Prefer the smallest, simplest implementation that achieves the test goal (avoid heavy refactors).

Goals
- Maximise test coverage incrementally, focusing on files with no or minimal tests.
- Maintain small, atomic changes to keep commits reviewable.

Workflow (step-by-step)
1. Audit coverage (one-time start):
   - Run: `flutter test --coverage` or use your CI tool.
   - Produce a list of `lib/` files with 0% or low coverage.
   - Prioritize files by importance (business logic first: models -> repositories -> view_models -> widgets/views).
   - Mark the `Audit current tests & coverage` TODO as completed.

2. Implement tests in small chunks:
   - For each target file, create test code that fits in a single commit of 10-30 lines.
   - Typical chunk format:
     - Add one `test()` case that asserts a small behavior or property.
     - If necessary, add a tiny helper or fixture in the same file to keep the change contained.
   - After writing the chunk, run `flutter test` and update coverage.
   - Commit with a message like: `test: add small unit test for <symbol> (chunk 1/3)`.
   - Pause and wait for developer to commit & push.

3. Iterate across target files:
   - Continue adding 10-30 line chunks until the file's important behaviors are covered.
   - After finishing a file, update the TODO for that category.

4. Widget tests guidance:
   - Prefer simple `pumpWidget` tests asserting presence of key text/widgets or state transitions.
   - Keep tests deterministic: inject simple fake data from `data/*.json` if needed.
   - Avoid expensive integration tests; focus on unit and widget tests to raise coverage.

5. Mocks and test doubles:
   - Use minimal, hand-rolled fakes (small classes) instead of heavy mocking frameworks to keep diffs small.
   - Place small fakes inside the test file when possible.

6. Coverage checks and acceptance:
   - After each completed logical group (e.g., all models), run `flutter test --coverage` and generate an lcov report.
   - Track percentage changes and confirm coverage increases.
   - When coverage is acceptable or you've covered the prioritized list, mark `Run coverage and iterate` as completed.

Milestones (tick off in order)
- [ ] Audit current tests & coverage
- [ ] Add model unit tests (lib/helpers, lib/models)
- [ ] Add repository tests (lib/repositories)
- [ ] Add view-model tests (lib/view_models)
- [ ] Add widget tests (lib/views, lib/widgets)
- [ ] Run coverage and iterate
- [ ] Final review & tidy up

Chunking examples (exact pattern to follow)
- Example small unit test (fits in ~12 lines):
  - Create `test/models/product_test.dart` with a single `test()` verifying `Product.fromJson` maps expected fields.
- Example fake repository (fits in ~20 lines):
  - Add a small in-test `class FakeLocalStorage implements LocalStorage { ... }` that returns a preset JSON to test repository loading.

Commit message conventions
- Use `test:` prefix. Example: `test: add product.fromJson unit test (chunk 1/4)`.
- Include `(chunk X/Y)` when a file requires multiple chunks.

Communication and checks
- Before making any code edits, re-open this file and the TODO list. Confirm the next TODO is `not-started` and state which chunk you'll implement.
- After each chunk, run `flutter test`. Report the result and coverage delta in the pull request or commit message.

If you are the assistant implementing these changes
- Continually reference this `prompts/tests_2_prompt.md` file.
- Update the repository `manage_todo_list` statuses as you progress.
- Ensure every code change respects the 10-30 line rule.

If anything blocks a small test (e.g., a needed public accessor or small refactor that exceeds 30 lines), do the following:
1. Split the refactor into multiple 10-30 line commits.
2. For each commit, keep the app in a working/testable state.
3. Document the reason and link to the TODO item before proceeding.

End — follow this precisely to keep commits small, reviewable, and to increase coverage safely.
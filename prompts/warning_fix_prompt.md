# Warning & Info Fix Prompt for AI Assistant

Purpose
- Provide an exact, step-by-step instruction set for an assistant to run `flutter analyze` and fix all analyzer warnings and info-level issues in this repository.
- Ensure every code change is small (10-30 lines) so the user can commit frequently.
- Require the assistant to check back to this file continuously and tick off milestones as they are completed.

Important constraints (MUST follow)
- No patch may exceed 30 lines changed. Prefer 10-30 lines per patch.
- Before any change, re-run `flutter analyze` and list the targeted issue(s).
- After applying a patch, immediately run `flutter analyze` again and show the delta.
- Pause and wait for the user to commit after every patch. Do not continue until the user confirms commit.
- Only make minimal, local, and low-risk changes: fixes should not rework large code paths or rewrite file structure.
- Prefer fixes that preserve intended functionality (e.g., prefer adding types, marking variables `final`/`const`, removing unused imports, changing local variable names, adding `?` or `late` where necessary, or using simple refactors).

Commands (PowerShell-friendly)
- Run analyzer: `flutter analyze`
- Optional quick fix suggestion: `dart fix --dry-run` then review; `dart fix --apply` only when the specific fix is safe and <=30 lines.

Checklist (tick as you complete; update file each time)
- [ ] Run `flutter analyze` and collect full output.
- [ ] Classify issues into categories (imports, types, lints, formatting, dead code).
- [ ] Produce prioritized list of small fixes (each fix annotated with estimated changed lines).
- [ ] Apply first fix (<=30 lines) via `apply_patch`.
- [ ] Re-run `flutter analyze` and confirm reduction or resolution of issue(s).
- [ ] Pause for user commit.
- [ ] Repeat until all warnings/info resolved.
- [ ] Final `flutter analyze` and run unit tests (if present).

Implementation approach (step-by-step)
1. Discovery
   - Run `flutter analyze` and capture the full output.
   - Copy/paste the relevant warnings/info into your working message and group them by file and type.
   - For each issue, include the analyzer message, file path, and line number.

2. Classification & Prioritization
   - Group issues into simple categories:
     - Unused imports/unused local variables
     - Missing or incorrect type annotations
     - Prefer const/const constructors
     - Lint rules (like prefer_final_locals, avoid_print)
     - Potentially unsafe null-safety issues
   - For each group, estimate an easy fix that will not exceed 30 lines. Example fixes:
     - Remove an unused import line (1 line).
     - Add `final` to a local variable declaration (1 line change within the line or 1-2 lines total).
     - Add a `?` to a type to satisfy null-safety (1 line).
     - Replace `var x = 0;` with `int x = 0;` (1 line).
     - Wrap a nullable access with `?` or `!` when logically safe (1 line).

3. Chunking strategy
   - Create a numbered task list where each task intends to change <=30 lines.
   - For each task, include:
     - Files to edit
     - Exact analyzer messages targeted
     - A one-sentence description of the code change
     - Estimated line delta
   - Before editing, present this single-task plan to the user.

4. Making a patch
   - Use `apply_patch` to update files. Keep the diff minimal.
   - After applying a patch, run `flutter analyze` and display only the changed analyzer output.
   - If the change introduced new warnings/errors, revert or adapt the change to keep it small.

5. Verification
   - After each patch, run `flutter analyze` and (if present) `flutter test` for the affected unit tests.
   - If all good, mark the task done in this file's checklist and request the user to commit.

6. Commit messages (examples)
   - `fix(analyzer): remove unused import in lib/views/collection_page.dart`
   - `fix(analyzer): add type annotation to variable in lib/repositories/cart_repository.dart`
   - Keep commit message short and reference the file and analyzer category.

Safety & policy notes
- Do not run `dart fix --apply` blindly. Only use it for a single change if you can guarantee it does <=30 lines of modification and you understand the change.
- Avoid changing public APIs or altering method signatures unless a warning demonstrates a clear bug and the change is small.
- If a warning requires a larger refactor, stop and present the plan to the user.

What to report back to the user each step
- The exact `flutter analyze` output (only the relevant lines for targeted warnings).
- The short task plan for the next patch (file(s), change, estimated lines).
- The `apply_patch` diff you will run (or ran) in unified form.
- The `flutter analyze` result after the patch.
- A short recommendation whether to commit.

Examples of low-risk fixes (each <=30 lines)
- Remove unused import: delete the single import line.
- Add an explicit type to a `var` local variable when analyzer complains.
- Mark a field `final` or `const` when analyzer suggests.
- Add `// ignore: <lint-name>` only as last resort and include comment explaining why.

When to stop and escalate to the user
- A fix requires editing >30 lines or touching many files.
- A fix alters core app behavior (routing, state management, data models).
- The analyzer reports an `error` (not `info`/`warning`) that blocks compilation — present the issue and recommended safe actions.

Continuous checking instruction (MANDATORY)
- Before starting each task, open this file and re-check the checklist. Add a timestamped note under the checklist entry you are about to work on.
- After completing a task, update the checklist with the date/time and short note, and include the analyzer delta.

Contact for edge cases
- If you are unsure whether a change is safe or exceeds the line limit, stop and ask the user. Provide the minimal plan and the exact lines you expect to change.

---

Signed-off: Assistant instructions for stepwise analyzer fixes



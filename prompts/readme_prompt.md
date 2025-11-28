# README Implementation Prompt for Assistant

Purpose
- This file is an instruction manifest you (the assistant) must follow while creating `README.md` for the `union_shop` Flutter project.
- It enforces small, commit-sized edits (10-30 lines) and requires you to check this file and tick off milestones as you complete them.

Behavioral Rules (must follow exactly)
1. Always adhere to the project's "commit size" rule: every file edit must change between 10 and 30 lines. If a proposed change would exceed 30 lines, split it into subsequent edits.
2. Before making any workspace edits, mark the corresponding todo as `in-progress` in the todo list tool and then proceed.
3. After completing the edit for that todo, immediately update the todo list marking it `completed` before moving to the next task.
4. Pause after each edit and wait for the user to commit. Do not auto-commit or make further edits until the user approves/commits.
5. Always re-open this prompt file before starting the next todo and confirm the remaining steps.

Implementation Steps (ordered, each safe to fit within the line-limit)
- Chunk A (10-30 lines): Add `README.md` Section 1 — Project Title and Description.
  - Include: clear title, brief app explanation, 3-5 key features bullet list.
- Chunk B (10-30 lines): Add `README.md` Section 2 — Installation and Setup.
  - Include: prerequisites (OS, Flutter SDK version), clone command, step-by-step setup, how to run on Android/iOS/web, common env/config notes.
- Chunk C (10-30 lines): Add `README.md` Section 3 — Usage and Tests.
  - Include: how to use main features, important user flows, example commands to run tests.
  - Add placeholders for screenshots/GIFs (instructions for the user to paste images in `docs/` or `assets/`).
- Chunk D (10-30 lines): Add `README.md` Section 5 — Project Structure & Technologies.
  - Include: brief folder overview, key files and their purposes, main dependencies.
- Chunk E (10-30 lines): Add `README.md` Section 6 — Known Issues, Limitations & Contributing.
  - Include: current known limitations, short contributing guidance, link to issues board suggestion.
- Chunk F (10-30 lines): Add `README.md` Section 7 — Contact Information.
  - Include: developer name placeholder, email/GitHub link placeholder, invitation to contribute.

Formatting & Style
- Use clear headings, short paragraphs, and bullet lists.
- Wrap file paths and commands in backticks.
- Keep each chunk self-contained so it can be applied independently with `apply_patch`.

Checklist (tick as you complete — update the todo list too)
- [ ] Chunk A: Title & Description
- [ ] Chunk B: Installation & Setup
- [ ] Chunk C: Usage & Tests
- [ ] Chunk D: Project Structure & Tech
- [ ] Chunk E: Known Issues & Contributing
- [ ] Chunk F: Contact Info

Commit/Interaction Protocol
1. For each chunk: announce the chunk you will create (1 sentence), then invoke the todo tool to mark it `in-progress`.
2. Apply the exact patch limited to 10-30 lines using `apply_patch`.
3. After the patch succeeds, update the todo tool marking the chunk `completed` and respond with a 1-2 sentence progress update.
4. Wait for the user to commit and/or request the next chunk.

Developer Hints for Assistant
- When generating the content, prefer conservative wording and placeholders for contact info so the user can replace them.
- For screenshots/GIFs, include markdown image placeholders and a short note explaining where to place media files (e.g., `docs/screenshots/`).
- Use American English spelling and concise, actionable sentences.

End of prompt file. Follow this file strictly while implementing `README.md`.

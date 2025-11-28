# Persistent Cart Implementation Prompt

Goal: Implement a persistent shopping cart so cart contents survive app restarts.

Primary constraint: All code changes must be small (10–30 lines) per commit. After each chunk, stop and wait for the developer to commit before continuing.

Key design notes (must be followed):
- Assets are bundled and read-only at runtime. To persist, create a writable file in the app's documents directory and copy a seed `assets/data/cart.json` to it on first run.
- Use minimal dependencies. Prefer `path_provider` for locating the documents directory, `dart:io` for file read/write, and `dart:convert` for JSON.
- Keep public APIs small and clear: `CartRepository.loadCart()` returns cart items; `CartRepository.saveCart(items)` writes them.

Milestones (check off as you finish each):
1. Add `assets/data/cart.json` (seed) and register asset in `pubspec.yaml`.
2. Add `prompts/persistent_cart_prompt.md` (this file) and confirm plan.
3. Implement `CartRepository` that on first run copies seed asset to documents dir and reads/writes JSON.
4. Add small integration in `CartViewModel` to load cart on init and call save on updates.
5. Add tests verifying persistence across simulated restarts (load -> save -> load).
6. Document new files and usage in `README.md` or `prompts/`.

Chunking guidance (how to split into 10–30 line commits):
- Chunk A (10–30 lines): Add `assets/data/cart.json` and update `pubspec.yaml` assets list.
- Chunk B (10–30 lines): Add `lib/repositories/cart_repository.dart` skeleton with imports and class declaration.
- Chunk C (10–30 lines): Implement `copySeedIfNeeded()` and `getCartFilePath()` helpers in `cart_repository.dart`.
- Chunk D (10–30 lines): Implement `loadCart()` that reads JSON and returns items.
- Chunk E (10–30 lines): Implement `saveCart()` that writes JSON atomically.
- Chunk F (10–30 lines): Wire `CartRepository` into `lib/view_models/cart_view_model.dart` to call `loadCart()` on init and `saveCart()` in update methods.
- Chunk G (10–30 lines): Add a minimal unit test that stubs a documents directory and verifies persistence.

Operational rules for the implementer (assistant):
- Before making any code change, re-open this prompt file and confirm the next chunk to implement.
- After implementing a chunk, update this prompt file by checking off the milestone and add a one-line note about which files changed.
- Always keep each patch 10–30 lines. If a change requires touching multiple files, split into multiple chunks so each edited file remains within the 10–30 line limit per commit.
- If filesystem writes are needed in tests, use temporary directories; do not rely on platform-specific hard-coded paths.

Edge cases and error handling to include (small, incremental additions):
- If the seed bundle asset is missing, `copySeedIfNeeded()` should create an empty cart file.
- `loadCart()` should handle invalid JSON by returning an empty cart and logging the error.
- `saveCart()` should write atomically (write to temp file then rename) to avoid corruption.

After each chunk, stop and report:
- Files changed (paths only).
- Lines added/removed per file (approximate).
- Which milestone was checked off.
- Tests to run (if any) and a short status whether they passed locally.

Now: implement only after the developer confirms this prompt file is correct and commits it. Once confirmed, proceed chunk-by-chunk as described above.

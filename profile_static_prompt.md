# Profile / Login Static Page — Implementation Prompt

Purpose
- Create a static, local-only "Sign in" page that mirrors the supplied screenshot and opens when the user taps the profile icon in the navbar. This is an iterative implementation: every code change must be a small patch (10–30 lines). The assistant should continually refer to this prompt and tick off steps using the repository's TODO mechanism.

Behavior & Visual Requirements (static)
- Centered card with light rounded corners and white background.
- Top: the project's logo image (use this exact URL): `https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854`.
- Below the logo: a bold title that reads `Sign in` and a one-line hint `Choose how you'd like to sign in`.
- Primary action: a purple button labeled `Log in with service` (not `Sign in with shop`). This button is a dummy and does not need to actually authenticate. Clicking it may show a `SnackBar` or do nothing.
- A thin divider with the word `or` centered beneath it.
- An email input field with placeholder `Email`.
- A wide, neutral `Continue` button beneath the email field (it can be disabled-looking and need not perform any network action).
- Make it visually similar to the screenshot but exact pixel-perfect styling is not required — approximate layout, spacing and colors are fine.

Accessibility
- Ensure tappable controls use `ElevatedButton` or `TextButton` with readable labels.
- Fields should have hint text for screen readers.

Navigation and wiring
- The login page should be reachable at route `/login`.
- The profile (person) icon in `lib/widgets/shared_layout.dart` must push that route when tapped:
  - `Navigator.pushNamed(context, '/login')`.
- The logo inside the login card should be tappable and navigate home: when tapped, call `Navigator.pushNamedAndRemoveUntil(context, '/', (r) => false)` (or a similar single-line navigation).

Files to change / create (explicit)
- `main.dart` (or wherever `MaterialApp` routes live): add a route entry for `'/login'` mapping to `LoginPage()`.
- `lib/views/login.dart`: create the `LoginPage` widget and its layout.
- `lib/widgets/shared_layout.dart`: modify the `IconButton` handling for the person/profile icon to open `/login`.

Implementation plan (strict small-patch steps)
> Important: Each step below is intended to be implemented as a single patch of 10–30 lines only. After each patch, stop and let the developer commit before continuing.

1) Add route entry in `main.dart` (small patch)
- Add a single mapping in the `routes:` map: `'/login': (_) => LoginPage(),`
- Keep the patch minimal (just the routes map modification). Do not add imports that exceed the line limit — if needed add `import 'views/login.dart';` in a separate small patch.

2) Create `lib/views/login.dart` skeleton (small patch)
- Add a `LoginPage` StatelessWidget with an empty `Scaffold()` and `AppBar` or no AppBar.
- Keep lines under 30.

3) Add logo and basic header to `LoginPage` (small patch)
- Insert a centered `Card` with the network image URL and the `Sign in` title + hint text.
- Include the logo as a `GestureDetector` that will later navigate home. For now, the `onTap` can be a placeholder or an actual navigation call if the route exists.

4) Add primary `Log in with service` button and divider (small patch)
- Add an `ElevatedButton` styled with the purple color `Color(0xFF4d2963)` and label `Log in with service`.
- Add a horizontal divider with `or` centered.

5) Add email `TextField` and `Continue` button (small patch)
- Add a `TextField` with `hintText: 'Email'` and a wide `ElevatedButton` below labeled `Continue`.
- The `Continue` button can be non-functional or show a `SnackBar`.

6) Wire profile icon to open `/login` (tiny patch)
- Modify `lib/widgets/shared_layout.dart` to change the person icon button's `onPressed` to `() => Navigator.pushNamed(context, '/login')`.
- This should be a tiny patch (1–5 lines).

7) Make the logo tappable to navigate home (tiny patch)
- Update the GestureDetector in the login page logo to call `Navigator.pushNamedAndRemoveUntil(context, '/', (r) => false)`.

8) Run smoke test & polish (manual step)
- Launch the app and confirm tapping the profile icon opens the login screen and the UI matches the spec.
- If small tweaks are needed (spacing/colors), apply them in further 10–30 line patches.

Developer checklist & rules for the assistant
- Before making any code changes (beyond this prompt file), ensure the TODO list in the repo is updated and mark the item you will start as `in-progress` using the repository's TODO mechanism.
- Every code change must be one patch between 10 and 30 lines. If a change would exceed 30 lines, split it into multiple logically ordered patches and pause after each for a commit.
- After every patch, stop and report what you changed, show the exact files touched, and ask the developer to commit. Wait for confirmation before proceeding.
- After completing each milestone step in this prompt, mark the corresponding TODO item as `completed` and select the next step to mark `in-progress`.
- Continually reread this prompt to ensure fidelity to the requested behavior and layout.

Acceptance criteria (how to know it's done)
- The profile icon opens a `/login` preview page.
- The login page displays the logo (from the exact URL), `Sign in` title, hint text, a purple `Log in with service` button, a divider with `or`, an email input, and a `Continue` button.
- The logo in the login card is tappable and navigates to home.
- All changes were made in small patches (10–30 lines) with the developer committing between patches.

Notes & constraints
- This task is strictly a static UI implementation — no backend/auth logic is required.
- Keep changes small; the developer will commit each patch. If a patch would be >30 lines, split it.
- Use named routes where possible to keep wiring simple and small.

If anything here is unclear, ask one direct question before changing code. Otherwise, when you are ready, begin by implementing the first small patch: add the route entry in `main.dart` as described in Step 1 and mark that step `in-progress` in the repo TODO list.
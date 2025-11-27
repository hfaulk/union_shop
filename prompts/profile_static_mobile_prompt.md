# Profile Static Mobile Prompt

Purpose
- Provide an exact, unambiguous prompt that an implementing assistant (or developer) should follow to refine the mobile login UI for the Union Shop Flutter app.
- The prompt must enforce the user's constraints: small iterative commits limited to 10–30 lines of code per change, frequent check-ins, and preferring existing app text over the screenshot when they differ.

How to use this prompt
- Treat this file as the authoritative specification. Before making any code change, re-open and re-read this file.
- After finishing each small implementation step (one 10–30 line change), update the project's todo/tracking mechanism and then re-open this file to tick off the corresponding milestone.
- If any visual decision is ambiguous, ask the user and reference this prompt for the fallback rules.

High-level design goals (visual)
- Mobile-first, vertically stacked layout. Center brand/logo at top, then heading and subheading, primary CTA (rounded purple button) for third-party sign-in ("Sign in with shop" or the app's current string), a thin divider with "or", an email input, and a secondary Continue button.
- Use the app's current wording where it differs from the screenshot. The screenshot is only a visual guideline.
- Keep spacings, accessible color contrast, and large tap targets for mobile devices.

Behavior requirements
- Primary button: preserve label currently used in code (do not rename to match screenshot if different).
- Secondary (Continue) button: disabled until the email field contains a syntactically valid email.
- The email input should show a hint/placeholder matching the app (if app already uses `Email`, keep that); use a thin rounded border.
- Divider: horizontal lines left & right with the word "or" centered between them.
- Focus states: tapping the input must bring up native keyboard; focused input should elevate border color to the app's primary color.

Accessibility
- Font sizes: heading >= 20sp, subheading >= 14sp, input text >= 16sp, CTA text >= 16sp.
- Buttons must be reachable with TalkBack/VoiceOver; include semantic labels where necessary.
- Color contrast should meet WCAG AA for text on buttons.

General rules and constraints (must follow)
- Every code change must edit no more than 10–30 lines of code (per user requirement). Aim for the smallest, simplest changes that fully implement the step.
- After each change, stop and wait for the user to commit and/or approve before proceeding to the next step.
- Prefer existing code text/strings over the screenshot. If the screenshot shows a different label, keep the app's label.
- No large refactors. Keep changes local to the affected widget file (likely `lib/views/login.dart`, `lib/views/profile_static.dart`, or wherever the login UI currently resides). If a new helper or small style constant is required, add it in the same file if possible to stay under the line-change limit; otherwise create a new small file with a single constant or helper (also keep each new file addition within the scope of a single small commit).

Implementation plan (chunked into small, safe steps - each step designed to be a single 10–30 line change)
- NOTE: Each numbered step below is intended to be implemented in a single small commit (10–30 lines). After implementing a step, re-open this prompt file and mark the step done, then ask the user to commit.

1) Add a lightweight container and layout scaffolding
- Change: Wrap the existing login view's root `Column` (or the main widget tree) in a `SingleChildScrollView` with paddings suitable for mobile (horizontal padding ~16). If scroll already exists, adjust padding only.
- Purpose: Ensure the layout scrolls on small screens and provides consistent side padding.
- Checks: Visual spacing matches screenshot margins.

2) Center the logo and add top spacing
- Change: Add or adjust a `Padding` or `SizedBox` to place the app logo centered near the top with comfortable top margin (e.g., 40 px). Use existing logo widget or `Image.asset` that app currently uses.
- Purpose: Match screenshot composition.

3) Ensure headings follow hierarchy and spacing
- Change: Update the heading `Text` style to be bold and sized (>=20sp) and the subheading to be lighter and smaller (>=14sp). This usually requires changing the `TextStyle` or swapping to `Theme.of(context).textTheme` variants.
- Purpose: Improve visual hierarchy.

4) Primary (third-party) sign-in button styling
- Change: Update the existing primary button widget to use a rounded rectangle shape (e.g., `RoundedRectangleBorder` with a 12.0 radius), set background color to app primary color (purple), set minimum height for mobile (~48 px), and set text style to 16sp bold.
- Purpose: Match screenshot button size/shape while preserving the app's button label.

5) Add the divider with "or"
- Change: Insert a `Row` with two `Expanded` `Divider`s and a centered `Text('or')` between them. Space them with `SizedBox` as needed. Keep the color subtle (light gray).
- Purpose: Visually separate the third-party button and email input.

6) Email input visuals and behavior
- Change: Ensure the email `TextField` has rounded corners, placeholder text `Email` (or existing app text), content padding, and a thin border. Add a `TextEditingController` if missing. Add simple email validation using a lightweight RegExp local to the widget.
- Purpose: Provide expected input UI and enable validation for the Continue button.

7) Continue button state logic
- Change: Make the Continue button disabled by default and enable it only when email validation passes. Prefer the app's existing button label. Use `setState` or viewmodel updates as appropriate, but keep change localized and small.
- Purpose: Prevent invalid submissions.

8) Spacing and rounded corners for inputs and buttons
- Change: Tweak padding, margin, and corner radii to match screenshot: inputs and buttons should have ~12 px radius and consistent vertical spacing between components.
- Purpose: Cohesive design.

9) Accessibility and semantics
- Change: Add `semanticsLabel` or `Semantics` wrappers to primary button, email field, and continue button if missing. Ensure `hintText` is present on email field.
- Purpose: Improve screen-reader experience.

10) Small polish: disabled style and subtle shadow
- Change: Style disabled Continue button with muted background and gray text; add a very subtle elevation or shadow for the primary button only.
- Purpose: Finish look-and-feel.

11) Final visual checks and tests
- Change: Add a small test (widget test) or run the app on a mobile emulator and check that layout and states behave as expected. If tests exist in `test/` (e.g., `home_test.dart`), add one small widget test referencing login widget behavior (this can be done later in a separate small commit).
- Purpose: Verify behavior.

Edge cases and fallbacks
- If the login UI lives in an unexpected file, make the smallest change in the file that contains the visible UI. Search for widgets or views named `login`, `signin`, `profile`, or a route referencing login. Prefer editing the already-present login view rather than creating a new screen.
- If a step requires >30 lines because the file has complex state management, split the change into smaller sub-steps: first add a local controller or variable, then wire validation, then style. Ensure each sub-step is separately committable and reversible.

Strings and localization
- Preserve existing string resources. If the app uses localized strings (e.g., `S.of(context).email`), use those existing keys instead of hardcoding.

Testing & verification checklist (execute after implementing relevant steps)
- The primary button displays the same label as in the app and matches the purple rounded style.
- The divider with 'or' is visible and balanced.
- The email field accepts input and the Continue button only becomes enabled for syntactically valid emails.
- All text is legible on a standard mobile screen and meets contrast requirements.
- Screen reader exposes the main controls.

Milestone ticking
- After completing each numbered step above, return to this file and mark the step as DONE. Example format:

  - [x] 1) Add a lightweight container and layout scaffolding
  - [ ] 2) Center the logo and add top spacing

- Also update the repository's todo or project board if present (the assistant will do this when requested).

Commit messages and small-commit guidance
- Keep commit messages short and precise. Examples:
  - `login: add scroll container and padding`
  - `login: center logo and add top spacing`
  - `login: style primary sign-in button`
- Each commit should reference the step number from this file in the message for easy traceability.

If something is unclear
- Stop and ask the user (do not guess). Provide two concrete options when asking (e.g., "Use 12px or 16px corner radius?").
- If the user doesn't respond, follow the screenshot as a fallback but keep app text as source of truth.

Acceptance criteria for completing the whole task
- The login view on a mobile emulator looks like the screenshot in composition (logo, heading, purple CTA, divider, email field, Continue button) and behaves as described.
- All code changes were made as multiple small commits, each 10–30 lines.
- The prompt file has been used as the reference and steps have been ticked off.

----

Appendix: small implementation examples (for implementer reference only)
- Example: simple email RegExp (use locally):
  final emailRegex = RegExp(r"^[^@\s]+@[^@\s]+\.[^@\s]+$");

- Example: disabled button pattern (pseudo-Flutter):
  ElevatedButton(
    onPressed: isEmailValid ? _onContinue : null,
    child: Text('Continue'),
  )

Remember: these snippets are examples — match the project's existing patterns (state management, localization).

End of prompt file.

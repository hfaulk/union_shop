# Cart Bubble (Badge) Implementation Prompt for the Assistant

Purpose
- This document is the authoritative spec for implementing a small cart count 'bubble' on the app header’s cart icon. Re-open and follow this file for each small commit and tick off milestones as you complete them.

Principles & Requirements
- Small commits only: Every code change must be between 10–30 lines. If a change would exceed this, break it into logical sub-changes.
- Keep UI changes minimal, visually consistent with current header, and accessible.
- Always check this file before starting a work session, and mark milestones as you progress.

What we will implement
- Add a visible bubble that shows the number of cart items next to the shopping bag icon in the header.
- Do not show a number if the cart is empty (count == 0).
- Show exact numbers for counts 1–99; for counts >= 100 display "99+".
- Bubble should be visually small, circular, with a contrasting background (e.g., error color red) and white text.
- Bubble should update in real time when the cart contents change.
- Keep changes minimal to keep commits small and easy to review.

Targeted files (where to make changes)
- `lib/widgets/shared_layout.dart` — contains the header and currently shows the shopping cart icon:
  - Replace or wrap the existing `IconButton` with a `Stack` that shows a shopping bag icon and a `CartBubble` widget.
- `lib/widgets/cart_bubble.dart` — new small widget file to render the bubble; keep this to a minimal widget that only accepts a `count` and optional `max`.

Constraints & details
- The app exposes a global `appCartViewModel` which is a `ChangeNotifier`. Use it as a `Listenable` and wrap the icon area with an `AnimatedBuilder` or equivalent to get rebuilds.
- If `appCartViewModel` is null, treat count as 0.
- Avoid adding heavy dependencies or state management libraries for this single feature.
- Make sure the header remains stateless or minimally intrusive: use `AnimatedBuilder(animation: appCartViewModel, builder: ...)` or `ValueListenableBuilder` where appropriate.

Accessibility
- Use `Semantics` with a label such as "Cart — 0 items" or "Cart — 1 item" or "Cart — 99+ items".

Behavior and edge cases
- When count == 0: do not show the bubble.
- When count >= 100: show `99+`.
- When the cart changes due to `CartViewModel`, the bubble should update immediately.
- Clicking the icon still navigates to `/cart`.

Suggested small-commit steps and example line targets (10–30 lines each)
- Commit 1 (10–25 lines): Add `lib/widgets/cart_bubble.dart` with a minimal `StatelessWidget`:
  - Exposes `count` (int) and `maxDisplay` (int, default 99).
  - Returns `Visibility` hidden for 0; else `Container` circle with text. (10–25 lines)
  - Add a small unit test file optional in later commit.

- Commit 2 (10–20 lines): In `lib/widgets/shared_layout.dart`:
  - Import `cart_bubble.dart`.
  - Wrap the existing `IconButton` and replace with `Stack` where the `CartBubble` is a `Positioned` widget anchored top-right.
  - Keep `onPressed` unchanged to navigate to `/cart`.
  - Use `AnimatedBuilder(animation: appCartViewModel ?? AlwaysStoppedAnimation(0), builder: ...)` to rebuild the icon area when cart changes. (10–20 lines)

- Commit 3 (10–15 lines): Add `Semantics` wrapper in `shared_layout.dart` or inside `cart_bubble.dart` to make the bubble accessible and include a localized label (singular/plural logic). (10–15 lines)

- Commit 4 (10–25 lines): Update existing icon styling if needed (e.g., bubble size, color, font size). Keep CSS-like numbers small. Optionally add an animated slide/scale effect when the count changes (keep small!). (10–25 lines)

- Commit 5 (10–20 lines): Add tests or a small runtime check in `test/widgets/cart_bubble_test.dart` verifying:
  - Bubble hidden when 0.
  - Bubble shows 1 for 1 item.
  - Bubble shows "99+" for numbers >=100.
  - Clicking the icon still navigates to `/cart`.

Implementation guidance & sample code samples (short snippets — adapt as needed)
- `lib/widgets/cart_bubble.dart` example:
  ```dart
  import 'package:flutter/material.dart';

  class CartBubble extends StatelessWidget {
    final int count;
    final int maxDisplay;
    const CartBubble({super.key, required this.count, this.maxDisplay = 99});

    String displayText() {
      if (count <= 0) return '';
      return count <= maxDisplay ? '$count' : '${maxDisplay}+';
    }

    @override
    Widget build(BuildContext context) {
      if (count <= 0) return const SizedBox.shrink();
      final txt = displayText();
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
        child: Text(txt, style: const TextStyle(color: Colors.white, fontSize:12)),
      );
    }
  }
  ```
  (This is just an example; break the implementation into small changes.)

- `shared_layout.dart` changes (rough snippet — make small commits):
  - Before commit, ensure we import the new widget.
  - Replace current `IconButton` with:
  ```dart
  AnimatedBuilder(
    animation: appCartViewModel ?? Listenable.merge([]),
    builder: (context, _) {
      final count = appCartViewModel?.items.length ?? 0;
      return InkWell(
        onTap: () => Navigator.pushNamed(context, '/cart'),
        child: Stack(
          children: [Icon(Icons.shopping_bag_outlined), Positioned(...CartBubble(count: count)...)]
        ),
      );
    },
  ),
  ```
  - Break into sub-commits: first import & stack structure, then AnimatedBuilder and logic updates.

Testing and verification (manual steps after each commit)
- After Commit 1: build & run; no UI change (file added). Run `dart analyze` or `flutter analyze`.
- After Commit 2: open app and verify header shows icon with small bubble only when you have items in cart (if you currently have items, you should see it). If not, add items from product page to see behavior.
- After Commit 3: use screen reader tools or `SemanticsTester` to verify label.
- After Commit 4: validate bubble visuals on desktop / narrow width / mobile.
- After Commit 5: run new tests.

Developer instructions to the assistant
- ALWAYS open this file at the start of a session and pick the next unchecked milestone.
- After each commit-sized change (≤30 lines), stop, include a one-line summary and list of files changed, and wait for the user to commit/approve before continuing.
- Provide `git diff` (or the patch) before applying each change and the precise approximate line count change.
- If a change requires more than 30 lines, split it into smaller steps.
- Prefer adding a small new widget file `cart_bubble.dart` rather than embedding too much logic into `shared_layout.dart`.

Milestones (tick off as you complete each commit)
- [ ] 1. Create `lib/widgets/cart_bubble.dart` with `CartBubble` widget.
- [ ] 2. Add `Stack`+`CartBubble` into `shared_layout.dart` (first pass: static count or stubbed value).
- [ ] 3. Connect `CartBubble` to `appCartViewModel` using `AnimatedBuilder` and ensure real-time updates.
- [ ] 4. Add accessibility labels (`Semantics`) and friendly text when the bubble is present.
- [ ] 5. Add tests (optional but recommended) and final polish.

Acceptance Criteria
- The header shows a bubble with the current cart count if count > 0; no bubble when 0.
- The bubble displays `99+` if the count is 100 or greater.
- Bubble updates with `CartViewModel` changes in real time.
- The header navigation behavior to `/cart` remains unchanged.
- Each change is committed as a small, reviewable patch of 10–30 lines.

If anything is ambiguous — ask ONE focused question.

---

End of `cart_bubble_prompt.md` file

**Hero Carousel Implementation Prompt (for `lib/widgets/hero_carousel.dart`)**

Goal
- Implement a simple, fully functional hero carousel to replace the current hero section. The carousel should present slides that share the same layout: background image, hero title, hero description, and a primary CTA button. Behavior and visual appearance should mimic the attached screenshot and the carousel used on `shop.upsu.net` — large centered title, smaller centered description, a primary button centered beneath the description, and navigation dots and arrows at the bottom.

High-level Requirements
- Each slide: background image (cover), overlay (soft darken), title, description, CTA (text + route/url). All elements centered horizontally.
- Carousel controls: indicator dots, previous/next arrows (start simple: autoplay + pause on user interaction).
- Accessibility: semantic labels for images and controls, focusable buttons.
- Responsive: maintain layout across typical phone/tablet/desktop breakpoints.
- Minimal dependencies: prefer built-in Flutter widgets (`PageView`, `AnimatedBuilder`, `AnimatedOpacity`, `GestureDetector`) and avoid heavy new packages.
- Incremental changes: every code change must be limited to small patches (preferably ≤20 lines changed) so the commit history is fine-grained.

Suggested Files & Locations
- `lib/widgets/hero_carousel.dart` — the main widget (stateless + internal state or stateful widget) that renders the carousel.
- `lib/models/hero_slide.dart` — a small model for slides: fields `image`, `title`, `description`, `buttonText`, `route` (or `url`).
- `data/hero_slides.json` (optional) — sample slides if you prefer externalizing slide data rather than hard-coding.
- Update: `lib/main.dart` — replace the existing hero section with the carousel widget (one small change at a time).

Data Model (example)
- class HeroSlide {
    final String image; // asset path
    final String title;
    final String description;
    final String buttonText;
    final String routeOrUrl;
  }

Functional Behavior
- Autoplay: on by default. Interval configurable (e.g., 6s). Should pause when user interacts (swipe or press arrow/dot).
- Looping: true (infinite loop).
- Indicators: centered dots at bottom; tapping a dot moves to that slide.
- Arrows: left/right arrow buttons near bottom center (or just above dots). Tapping moves one slide.
- Animation: smooth page transitions (PageView default physics is good), subtle fade on overlay if desired.

Visual Specs (as in screenshot)
- Huge title, bold, white, shadow/soft outline for legibility.
- Subtitle/description smaller, white, centered.
- Button: purple background (`#4b2e6d` or app primary), uppercase small text with letter spacing.
- Background: full-bleed image using `BoxFit.cover` with an overlay gradient or semi-transparent dark color to ensure text contrast. (for now use a placeholder image)

Accessibility
- Use `Semantics` for the carousel region and each control.
- Provide `semanticLabel` for images and CTA buttons.
- Make indicators and arrows keyboard-focusable (use `InkWell` or `IconButton`).

Testing
- Add a widget test that pumps the carousel with sample slides and verifies:
  - The first slide's title is present.
  - Tapping next arrow changes the displayed page.
  - Indicators update accordingly.
- Manual testing instructions: Run `flutter run -d chrome` or use an emulator. Verify keyboard navigation, screen-reader text, and responsiveness.

Implementation Plan (small incremental commits — each suggested step is intentionally small)
- Step 1 (small): Add the `HeroSlide` model file `lib/models/hero_slide.dart` (≈15–25 lines). Commit: "Add HeroSlide model".
- Step 2 (small): Create `lib/widgets/hero_carousel.dart` with a scaffolded `StatefulWidget` and a hard-coded list of 2-3 sample `HeroSlide` instances inside the widget (start with in-widget list to avoid data loading). Keep implementation minimal — display a `Container` with placeholder text to confirm integration. Commit: "Add hero carousel skeleton".
- Step 3 (small): Replace placeholder with a `PageView` that shows each slide's background image and overlays title/description/button using a simple `Stack`. Keep changes localized to `hero_carousel.dart` (≤20 lines per patch where possible). Commit: "Render slides with PageView".
- Step 4 (small): Add indicator dots below the `PageView`. Use a small helper method to build dots; update state on page change. Commit: "Add slide indicators".
- Step 5 (small): Add left/right arrow buttons and wire them to animate the `PageController`. Commit: "Add navigation arrows".
- Step 6 (small): Add autoplay timer that advances pages on interval; pause on user interaction (touch or arrow/dot press). Commit: "Add autoplay and pause behavior".
- Step 7 (small): Extract sample slide list into `data/hero_slides.json` or into `lib/models/hero_slide.dart` as static list. Alternatively, make the carousel accept a `List<HeroSlide>` in constructor. Commit: "Externalize slide data".
- Step 8 (small): Integrate `HeroCarousel` into `lib/main.dart` replacing the old hero — perform in 1-2 line change (import + widget swap). Commit: "Replace hero with HeroCarousel".
- Step 9 (small): Accessibility and tests: add `Semantics` wrappers, keyboard handling, and create `test/hero_carousel_test.dart`. Commit: "Add accessibility and tests".
- Step 10 (small): Polish styles, responsive text sizes, and finalize README notes. Commit: "Style and docs polish".

Developer Constraints (required by you)
- Never change more than ~10-20 lines at a time. Use many small commits for each step above (can break down further if needed).
- Keep changes localized: create new files where possible instead of touching large files.
- Use clear commit messages matching the steps.

Patch Guidance Examples (how to keep patches small)
- When adding `HeroSlide` model: only add that one file — around 20 lines.
- When updating `hero_carousel.dart`: break up work into commits that each add a single feature (PageView, indicators, arrows, autoplay).
- When changing `lib/main.dart`: do a single small replace of the hero section with the new widget import and invocation.

Commands (powershell)
```
# Run app in chrome for quick UI checks
flutter pub get; flutter run -d chrome

# Run tests
flutter test
```

Feature Checklist
- [ ] Slide background image with cover + overlay
- [ ] Title text: large, centered, white
- [ ] Description text: medium, centered
- [ ] CTA button: centered, themed, accessible
- [ ] PageView-based slide rendering
- [ ] Indicator dots (clickable/focusable)
- [ ] Previous/Next arrows (clickable/focusable)
- [ ] Autoplay with configurable interval
- [ ] Pause on user interaction
- [ ] Infinite looping
- [ ] Keyboard left/right navigation
- [ ] Semantics labels for screen readers
- [ ] Widget tests (basic interactions)
- [ ] Small-line-change incremental commits

Implementation Status Ticker
- Prompt file creation: [x]
- Plan / TODOs initialized: [x]
- Step 1 — Model: [ ]
- Step 2 — Skeleton widget: [ ]
- Step 3 — PageView slides: [ ]
- Step 4 — Indicators: [ ]
- Step 5 — Arrows: [ ]
- Step 6 — Autoplay: [ ]
- Step 7 — Data externalization: [ ]
- Step 8 — Integrate into `lib/main.dart`: [ ]
- Step 9 — Accessibility & tests: [ ]
- Step 10 — Polish & docs: [ ]

Notes and Edge Cases
- If the current hero is implemented in a single giant widget, prefer wrapping it and toggling display to avoid breaking unrelated code. But the final plan expects replacing it by a widget import and a single-line swap.
- If images are remote, add an async loader or use `FadeInImage` with placeholder. For simplicity prefer packaged assets from `assets/`.
- Keep asset paths consistent with existing `pubspec.yaml`. If adding new assets, update `pubspec.yaml` in a separate small commit.

Example Minimal API Signature
- class `HeroCarousel extends StatefulWidget` {
    final List<HeroSlide> slides;
    final Duration autoPlayInterval; // default 6s
    final bool autoPlay; // default true
  }

Acceptance Criteria
- The hero area is replaced by the carousel and shows at least 2 slides.
- Indicators and arrows work for navigation.
- Autoplay advances slides and pauses on user interaction.
- Visuals match screenshot style (centered title, description, CTA, overlayed background image).
- All code changes are committed in small patches (≤20 lines changed per commit) per the developer constraint.

---

Implementation Status (human-readable ticker — update as you progress)
- [x] Write `hero_carousel_prompt.md`
- [ ] Implement steps 1–10 incrementally with small commits

If you want, I can now start by implementing Step 1: create `lib/models/hero_slide.dart` (a single small file). I will follow the "≤20 lines per change" rule when making code edits; please confirm and I'll proceed.

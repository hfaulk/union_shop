Purpose
-------
This document is a precise, comprehensive prompt to guide implementing tests for the `union_shop` Flutter project. The tester (human or automated assistant) must follow the instructions, conventions, and constraints below when adding new tests and related changes.

Hard constraint (must follow)
- Do NOT modify more than 20–30 lines in a single change/commit. If a change requires more than 20–30 lines of edits, break it into multiple smaller commits and pause so the repository owner can review and commit before continuing.

Scope and goals
- Implement tests for everything currently implemented in the project (models, repositories, view models, views, widgets). Prioritize correctness, realism, and isolation (unit vs widget vs integration testing).
- Keep tests deterministic and fast. Favor unit tests and widget tests. Add integration tests only where user flows need full app wiring.

Test framework and dependencies
- Use Flutter's built-in test packages: `flutter_test` and `test` for unit/widget tests.
- For mocking and fakes, prefer `mocktail` (or `mockito` if specifically requested). Add dev_dependencies only when strictly necessary, and add them in a separate commit limited to <=30 lines.
- When new dev dependencies are required, commit the `pubspec.yaml` change separately from test code (one small commit to add dependency, then another to add tests that use it).

File structure and naming conventions
- Place tests under the `test/` folder mirroring `lib/` structure where appropriate:
  - `test/models/product_test.dart` for `lib/models/product.dart`
  - `test/repositories/product_repository_test.dart` for `lib/repositories/product_repository.dart`
  - `test/widgets/hero_carousel_test.dart` for `lib/widgets/hero_carousel.dart`
  - `test/views/collections_test.dart` for `lib/views/collections.dart`
- Name test files `<subject>_test.dart` and test groups using the subject name (e.g., `group('Product', () { ... })`).

Testing principles and style
- Use Arrange / Act / Assert structure in each test.
- Keep tests small: one assertion or small set of related assertions per test.
- Avoid modifying production files to make tests pass. If a production change is required, split the change across commits and keep each commit small (<=30 lines). Pause for user commit when >30 lines total changes are required.
- Use fixtures: the `data/` directory contains JSON fixtures (`collections.json`, `hero_slides.json`, `home_config.json`, `products.json`). Use those as grounded inputs for parsing tests.

Recommended test categories and examples (implement these first)
- Models (unit tests)
  - JSON serialization/deserialization: verify `fromJson` and `toJson` round-trip for `Product`, `Collection`, `HeroSlide`, and `HomeConfig` using the fixtures in `data/`.
  - Value equality / hashCode: if models implement equality, assert equality and hash behavior.

- Repositories (unit tests with mocks or local file reads)
  - Test `ProductRepository`, `CollectionRepository`, and `HomeRepository` for expected returns when reading the `data/` JSON files.
  - If repositories use network or file I/O, mock network / file APIs. Example: mock a `RootBundle` or file reader to return fixture contents.

- Widgets (widget tests)
  - `HeroCarousel`: assert it builds and displays the expected number of slides given a `HomeConfig` with slides. Use `WidgetTester` to pump the widget and examine the widget tree.
  - `SharedLayout`: assert the presence of common app bars, drawers, or bottom navigation widgets.
  - `ProductPage` and `CollectionPage`: pump with sample product/collection and assert the expected text and images appear.

- Views / navigation (widget or integration tests)
  - Simple navigation flows: build a `MaterialApp` with routes, pump, tap navigation links, and assert the pushed route contains expected widgets.

Test templates (copy/paste-ready examples)
- Unit test for a model (example):
```
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/product.dart';

void main() {
  test('Product JSON round-trip from fixture', () {
    final jsonStr = '''<replace-with-fixture-contents>''';
    final map = json.decode(jsonStr) as Map<String, dynamic>;
    final product = Product.fromJson(map);
    expect(product, isA<Product>());
    expect(product.toJson(), equals(map));
  });
}
```

- Widget test template (example):
```
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/hero_carousel.dart';

void main() {
  testWidgets('HeroCarousel shows slides', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: HeroCarousel(slides: /* supply list of slides */)),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.byType(HeroCarousel), findsOneWidget);
    // Further expectations: count slides, check titles/texts
  });
}
```

Loading fixture JSON in tests
- Prefer reading JSON files from disk using `File` and `Platform.script` relative paths in pure Dart tests, or include fixture strings in the test file for simplicity.
- Alternatively, place small fixture snippets in the `test/fixtures/` folder and read them via `File('test/fixtures/sample.json').readAsStringSync()`.

Mocking
- Use `mocktail` to create lightweight mocks and fakes. Example pattern:
```
class MockProductRepository extends Mock implements ProductRepository {}

setUp(() { registerFallbackValue(<YourType>[]); });
```

Commands and workflows
- Run all tests: `flutter test`
- Run a single test file: `flutter test test/models/product_test.dart`
- When adding dev dependencies: after updating `pubspec.yaml`, run `flutter pub get`.

Commit strategy to honor the line-limit constraint
- Atomic test additions: commit one test file at a time where possible. Keep each commit under 30 changed lines.
- If a test requires a small production fix (e.g., expose a constructor or add a `toJson` helper), make that fix in a separate commit, limited to <=30 lines. Then add tests in the next commit.
- If adding a dependency requires modifying several sections in `pubspec.yaml`, keep the change minimal and under 30 lines; typically adding one or two dev_dependencies is within this limit.

Checklist (implement in this order)
1. Ensure dev_dependencies are available (separate small commit).
2. Add model unit tests for all files in `lib/models/` using `data/` fixtures.
3. Add repository unit tests mirroring `lib/repositories/`, mocking I/O where necessary.
4. Add widget tests for `lib/widgets/*` (one file / commit per widget if large).
5. Add view tests and small navigation tests.
6. Run `flutter test` and fix flakiness.

Notes and best practices
- Keep tests readable and maintainable. Favor explicit setup and teardown for shared resources.
- Avoid editing many production files to make tests pass. If required, keep production edits minimal and split across commits.
- After each logical set of changes, run tests locally and keep commit sizes small.

When you finish implementing the tests
- Stop and ask the repo owner to review and commit. If additional changes are needed, create another small batch of edits and repeat the process.

Contact
- If anything in the prompt is ambiguous or requires clarification (e.g., preferred mocking library or CI behavior), pause and ask before making changes that would exceed the line-change constraint.

End of prompt

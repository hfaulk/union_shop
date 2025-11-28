# Union Shop

Union Shop is a lightweight Flutter e-commerce demo app built for university students.
It provides a simple storefront to browse products, add items to a persistent cart,
and run through basic checkout flows (for demo purposes).

Key features:
- Browse products and collections sourced from local JSON data.
- Hero carousel and responsive product cards for multiple screen sizes.
-- Persistent cart saved locally; simple checkout simulation.

## Installation & Setup

Prerequisites:
- Flutter SDK (stable channel, recommended version >= 3.0), Dart, and the
	appropriate platform tools (Android Studio for Android, Xcode for iOS).
- OS: Windows/Linux/macOS with required SDKs installed.

Clone and install dependencies:
```bash
git clone <repo-url>
cd union_shop
flutter pub get
```

Run the app:
- On a connected Android/iOS device or emulator: `flutter run`
- For web debugging: `flutter run -d chrome`

## Usage & Tests

Usage:
- Open the app, browse collections on the home screen, and tap a product to view details.
- Tap `Add to cart` on a product to place it in the persistent cart stored locally in `data/cart.json`.
- Open the cart from the top-right to review items, adjust quantities, or simulate checkout.

Configuration:
- Product data is loaded from the `data/` folder (`products.json`, `collections.json`).

Running tests:
- Unit/widget tests are in the `test/` folder. Run `flutter test` to execute them.

Screenshots/GIFs:
- Add images to `docs/screenshots/` and reference them here, e.g. `![Home screen](docs/screenshots/home.png)`.

## Project Structure & Technologies

- Project layout (brief): `lib/` (source), `data/` (sample JSON), `assets/`, `test/`, `prompts/`, and platform folders (`android/`, `ios/`, `web/`).
- Key files: `lib/main.dart` (app entry), `pubspec.yaml` (dependencies), `data/*.json` (product and cart data), `test/` (unit & widget tests).
- Technologies: Flutter (Dart), standard Flutter toolchain (Flutter CLI, Android Studio, Xcode for iOS builds).
- Dependencies: see `pubspec.yaml` for the exact package list; this project uses local JSON assets and Flutter widgets for UI.


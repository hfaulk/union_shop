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
git clone https://github.com/hfaulk/union_shop.git
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

## Project Structure & Technologies

- Project layout (brief): `lib/` (source), `data/` (sample JSON), `assets/`, `test/`, `prompts/`, and platform folders (`android/`, `ios/`, `web/`).
- Key files: `lib/main.dart` (app entry), `pubspec.yaml` (dependencies), `data/*.json` (product and cart data), `test/` (unit & widget tests).
- Technologies: Flutter (Dart), standard Flutter toolchain (Flutter CLI, Android Studio, Xcode for iOS builds).
- Dependencies: see `pubspec.yaml` for the exact package list; this project uses local JSON assets and Flutter widgets for UI.

-- Project tree:
```text
.
├── README.md
├── pubspec.yaml
├── lib/
│   ├── main.dart
│   ├── helpers/
│   ├── models/
│   ├── repositories/
│   ├── view_models/
│   ├── views/
│   └── widgets/
├── assets/
│   └── data/
│       ├── products.json
│       ├── collections.json
│       └── cart.json
├── prompts/
├── test/
├── android/
├── ios/
├── web/
└── other platform folders (linux/, macos/, windows/)
```
## Known Issues & Contributing

- Known limitations:
	- No real payment processing; checkout is a simulation for demo purposes.
	- Data is stored in local JSON (not a remote backend); concurrency and sync are not handled.
	- Accessibility and localization are limited and may need improvements.

- Contributing:
	- Open an issue for bugs or feature requests. Fork the repo, create a branch, and submit a pull request.
	- Follow existing code style and include tests for new logic where possible.

## Contact Information

- Maintainer: `Harry Faulkner`
- Email: `up23505969@myport.ac.uk`
- GitHub: `https://github.com/hfaulk/union_shop`
- More projects / profile: `https://github.com/hfaulk`

If you'd like to contribute or request features, open an issue or submit a pull request on GitHub.


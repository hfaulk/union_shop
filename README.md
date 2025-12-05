# Union Shop

Union Shop is a lightweight Flutter e-commerce demo app built for university students.
It provides a simple storefront to browse products, add items to a persistent cart,
and run through basic checkout flows (for demo purposes).

Key features:
- Browse products and collections sourced from local JSON data.
- Hero carousel and responsive product cards for multiple screen sizes.
- Persistent cart saved locally; simple checkout simulation.

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

- Project layout (brief): `lib/` (source), `assets/` (JSON data & images), `test/` (unit & widget tests), `prompts/` (development notes), and platform folders (`android/`, `ios/`, `web/`, `linux/`, `macos/`, `windows/`).
- Key files: `lib/main.dart` (app entry), `pubspec.yaml` (dependencies), `assets/data/*.json` (product, collection, cart, and config data), `test/` (unit & widget tests).
- Technologies: Flutter (Dart), standard Flutter toolchain (Flutter CLI, Android Studio, Xcode for iOS builds).
- Dependencies: `shared_preferences` (persistent storage), `path_provider` (file system access), `cupertino_icons` (iOS icons). See `pubspec.yaml` for full list.

### Project tree
```text
.
├── README.md
├── pubspec.yaml
├── analysis_options.yaml
├── lib/
│   ├── main.dart
│   ├── helpers/
│   │   └── search_helper.dart
│   ├── models/
│   │   ├── cart_item.dart
│   │   ├── collection.dart
│   │   ├── hero_slide.dart
│   │   ├── home_config.dart
│   │   └── product.dart
│   ├── repositories/
│   │   ├── cart_repository.dart
│   │   ├── collection_repository.dart
│   │   ├── home_repository.dart
│   │   └── product_repository.dart
│   ├── view_models/
│   │   └── cart_view_model.dart
│   ├── views/
│   │   ├── home_view.dart
│   │   ├── product_page.dart
│   │   ├── collection_page.dart
│   │   ├── collections.dart
│   │   ├── cart_page.dart
│   │   ├── search_screen.dart
│   │   ├── login.dart
│   │   └── about.dart
│   └── widgets/
│       ├── product_card.dart
│       ├── product_card_impl.dart
│       ├── product_image_area.dart
│       ├── product_info_area.dart
│       ├── cart_bubble.dart
│       ├── hero_carousel.dart
│       ├── search_overlay.dart
│       └── shared_layout.dart
├── assets/
│   ├── data/
│   │   ├── products.json
│   │   ├── collections.json
│   │   ├── cart.json
│   │   ├── home_config.json
│   │   └── hero_slides.json
│   └── images/
├── test/
│   ├── unit/
│   ├── views/
│   ├── widgets/
│   ├── models/
│   ├── repositories/
│   ├── view_models/
│   ├── helpers/
│   ├── scripts/
│   └── [individual test files]
├── prompts/
├── android/
├── ios/
├── web/
├── linux/
├── macos/
├── windows/
└── other configuration files
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


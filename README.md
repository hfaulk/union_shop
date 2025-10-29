# Union Shop - Flutter Coursework

This repository contains the coursework project for students enrolled in the **Programming Applications and Programming Languages (M30235)** and **User Experience Design and Implementation (M32605)** modules at the University of Portsmouth.

## Project Overview

The Union Shop is a Flutter reimplementation of the existing University of Portsmouth Students' Union shop website ([https://shop.upsu.net](https://shop.upsu.net)). Students will recreate the key features and functionality of this e-commerce platform using Flutter, focusing on both web and mobile responsive design.

**Important Note:** You should NOT implement the external UPSU website ([https://www.upsu.net/](https://www.upsu.net/)) that is linked in the navigation bar of the shop. Focus only on reimplementing the shop functionality from [https://shop.upsu.net](https://shop.upsu.net).

_[SCREENSHOT PLACEHOLDER: Add screenshot highlighting the UPSU link that should NOT be implemented]_

## Current Features

This starter repository provides a minimal skeletal structure with:

- **Homepage** (`lib/main.dart`): A basic homepage
- **Product Page** (`lib/product_page.dart`): A single product page
- **Widget Tests**: Basic tests for both of the above pages (`test/home_test.dart` and `test/product_test.dart`)

## Getting Started

### Prerequisites

You have three options for your development environment:

1. **Firebase Studio** (browser-based, no installation required)
2. **University Windows computers** (via AppsAnywhere)
3. **Personal computer** (Windows or macOS)

#### Quick Setup Guide

**Firebase Studio (Recommended for Quick Start):**

- Access [idx.google.com](https://idx.google.com) with a personal Google account
- Create a new workspace (template selection not needed for this coursework)
- Clone your forked repository using the command palette

**University Computers:**

- Use [AppsAnywhere](https://appsanywhere.port.ac.uk/sso) to install:
  - Git
  - Flutter And Dart SDK
  - Visual Studio Code

**Personal Windows Computer:**

- Install [Chocolatey package manager](https://chocolatey.org/install)
- Run in PowerShell (as Administrator):

  ```powershell
  choco install git vscode flutter -y
  ```

**Personal macOS Computer:**

- Install [Homebrew package manager](https://brew.sh/)
- Run in Terminal:

  ```bash
  brew install --cask visual-studio-code flutter
  ```

#### Verify Installation (Skip if using Firebase Studio)

After installation, verify your setup by running:

```bash
flutter doctor
```

This command checks your environment and displays a report of the status of your Flutter installation.

**For detailed step-by-step instructions**, refer to [Worksheet 1 — Introduction to Flutter](https://manighahrmani.github.io/sandwich_shop/worksheet-1.html), which covers the complete setup process for all three options.

### Step 1: Fork the Repository

**IMPORTANT: Your fork MUST be public for assessment purposes.**

1. Navigate to the original repository: [https://github.com/manighahrmani/union_shop](https://github.com/manighahrmani/union_shop)
2. Click the "Fork" button in the top-right corner of the page
3. Ensure the repository is set to **Public**
4. Click "Create fork"
5. Make a note of your forked repository URL (e.g., `https://github.com/YOUR-USERNAME/union_shop` where `YOUR-USERNAME` is your GitHub username)

_[SCREENSHOT PLACEHOLDER: Add screenshot showing the Fork button]_

_[SCREENSHOT PLACEHOLDER: Add screenshot showing the Public option when forking]_

### Step 2: Clone Your Forked Repository

Open your terminal or command prompt and run:

#### On Windows (PowerShell/Command Prompt)

```powershell
git clone https://github.com/YOUR-USERNAME/union_shop.git
cd union_shop
```

Replace `YOUR-USERNAME` with your actual GitHub username.

#### On macOS (Terminal)

```bash
git clone https://github.com/YOUR-USERNAME/union_shop.git
cd union_shop
```

Replace `YOUR-USERNAME` with your actual GitHub username.

**Note:** Replace `YOUR-USERNAME` with your actual GitHub username.

### Step 3: Install Dependencies

Navigate to the project directory and install the required Flutter packages:

#### On Windows

```powershell
flutter pub get
```

#### On macOS

```bash
flutter pub get
```

This command downloads all the dependencies specified in the `pubspec.yaml` file.

### Step 4: Run the Application

This application is primarily designed to run on **web** and should be viewed in **mobile view** using browser developer tools.

#### Start the Flutter Web App

**On Windows:**

```powershell
flutter run -d chrome
```

**On macOS:**

```bash
flutter run -d chrome
```

This will launch the app in Google Chrome.

#### Enable Mobile View (Responsive Design Mode)

Once the app is running in Chrome:

1. Open Chrome DevTools:
   - **Windows**: Press `F12` or `Ctrl + Shift + I`
   - **macOS**: Press `Cmd + Option + I`
2. Click the "Toggle device toolbar" button (or press `Ctrl + Shift + M` on Windows, `Cmd + Shift + M` on macOS)

3. Select a mobile device preset (e.g., iPhone 12 Pro, Pixel 5) or set custom dimensions

_[SCREENSHOT PLACEHOLDER: Add screenshot showing Chrome DevTools with mobile view enabled]_

_[SCREENSHOT PLACEHOLDER: Add screenshot showing the device toolbar toggle button]_

### Running Tests

To run the widget tests:

```bash
flutter test
```

To run tests for a specific file:

```bash
flutter test test/home_test.dart
flutter test test/product_test.dart
```

### Assessment Criteria

In short, your objective is to reimplement the features and functionality of the existing Union Shop website ([https://shop.upsu.net](https://shop.upsu.net)) using Flutter. For detailed task requirements and marking criteria, please refer to the coursework document:

**[Coursework Document](https://portdotacdotuk-my.sharepoint.com/:w:/g/personal/mani_ghahremani_port_ac_uk/EbM1UcwOHMRLmcKeI0btHqYBeZ3ADWjyN0EXBWdHLhsO_g?e=FDEQLt)**

This document outlines the specification for your coursework, the breakdown of marks, submission guidelines, and deadlines.

## Project Structure

```plaintext
union_shop/
├── lib/
│   ├── main.dart           # Main application and homepage
│   └── product_page.dart   # Product detail page
├── test/
│   ├── home_test.dart      # Homepage widget tests
│   └── product_test.dart   # Product page widget tests
├── pubspec.yaml            # Project dependencies
└── README.md               # This file
```

Note that this is the initial structure. You are of course expected to create additional files and directories as needed to complete the coursework.

## Support and Resources

For questions or issues related to this coursework use [the dedicated Discord channel](https://portdotacdotuk-my.sharepoint.com/:b:/g/personal/mani_ghahremani_port_ac_uk/EbX583gvURRAhqsnhYqmbSEBwIFw6tXRyz_Br1GxIyE8dg). Please first check the existing posts in the forum to see if your question has already been answered before posting a new question.

Use the worksheets listed on [the homepage](https://manighahrmani.github.io/sandwich_shop/) as your primary learning resource for Flutter development. You must refrain from using other online resources such as Stack Overflow, YouTube tutorials, or other websites for this coursework as they may contain outdated or incorrect information.

### Important Git Tips

**Commit regularly!** Save your progress frequently by committing your changes to Git. This creates checkpoints you can return to if needed.

```bash
git add .
git commit -m "Brief description of what you changed"
git push
```

If you made a small mistake, you can revert to a previous commit:

1. View your commit history: `git log --oneline`
2. Find the commit hash (e.g., `abc1234`) where things were working
3. Revert to that commit: `git reset --hard abc1234`
4. Force push if needed: `git push --force`

If things are completely broken and are unrecoverable, you can start fresh by re-forking the repository:

1. Delete your forked repository on GitHub (Settings → Danger Zone → Delete this repository)
2. Fork the original repository again: [https://github.com/manighahrmani/union_shop](https://github.com/manighahrmani/union_shop)
3. **Remember to keep it public!**
4. Clone your fresh fork and start again

Regular commits not only help you recover from mistakes, but also demonstrate your development process. Remember you are marked based on your commits.

## License

This project is created for educational purposes as part of the University of Portsmouth coursework.

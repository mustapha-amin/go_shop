# GoShop - Your Ultimate Shopping Companion

GoShop is a modern e-commerce mobile application built with Flutter, offering a seamless shopping experience with a beautiful UI and robust features.

## Features

- 🛍️ **Product Browsing**: Browse through a wide range of products with detailed information
- 🔍 **Smart Search**: Find products quickly with an intuitive search interface
- 🛒 **Shopping Cart**: Manage your shopping cart with real-time updates
- 👤 **User Profiles**: Personalized user profiles with order history
- 🔐 **Secure Authentication**: Firebase authentication for secure user management
- 💳 **Payment Integration**: Secure payment processing
- 📱 **Responsive Design**: Beautiful UI that works across different screen sizes
- 🌙 **Modern UI**: Built with ShadcnUI for a modern, clean interface

## Tech Stack

- **Framework**: Flutter
- **State Management**: Flutter Riverpod
- **Navigation**: Go Router
- **Backend**: Firebase
  - Authentication
  - Firestore Database
- **UI Components**: ShadcnUI
- **Icons**: Iconsax


## Project Structure

```
lib/
├── main.dart                 # Application entry point
├── firebase_options.dart     # Firebase configuration
├── core/
│   ├── extensions.dart
│   ├── providers.dart
│   ├── router.dart
│   └── utils/
├── features/
│   ├── auth/
│   ├── bottom_nav/
│   ├── cart/
│   ├── home/
│   ├── onboarding/
│   ├── profile/
│   └── search/
├── models/
├── services/
└── shared/
```

## Key Features Implementation

### Authentication Flow
- Onboarding for first-time users
- Secure login/signup
- Profile setup with user details

### Navigation
- Bottom navigation for main app sections
- Nested navigation for detailed views
- Deep linking support

### Shopping Experience
- Product listings with categories
- Detailed product views
- Shopping cart management
- Order tracking


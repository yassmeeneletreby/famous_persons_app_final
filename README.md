# Famous Persons App

A Flutter mobile application that allows users to explore famous persons, view their information, save favorite persons, and interact with an AI-powered chat feature.

## 📱 Project Overview

Famous Persons App is an educational Flutter project developed as a mobile application for discovering information about famous people.

The application provides a simple and user-friendly interface with multiple features including famous persons browsing, details, favorites, and AI chat.

## ✨ Features

- 🏠 Home screen for browsing famous persons
- 🔍 Famous persons data using an API
- 👤 Person details screen
- ❤️ Add and manage favorite persons
- 🤖 AI-powered chat feature
- 🌐 API integration
- ⏳ Loading states
- ⚠️ Error handling
- 📱 Responsive Flutter UI
- 🖼️ Person images and information

## 🛠️ Technologies Used

- Flutter
- Dart
- REST APIs
- Android Studio
- Gemini AI API
- TMDB API
- HTTP
- Shared Preferences

## 📂 Project Structure

```text
lib/
├── models/
│   └── person.dart
│
├── screens/
│   ├── home_screen.dart
│   ├── details_screen.dart
│   ├── favorites_screen.dart
│   └── chat_screen.dart
│
├── services/
│   ├── api_service.dart
│   ├── ai_service.dart
│   ├── favorites_service.dart
│   └── api_config.dart
│
├── widgets/
│   └── ...
│
└── main.dart

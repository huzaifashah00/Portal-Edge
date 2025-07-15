# 📘 Portal Edge

**Portal Edge** is a full-featured academic management platform developed as my **Final Year Project**. It combines an **admin panel (Laravel)** with **student-facing mobile apps (Flutter)** to streamline communication, administration, and academic services in educational institutes.

---

## 📂 Project Structure

### 🔹 `portal-edge-admin/`
> **Admin Panel – Laravel (PHP Framework)**  
This module includes the backend system for school or university administration. Admins can manage:
- Student records
- Class schedules
- Attendance
- Exams and results
- Notifications

### 🔹 `portal-edge-student/`
> **Student App – Flutter Android**  
This folder contains the mobile application designed for students. Features include:
- View attendance, results, and class schedule
- Receive real-time updates from the institution
- Submit assignments and receive grades

### 🔹 `portal-edge-connect/`
> **Shared Configuration & API Layer**  
Handles API connections and shared services that link the Flutter apps to the Laravel backend. It includes:
- API base URLs
- Shared constants and configs
- Common data models

---

## 🧪 How to Initialize the Project

### 🔧 For Laravel Admin (`portal-edge-admin`)
```bash
cd portal-edge-admin
composer install
cp .env.example .env
php artisan key:generate
php artisan migrate
php artisan serve

---

### 📱 For Flutter Student App (`connect-two`)
#### ✅ Requirements:
- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Android Studio or VS Code with Flutter extension
- A connected device or emulator
```bash
cd portal-edge-student
flutter pub get
flutter run

### 📱 For Flutter Admin and Teachers App (`connect-app`)
```bash
cd portal-edge-student
flutter pub get
flutter run


```bash
cd portal-edge-student          # Navigate into the Flutter project
flutter clean                   # Clean any previous builds
flutter pub get                 # Install dependencies
flutter run                     # Run on connected device or emulator

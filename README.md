# 🌿 گلدونی | Goldooni

اپلیکیشن فروشگاه آنلاین گل و گیاه، توسعه داده شده با Flutter و معماری Clean Architecture.

<p align="center">
  <img src="assets/screenshots/auth1.png" width="220"/>
  <img src="assets/screenshots/auth2.png" width="220"/>
  <img src="assets/screenshots/auth3.png" width="220"/>
</p>

<p align="center">
  <b>ثبت نام و ورود با OTP</b>
</p>

---

## 📸 اسکرین‌شات‌ها

### صفحه اصلی، محصولات و سبد خرید

<p align="center">
  <img src="assets/screenshots/home.png" width="250"/>
  <img src="assets/screenshots/products.png" width="250"/>
  <img src="assets/screenshots/cart.png" width="250"/>
</p>

### جزئیات محصول و پروفایل

<p align="center">
  <img src="assets/screenshots/single.png" width="250"/>
  <img src="assets/screenshots/profile.png" width="250"/>
</p>

---

## ✨ امکانات

* نمایش محصولات ویژه و جدید
* اسلایدر تبلیغاتی صفحه اصلی
* دسته‌بندی محصولات
* جستجوی سریع محصولات
* مشاهده جزئیات کامل هر محصول
* مدیریت سبد خرید
* ثبت سفارش
* ورود و ثبت‌نام با شماره موبایل (OTP)
* وبلاگ و مقالات تخصصی گل و گیاه
* نمایش موقعیت فروشگاه روی نقشه
* پشتیبانی کامل از زبان فارسی و راست‌چین (RTL)
* طراحی ریسپانسیو برای دستگاه‌های مختلف

---

## 🛠️ تکنولوژی‌ها و پکیج‌ها

| Package                  | Usage                  |
| ------------------------ | ---------------------- |
| flutter_bloc             | State Management       |
| get_it                   | Dependency Injection   |
| dio                      | HTTP Client            |
| flutter_osm_plugin       | OpenStreetMap          |
| flutter_screenutil       | Responsive UI          |
| geolocator               | Location Services      |
| shared_preferences       | Local Storage          |
| flutter_svg              | SVG Support            |
| carousel_slider          | Home Slider            |
| shimmer                  | Skeleton Loading       |
| animate_do               | UI Animations          |
| flutter_styled_toast     | Toast Notifications    |
| fpdart                   | Functional Programming |
| loading_animation_widget | Loading Widgets        |

---

## 🏗️ معماری پروژه

این پروژه بر اساس **Clean Architecture** و **BLoC Pattern** توسعه داده شده است.

```text
lib/
├── core/
│   ├── errors/
│   ├── resources/
│   ├── usecase/
│   ├── utils/
│   └── widgets/
│
├── feature/
│   ├── auth/
│   ├── blog/
│   ├── blog_single/
│   ├── cart/
│   ├── cats/
│   ├── home/
│   ├── profile/
│   ├── singleproduct/
│   └── splash/
│
├── di_container.dart
├── export_pkg.dart
└── main.dart
```

هر ماژول شامل سه لایه مستقل است:

### Data

ارتباط با API، مدل‌ها و منابع داده

### Domain

منطق تجاری، UseCaseها و Entityها

### Presentation

رابط کاربری و مدیریت State

---

## 🚀 نصب و اجرا

### پیش‌نیازها

* Flutter SDK 3.11+
* Dart SDK 3.11+
* Android Studio یا VS Code
* Emulator یا دستگاه فیزیکی

### اجرا

```bash
git clone https://github.com/FarzinNs83/goldooni.git

cd goldooni

flutter pub get

flutter run
```

---

## 🔤 فونت

این پروژه از فونت **Vazirmatn** استفاده می‌کند.

| Weight | Style    |
| ------ | -------- |
| 300    | Light    |
| 400    | Regular  |
| 500    | Medium   |
| 600    | SemiBold |
| 700    | Bold     |

---

## 🤝 مشارکت

از مشارکت شما استقبال می‌شود.

برای گزارش باگ‌ها یا پیشنهاد قابلیت‌های جدید، لطفاً Issue ثبت کنید یا Pull Request ارسال نمایید.

---

## 📄 License

This project is licensed under the MIT License.

# 💰 Finance Tracker

> Ứng dụng quản lý tài chính cá nhân đa nền tảng, hỗ trợ iOS, Android, Web và Desktop, giúp người dùng theo dõi thu nhập, chi tiêu và quản lý ví dễ dàng, trực quan.

---

## 🚀 Tính năng chính

- ✅ Đăng nhập/Đăng ký tài khoản
- ✅ Ghi lại thu nhập và chi tiêu
- ✅ Phân loại giao dịch theo danh mục
- ✅ Thống kê theo tháng, năm
- ✅ Hỗ trợ đa nền tảng: iOS, Android, Web, Desktop
- ✅ Giao diện hiện đại, dễ dùng (inspired by banking apps)
- ✅ Hệ thống routing sử dụng `GoRouter`
- ✅ Quản lý state với `Provider`
- ✅ Hỗ trợ dark mode và đổi font

---

## 🧱 Kiến trúc thư mục

lib/
├── main.dart
├── layout/ # Giao diện khung chung (MainLayout, AppBar,...)
├── screens/ # Các màn hình (Login, Home, History, ...)
├── components/ # Các widget tái sử dụng (CustomInput, CustomButton,...)
├── models/ # Các model dữ liệu
├── services/ # Gọi API, Firebase, xử lý dữ liệu
├── providers/ # Quản lý state (Provider)
├── routes/ # Định nghĩa định tuyến (GoRouter)
├── utils/ # Các hàm tiện ích (format ngày, số, ...)
└── assets/
├── illustrations/ # Hình minh họa SVG
└── fonts/ # Fonts tùy chỉnh


---

## 🛠️ Công nghệ sử dụng

| Công nghệ     | Mô tả                                |
|---------------|----------------------------------------|
| Flutter       | Framework UI đa nền tảng của Google     |
| Dart          | Ngôn ngữ lập trình chính               |
| GoRouter      | Điều hướng màn hình hiện đại, declarative |
| Provider      | Quản lý trạng thái                     |
| Firebase (optional) | Xác thực và lưu dữ liệu realtime     |
| Google Fonts  | Font chữ hiện đại, dễ dùng             |
| flutter_svg   | Hiển thị SVG vector chuyên nghiệp       |

---

## ⚙️ Cài đặt & chạy

### 1. Clone project
```bash
git clone https://github.com/yourusername/finance_tracker.git
cd finance_tracker

flutter pub get

flutter run -d chrome      # Web
flutter run -d android     # Android
flutter run -d ios         # iOS (chạy trên Mac)
flutter run -d windows  
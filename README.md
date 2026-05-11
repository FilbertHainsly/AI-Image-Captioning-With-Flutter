# AI Vision — Image Captioning dengan Flutter

Aplikasi Flutter yang menggunakan **Google Gemini AI** untuk menghasilkan deskripsi otomatis dari gambar. Pengguna dapat mengambil foto dari kamera atau memilih dari galeri, lalu AI akan menganalisis dan memberikan caption dalam **Bahasa Indonesia** (4 kalimat).

## 🏗️ Struktur Project

```
lib/
├── main.dart                  # Entry point aplikasi
├── screens/
│   └── home_screen.dart       # Halaman utama (image picker + caption display)
├── services/
│   └── ai_service.dart        # Integrasi Google Gemini API
├── theme/
│   └── app_theme.dart         # Konfigurasi tema (warna, gradient, typography)
└── widgets/
    ├── caption_card.dart      # Widget kartu caption dengan shimmer loading
    ├── image_preview.dart     # Widget preview gambar dengan glassmorphism
    └── source_picker.dart     # Bottom sheet pemilih sumber gambar
```

---

## 🔧 Tech Stack

- **Framework**: Flutter (Dart)
- **AI Model**: Google Gemini 2.5 Flash (via REST API)
- **HTTP Client**: `http` package
- **Image Picker**: `image_picker` package
- **Typography**: Google Fonts (Poppins)
- **Loading Effect**: `shimmer` package

---

## Cara Menjalankan

### 1. Clone Repository

```bash
git clone https://github.com/username/flutter_ai.git
cd flutter_ai
```

### 2. Dapatkan API Key

1. Buka [Google AI Studio](https://aistudio.google.com/apikey)
2. Klik **"Create API Key"**
3. Copy API key yang dihasilkan

### 3. Konfigurasi API Key

Buka file `lib/services/ai_service.dart` dan ganti API key:

```dart
static const _apiKey = "MASUKKAN_API_KEY_KAMU_DISINI";
```

### 4. Install Dependencies & Jalankan

```bash
flutter pub get
flutter run
```

## Dependencies

```yaml
dependencies:
  flutter: sdk
  image_picker: ^1.1.2    # Pemilih gambar (kamera/galeri)
  http: ^1.2.1             # HTTP client untuk API request
  google_fonts: ^6.2.1     # Font Poppins
  shimmer: ^3.0.0          # Efek shimmer loading
```
## Demo Aplikasi
### Dashboard
<img width="738" height="1600" alt="WhatsApp Image 2026-05-11 at 17 42 06" src="https://github.com/user-attachments/assets/29aaf92f-5076-4ec0-a4a4-79f7d23202d0" />

### Contoh 1
<img width="738" height="1600" alt="image" src="https://github.com/user-attachments/assets/6de07852-e4a3-4f60-b63b-103052e0324c" />

<img width="738" height="1600" alt="image" src="https://github.com/user-attachments/assets/19d48f3a-f399-4711-a9c9-9f6bf534a3f6" />

### Contoh 2
<img width="738" height="1600" alt="image" src="https://github.com/user-attachments/assets/c21e5c76-4538-4145-9369-1aed1d2306aa" />

<img width="738" height="1600" alt="image" src="https://github.com/user-attachments/assets/aaee8631-269c-4b3b-ba96-cda62b9fd31b" />








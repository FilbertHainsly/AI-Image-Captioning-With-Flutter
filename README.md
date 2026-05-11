# 🤖 AI Vision — Image Captioning dengan Flutter

Aplikasi Flutter yang menggunakan **Google Gemini AI** untuk menghasilkan deskripsi otomatis dari gambar. Pengguna dapat mengambil foto dari kamera atau memilih dari galeri, lalu AI akan menganalisis dan memberikan caption dalam **Bahasa Indonesia** (4 kalimat).

---

## ✨ Fitur Utama

| Fitur | Deskripsi |
|---|---|
| 📸 **Ambil Foto** | Ambil gambar langsung dari kamera perangkat |
| 🖼️ **Pilih dari Galeri** | Pilih gambar yang sudah ada di galeri |
| 🤖 **AI Captioning** | Generate deskripsi gambar otomatis menggunakan Google Gemini API |
| 🇮🇩 **Bahasa Indonesia** | Hasil caption dalam Bahasa Indonesia (4 kalimat) |
| 📋 **Copy Caption** | Salin caption ke clipboard dengan satu ketukan |
| 🔄 **Retry on Error** | Tombol retry jika terjadi error |
| 🎨 **Dark Glassmorphism UI** | Desain modern dengan efek glass, gradient, dan shimmer loading |

---

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

## ⚙️ Cara Menjalankan

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

---

## 📱 Alur Penggunaan

```
┌─────────────────────────┐
│     Buka Aplikasi       │
│   (Tampilan kosong)     │
└──────────┬──────────────┘
           │
           ▼
┌─────────────────────────┐
│  Tekan "Upload Image"   │
│  (Floating Action Btn)  │
└──────────┬──────────────┘
           │
           ▼
┌─────────────────────────┐
│  Pilih Sumber Gambar:   │
│  📸 Kamera / 🖼️ Galeri  │
└──────────┬──────────────┘
           │
           ▼
┌─────────────────────────┐
│  Preview Gambar +       │
│  Shimmer Loading...     │
└──────────┬──────────────┘
           │
           ▼
┌─────────────────────────┐
│  ✅ Caption Ditampilkan  │
│  (4 kalimat, Bahasa ID) │
│  [Copy] [Retry]         │
└─────────────────────────┘
```

---

## 🧠 Cara Kerja AI Service

1. **Gambar dibaca** sebagai bytes dari file
2. **Encode ke Base64** untuk dikirim via HTTP
3. **Deteksi MIME type** berdasarkan ekstensi file (jpg, png, gif, webp, bmp)
4. **Kirim ke Gemini API** dengan prompt Bahasa Indonesia
5. **Parse response** JSON dan tampilkan hasilnya
6. **Error handling** untuk koneksi gagal, timeout, dan server error

```dart
// Contoh request ke Gemini API
{
  "contents": [{
    "parts": [
      { "text": "Deskripsikan gambar ini dalam Bahasa Indonesia..." },
      { "inline_data": { "mime_type": "image/jpeg", "data": "<base64>" } }
    ]
  }]
}
```

---

## 📦 Dependencies

```yaml
dependencies:
  flutter: sdk
  image_picker: ^1.1.2    # Pemilih gambar (kamera/galeri)
  http: ^1.2.1             # HTTP client untuk API request
  google_fonts: ^6.2.1     # Font Poppins
  shimmer: ^3.0.0          # Efek shimmer loading
```

---

## ⚠️ Catatan Penting

- **API Key**: Jangan push API key ke repository publik. Gunakan environment variable atau `--dart-define` untuk production.
- **Kuota API**: Free tier Gemini API memiliki batasan request per menit. Jika melebihi kuota, akan muncul error 429.
- **Ukuran Gambar**: Gambar otomatis dikompres ke max 1920px dengan kualitas 85% sebelum dikirim ke API.

---****

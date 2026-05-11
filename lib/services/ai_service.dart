import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// Result wrapper for AI caption generation.
class CaptionResult {
  final String? caption;
  final String? error;

  const CaptionResult({this.caption, this.error});

  bool get isSuccess => caption != null;
}

class AIService {
  static const _apiKey = "YOUR API KEY";

  static const _baseUrl =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent";

  /// Detect MIME type based on file extension.
  static String _getMimeType(String path) {
    final ext = path.split('.').last.toLowerCase();
    switch (ext) {
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'webp':
        return 'image/webp';
      case 'bmp':
        return 'image/bmp';
      case 'jpg':
      case 'jpeg':
      default:
        return 'image/jpeg';
    }
  }

  /// Generate a caption for the given image file using Gemini API.
  static Future<CaptionResult> generateCaption(File image) async {
    try {
      final bytes = await image.readAsBytes();
      final base64Image = base64Encode(bytes);
      final mimeType = _getMimeType(image.path);

      final response = await http
          .post(
            Uri.parse("$_baseUrl?key=$_apiKey"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({
              "contents": [
                {
                  "parts": [
                    {
                      "text":
                          "Deskripsikan gambar ini dalam Bahasa Indonesia. "
                              "Gunakan tepat 4 kalimat saja. "
                              "Jelaskan subjek utama, warna, suasana, dan elemen penting lainnya secara deskriptif dan menarik."
                    },
                    {
                      "inline_data": {
                        "mime_type": mimeType,
                        "data": base64Image,
                      }
                    }
                  ]
                }
              ]
            }),
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode != 200) {
        debugPrint("API Error ${response.statusCode}: ${response.body}");
        return CaptionResult(
          error: "Server error (${response.statusCode}): ${response.body}",
        );
      }

      final data = jsonDecode(response.body);

      // Safely navigate the JSON response
      final candidates = data["candidates"] as List?;
      if (candidates == null || candidates.isEmpty) {
        return const CaptionResult(error: "No response from AI. Try again.");
      }

      final text = candidates[0]["content"]?["parts"]?[0]?["text"] as String?;
      if (text == null || text.isEmpty) {
        return const CaptionResult(
            error: "Empty response from AI. Try another image.");
      }

      return CaptionResult(caption: text.trim());
    } on SocketException {
      return const CaptionResult(
        error: "No internet connection. Please check your network.",
      );
    } on HttpException {
      return const CaptionResult(
        error: "Failed to reach the server. Please try again.",
      );
    } catch (e) {
      return CaptionResult(error: "Something went wrong: ${e.toString()}");
    }
  }
}

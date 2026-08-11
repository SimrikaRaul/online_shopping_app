import 'dart:io';
import 'package:dio/dio.dart';

class CloudinaryService {
  final Dio dio = Dio();

  final String cloudName = 'wnuqbblo';
  final String uploadPreset = 'flutter_uploads';

  Future<String?> uploadImage(File image) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(image.path),
        'upload_preset': uploadPreset,
      });

      final response = await dio.post(
        'https://api.cloudinary.com/v1_1/$cloudName/image/upload',
        data: formData,
      );

      return response.data['secure_url'];
    } catch (e) {
      print('Upload error: $e');
      return null;
    }
  }
}

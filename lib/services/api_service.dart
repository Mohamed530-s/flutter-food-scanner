import 'package:dio/dio.dart';
import 'package:ai_food_scanner/core/constants.dart';
import 'package:ai_food_scanner/models/food_result.dart';

class ApiService {
  final Dio _dio = Dio();
  final String baseUrl;

  ApiService({String? baseUrl}) : baseUrl = baseUrl ?? AppConstants.apiBaseUrl;

  Future<FoodResult> analyzeFood(String imagePath) async {
    try {
      final FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(imagePath, filename: 'food_image.jpg'),
      });

      final response = await _dio.post(
        '$baseUrl/analyze',
        data: formData,
        options: Options(
          headers: {'Content-Type': 'multipart/form-data'},
          sendTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 30),
        ),
      );

      if (response.statusCode == 200) {
        return _parseFoodResult(response.data, imagePath);
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Connection failed: ${e.message}');
    }
  }

  FoodResult _parseFoodResult(Map<String, dynamic> data, String imagePath) {
    return FoodResult.fromJson({
      ...data,
      'imagePath': imagePath,
      'calories': data['nutrition']['calories'],
      'protein': data['nutrition']['protein'],
      'carbs': data['nutrition']['carbs'],
      'fat': data['nutrition']['fat'],
      'fiber': data['nutrition']['fiber'],
    });
  }
}
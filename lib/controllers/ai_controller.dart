import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ai_food_scanner/core/constants.dart';
import 'package:ai_food_scanner/models/food_result.dart';
import 'package:ai_food_scanner/services/api_service.dart';
import 'package:ai_food_scanner/services/mock_service.dart';
import 'package:ai_food_scanner/services/tflite_service.dart';

class AiController extends StateNotifier<AsyncValue<FoodResult?>> {
  final MockService _mockService;
  final ApiService _apiService;
  final TfliteService _tfliteService;

  AiController({
    required MockService mockService,
    required ApiService apiService,
    required TfliteService tfliteService,
  })  : _mockService = mockService,
        _apiService = apiService,
        _tfliteService = tfliteService,
        super(const AsyncValue.data(null));

  Future<FoodResult?> analyzeFood(String imagePath) async {
    state = const AsyncValue.loading();

    try {
      FoodResult? result;

      if (AppConstants.useMockService) {
        // Use mock service for testing
        result = await _mockService.analyzeFood(imagePath);
      } else {
        // Try TFLite first for offline inference
        try {
          result = await _tfliteService.analyzeFood(imagePath);
        } catch (e) {
          // Fallback to API if TFLite fails
          result = await _apiService.analyzeFood(imagePath);
        }
      }

      state = AsyncValue.data(result);
      return result;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      return null;
    }
  }

  void reset() {
    state = const AsyncValue.data(null);
  }
}

final aiControllerProvider =
    StateNotifierProvider<AiController, AsyncValue<FoodResult?>>((ref) {
  return AiController(
    mockService: MockService(),
    apiService: ApiService(),
    tfliteService: TfliteService(),
  );
});

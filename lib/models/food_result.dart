import 'package:ai_food_scanner/widgets/segmented_image.dart';

class FoodResult {
  final String foodName;
  final double calories;
  final double protein;
  final double carbs;
  final double fat;
  final double fiber;
  final double confidence;
  final String imagePath;
  final List<SegmentationMask>? segmentationMasks;
  final List<String> recipeSteps;

  FoodResult({
    required this.foodName,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.fiber,
    required this.confidence,
    required this.imagePath,
    this.segmentationMasks,
    this.recipeSteps = const [],
  });

  factory FoodResult.fromJson(Map<String, dynamic> json) {
    return FoodResult(
      foodName: json['foodName'] as String,
      calories: (json['calories'] as num).toDouble(),
      protein: (json['protein'] as num).toDouble(),
      carbs: (json['carbs'] as num).toDouble(),
      fat: (json['fat'] as num).toDouble(),
      fiber: (json['fiber'] as num).toDouble(),
      confidence: (json['confidence'] as num).toDouble(),
      imagePath: json['imagePath'] as String,
      recipeSteps: (json['recipeSteps'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'foodName': foodName,
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
      'fiber': fiber,
      'confidence': confidence,
      'imagePath': imagePath,
      'recipeSteps': recipeSteps,
    };
  }

  FoodResult copyWith({
    String? foodName,
    double? calories,
    double? protein,
    double? carbs,
    double? fat,
    double? fiber,
    double? confidence,
    String? imagePath,
    List<SegmentationMask>? segmentationMasks,
    List<String>? recipeSteps,
  }) {
    return FoodResult(
      foodName: foodName ?? this.foodName,
      calories: calories ?? this.calories,
      protein: protein ?? this.protein,
      carbs: carbs ?? this.carbs,
      fat: fat ?? this.fat,
      fiber: fiber ?? this.fiber,
      confidence: confidence ?? this.confidence,
      imagePath: imagePath ?? this.imagePath,
      segmentationMasks: segmentationMasks ?? this.segmentationMasks,
      recipeSteps: recipeSteps ?? this.recipeSteps,
    );
  }
}

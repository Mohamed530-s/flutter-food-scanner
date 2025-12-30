import 'dart:math';
import 'dart:ui';

import 'package:ai_food_scanner/models/food_result.dart';
import 'package:ai_food_scanner/widgets/segmented_image.dart';

class MockService {
  final _random = Random();

  // Mock food database
  final List<Map<String, dynamic>> _mockFoods = [
    {
      'name': 'Pizza Margherita',
      'calories': 450.0,
      'protein': 18.0,
      'carbs': 52.0,
      'fat': 16.0,
      'fiber': 3.5,
    },
    {
      'name': 'Caesar Salad',
      'calories': 280.0,
      'protein': 12.0,
      'carbs': 15.0,
      'fat': 20.0,
      'fiber': 4.0,
    },
    {
      'name': 'Grilled Chicken Breast',
      'calories': 165.0,
      'protein': 31.0,
      'carbs': 0.0,
      'fat': 3.6,
      'fiber': 0.0,
    },
    {
      'name': 'Spaghetti Carbonara',
      'calories': 520.0,
      'protein': 22.0,
      'carbs': 60.0,
      'fat': 22.0,
      'fiber': 2.5,
    },
    {
      'name': 'Chocolate Cake',
      'calories': 520.0,
      'protein': 6.0,
      'carbs': 68.0,
      'fat': 26.0,
      'fiber': 2.0,
    },
    {
      'name': 'Avocado Toast',
      'calories': 320.0,
      'protein': 10.0,
      'carbs': 35.0,
      'fat': 18.0,
      'fiber': 8.0,
    },
  ];

  Future<FoodResult> analyzeFood(String imagePath) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 1500));

    // Pick a random food
    final foodData = _mockFoods[_random.nextInt(_mockFoods.length)];

    // Generate mock segmentation masks
    final masks = _generateMockMasks();

    // Generate mock recipe steps
    final recipeSteps = _generateMockRecipeSteps(foodData['name']);

    return FoodResult(
      foodName: foodData['name'],
      calories: foodData['calories'],
      protein: foodData['protein'],
      carbs: foodData['carbs'],
      fat: foodData['fat'],
      fiber: foodData['fiber'],
      confidence: 0.85 + (_random.nextDouble() * 0.14), // 85-99%
      imagePath: imagePath,
      segmentationMasks: masks,
      recipeSteps: recipeSteps,
    );
  }

  List<SegmentationMask> _generateMockMasks() {
    // Create 2-3 random segmentation masks
    final numMasks = 2 + _random.nextInt(2);
    final masks = <SegmentationMask>[];

    for (var i = 0; i < numMasks; i++) {
      final points = <Offset>[];
      final centerX = 0.3 + (_random.nextDouble() * 0.4);
      final centerY = 0.3 + (_random.nextDouble() * 0.4);
      final radius = 0.1 + (_random.nextDouble() * 0.15);

      // Generate circular polygon
      for (var angle = 0; angle < 360; angle += 30) {
        final radians = angle * (pi / 180);
        final x = centerX + (radius * cos(radians));
        final y = centerY + (radius * sin(radians));
        points.add(Offset(x.clamp(0.0, 1.0), y.clamp(0.0, 1.0)));
      }

      masks.add(SegmentationMask(
        points: points,
        color: _generateRandomColor(),
        label: 'Item ${i + 1}',
      ));
    }

    return masks;
  }

  Color _generateRandomColor() {
    final colors = [
      const Color(0xFF6C63FF),
      const Color(0xFF00C9A7),
      const Color(0xFFFFBF00),
      const Color(0xFFFF6B6B),
      const Color(0xFF4ECDC4),
    ];
    return colors[_random.nextInt(colors.length)];
  }

  List<String> _generateMockRecipeSteps(String foodName) {
    final recipes = {
      'Pizza Margherita': [
        'Preheat oven to 475°F (245°C).',
        'Roll out pizza dough into a circle.',
        'Spread tomato sauce evenly over the dough.',
        'Add fresh mozzarella slices.',
        'Drizzle with olive oil and add fresh basil.',
        'Bake for 10-12 minutes until crust is golden.',
      ],
      'Caesar Salad': [
        'Wash and chop romaine lettuce.',
        'Prepare Caesar dressing with anchovies, garlic, and lemon.',
        'Toss lettuce with dressing.',
        'Add croutons and Parmesan cheese.',
        'Serve immediately.',
      ],
      'Grilled Chicken Breast': [
        'Season chicken breast with salt, pepper, and herbs.',
        'Preheat grill to medium-high heat.',
        'Grill chicken for 6-7 minutes per side.',
        'Check internal temperature reaches 165°F (74°C).',
        'Let rest for 5 minutes before serving.',
      ],
    };

    return recipes[foodName] ??
        [
          'Prepare all ingredients.',
          'Follow standard cooking procedures.',
          'Cook until done.',
          'Season to taste.',
          'Serve and enjoy!',
        ];
  }
}

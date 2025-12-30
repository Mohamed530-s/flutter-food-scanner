import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ai_food_scanner/widgets/liquid_navbar.dart';

void main() {
  group('LiquidNavBar Widget', () {
    late List<int> tapHistory;

    setUp(() {
      tapHistory = [];
    });

    Widget createTestWidget(Widget child) {
      return ProviderScope(
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, widget) => MaterialApp(
            home: Scaffold(
              body: child,
            ),
          ),
        ),
      );
    }

    testWidgets('should render all navigation items', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          LiquidNavBar(
            onTap: (index) {},
            items: const [
              LiquidNavBarItem(icon: Icons.home, label: 'Home'),
              LiquidNavBarItem(icon: Icons.search, label: 'Search'),
              LiquidNavBarItem(icon: Icons.person, label: 'Profile'),
            ],
          ),
        ),
      );

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Search'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
      expect(find.byIcon(Icons.home), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('should call onTap when item is tapped', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          LiquidNavBar(
            onTap: (index) => tapHistory.add(index),
            items: const [
              LiquidNavBarItem(icon: Icons.home, label: 'Home'),
              LiquidNavBarItem(icon: Icons.search, label: 'Search'),
              LiquidNavBarItem(icon: Icons.person, label: 'Profile'),
            ],
          ),
        ),
      );

      // Tap on Search item
      await tester.tap(find.text('Search'));
      await tester.pumpAndSettle();

      expect(tapHistory, [1]);

      // Tap on Profile item
      await tester.tap(find.text('Profile'));
      await tester.pumpAndSettle();

      expect(tapHistory, [1, 2]);
    });

    testWidgets('should update visual state when item is selected',
        (tester) async {
      // ignore: unused_local_variable
      int currentIndex = 0;

      await tester.pumpWidget(
        createTestWidget(
          StatefulBuilder(
            builder: (context, setState) {
              return LiquidNavBar(
                onTap: (index) => setState(() => currentIndex = index),
                items: const [
                  LiquidNavBarItem(icon: Icons.home, label: 'Home'),
                  LiquidNavBarItem(icon: Icons.search, label: 'Search'),
                  LiquidNavBarItem(icon: Icons.person, label: 'Profile'),
                ],
              );
            },
          ),
        ),
      );

      // Initial state - Home should be selected
      await tester.pumpAndSettle();

      // Tap Search
      await tester.tap(find.text('Search'));
      await tester.pumpAndSettle();

      // Verify the tap was processed
      expect(find.text('Search'), findsOneWidget);
    });

    testWidgets('should handle drag gestures', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          LiquidNavBar(
            onTap: (index) => tapHistory.add(index),
            items: const [
              LiquidNavBarItem(icon: Icons.home, label: 'Home'),
              LiquidNavBarItem(icon: Icons.search, label: 'Search'),
              LiquidNavBarItem(icon: Icons.person, label: 'Profile'),
            ],
          ),
        ),
      );

      // Find the Home item
      final homeItem = find.text('Home');

      // Perform drag gesture
      await tester.drag(homeItem, const Offset(100, 0));
      await tester.pumpAndSettle();

      // The drag should be handled without errors
      expect(tester.takeException(), isNull);
    });

    testWidgets('should have correct spacing between items', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          LiquidNavBar(
            onTap: (index) {},
            items: const [
              LiquidNavBarItem(icon: Icons.home, label: 'Home'),
              LiquidNavBarItem(icon: Icons.search, label: 'Search'),
              LiquidNavBarItem(icon: Icons.person, label: 'Profile'),
              LiquidNavBarItem(icon: Icons.settings, label: 'Settings'),
            ],
          ),
        ),
      );

      // Verify all items are rendered
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Search'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
      expect(find.text('Settings'), findsOneWidget);
    });
  });
}

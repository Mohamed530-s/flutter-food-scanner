import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_food_scanner/controllers/liquid_navbar_controller.dart';

void main() {
  group('LiquidNavbarController', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('initial state should be index 0', () {
      final state = container.read(liquidNavbarControllerProvider);
      expect(state.currentIndex, 0);
      expect(state.isDragging, false);
      expect(state.dragOffset, 0.0);
    });

    test('setIndex should update current index', () {
      final controller =
          container.read(liquidNavbarControllerProvider.notifier);

      controller.setIndex(2);

      final state = container.read(liquidNavbarControllerProvider);
      expect(state.currentIndex, 2);
      expect(state.dragStartIndex, 2);
      expect(state.dragOffset, 0.0);
    });

    test('startDrag should set isDragging to true', () {
      final controller =
          container.read(liquidNavbarControllerProvider.notifier);

      controller.startDrag(1);

      final state = container.read(liquidNavbarControllerProvider);
      expect(state.isDragging, true);
      expect(state.dragStartIndex, 1);
      expect(state.dragOffset, 0.0);
    });

    test('updateDrag should update drag offset', () {
      final controller =
          container.read(liquidNavbarControllerProvider.notifier);

      controller.startDrag(0);
      controller.updateDrag(50.0);

      final state = container.read(liquidNavbarControllerProvider);
      expect(state.dragOffset, 50.0);
      expect(state.isDragging, true);
    });

    test('endDrag should reset dragging state', () {
      final controller =
          container.read(liquidNavbarControllerProvider.notifier);

      controller.startDrag(0);
      controller.updateDrag(50.0);
      controller.endDrag();

      final state = container.read(liquidNavbarControllerProvider);
      expect(state.isDragging, false);
      expect(state.dragOffset, 0.0);
    });

    test('multiple index changes should work correctly', () {
      final controller =
          container.read(liquidNavbarControllerProvider.notifier);

      controller.setIndex(1);
      expect(container.read(liquidNavbarControllerProvider).currentIndex, 1);

      controller.setIndex(3);
      expect(container.read(liquidNavbarControllerProvider).currentIndex, 3);

      controller.setIndex(0);
      expect(container.read(liquidNavbarControllerProvider).currentIndex, 0);
    });

    test('drag sequence should maintain state correctly', () {
      final controller =
          container.read(liquidNavbarControllerProvider.notifier);

      // Start drag
      controller.startDrag(1);
      var state = container.read(liquidNavbarControllerProvider);
      expect(state.isDragging, true);
      expect(state.dragStartIndex, 1);

      // Update drag multiple times
      controller.updateDrag(25.0);
      state = container.read(liquidNavbarControllerProvider);
      expect(state.dragOffset, 25.0);

      controller.updateDrag(50.0);
      state = container.read(liquidNavbarControllerProvider);
      expect(state.dragOffset, 50.0);

      // End drag
      controller.endDrag();
      state = container.read(liquidNavbarControllerProvider);
      expect(state.isDragging, false);
      expect(state.dragOffset, 0.0);
      expect(state.currentIndex, 1); // Index should remain unchanged
    });
  });
}

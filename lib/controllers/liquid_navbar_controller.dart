import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidNavbarState {
  final int currentIndex;
  final bool isDragging;
  final double dragOffset;
  final int dragStartIndex;

  LiquidNavbarState({
    required this.currentIndex,
    required this.isDragging,
    required this.dragOffset,
    required this.dragStartIndex,
  });

  LiquidNavbarState copyWith({
    int? currentIndex,
    bool? isDragging,
    double? dragOffset,
    int? dragStartIndex,
  }) {
    return LiquidNavbarState(
      currentIndex: currentIndex ?? this.currentIndex,
      isDragging: isDragging ?? this.isDragging,
      dragOffset: dragOffset ?? this.dragOffset,
      dragStartIndex: dragStartIndex ?? this.dragStartIndex,
    );
  }
}

class LiquidNavbarController extends StateNotifier<LiquidNavbarState> {
  LiquidNavbarController()
      : super(LiquidNavbarState(
          currentIndex: 0,
          isDragging: false,
          dragOffset: 0.0,
          dragStartIndex: 0,
        ));

  void setIndex(int index) {
    state = state.copyWith(
      currentIndex: index,
      dragStartIndex: index,
      dragOffset: 0.0,
    );
  }

  void startDrag(int index) {
    state = state.copyWith(
      isDragging: true,
      dragStartIndex: index,
      dragOffset: 0.0,
    );
  }

  void updateDrag(double offset) {
    state = state.copyWith(
      dragOffset: offset,
    );
  }

  void endDrag() {
    state = state.copyWith(
      isDragging: false,
      dragOffset: 0.0,
    );
  }
}

final liquidNavbarControllerProvider =
    StateNotifierProvider<LiquidNavbarController, LiquidNavbarState>((ref) {
  return LiquidNavbarController();
});

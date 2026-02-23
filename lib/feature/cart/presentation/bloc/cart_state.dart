part of 'cart_bloc.dart';

enum CartStatus { initial, loading, success, empty, failure }
enum CartFeedbackStatus { none, success, error }

class CartState {
  final CartStatus status;
  final List<CartEntity> carts;
  final Failure failure;
  final bool isMutating;
  final int? activeItemId;
  final CartFeedbackStatus feedbackStatus;
  final String feedbackMessage;

  const CartState({
    required this.status,
    required this.carts,
    required this.failure,
    required this.isMutating,
    required this.activeItemId,
    required this.feedbackStatus,
    required this.feedbackMessage,
  });

  factory CartState.initial() {
    return CartState(
      status: CartStatus.initial,
      carts: const [],
      failure: Failure(""),
      isMutating: false,
      activeItemId: null,
      feedbackStatus: CartFeedbackStatus.none,
      feedbackMessage: "",
    );
  }

  CartState copyWith({
    CartStatus? status,
    List<CartEntity>? carts,
    Failure? failure,
    bool? isMutating,
    int? activeItemId,
    bool clearActiveItemId = false,
    CartFeedbackStatus? feedbackStatus,
    String? feedbackMessage,
    bool clearFeedback = false,
  }) {
    return CartState(
      status: status ?? this.status,
      carts: carts ?? this.carts,
      failure: failure ?? this.failure,
      isMutating: isMutating ?? this.isMutating,
      activeItemId: clearActiveItemId
          ? null
          : (activeItemId ?? this.activeItemId),
      feedbackStatus: clearFeedback
          ? CartFeedbackStatus.none
          : (feedbackStatus ?? this.feedbackStatus),
      feedbackMessage: clearFeedback ? "" : (feedbackMessage ?? this.feedbackMessage),
    );
  }
}

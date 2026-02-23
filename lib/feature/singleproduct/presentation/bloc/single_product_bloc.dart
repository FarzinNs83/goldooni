import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goldooni/core/errors/failure.dart';
import 'package:goldooni/feature/singleproduct/domain/entities/single_product_entity.dart';
import 'package:goldooni/feature/singleproduct/domain/repositories/single_product_repository.dart';
part 'single_product_state.dart';

class SingleProductBloc extends Cubit<SingleProductState> {
  final SingleproductRepository _singleProductRepository;
  SingleProductBloc(this._singleProductRepository)
    : super(const SingleProductInitial());

  final Set<int> _favoriteIds = {};

  Future<void> getSingleProduct(int id) async {
    emit(SingleProductLoading(favoriteIds: Set<int>.from(_favoriteIds)));
    final result = await _singleProductRepository.getSingleProduct(id);
    result.fold(
      (l) => emit(
        SingleProductError(
          failure: l,
          favoriteIds: Set<int>.from(_favoriteIds),
        ),
      ),
      (r) {
        if (r.isEmpty) {
          emit(
            SingleProductError(
              failure: Failure('Product not found'),
              favoriteIds: Set<int>.from(_favoriteIds),
            ),
          );
          return;
        }
        emit(
          SingleProductLoaded(
            product: r.first,
            favoriteIds: Set<int>.from(_favoriteIds),
          ),
        );
      },
    );
  }

  void toggleFavorite(SingleProductEntity item) {
    if (_favoriteIds.contains(item.id)) {
      _favoriteIds.remove(item.id);
    } else {
      _favoriteIds.add(item.id);
    }

    final currentState = state;
    if (currentState is SingleProductLoaded) {
      emit(
        currentState.copyWith(
          favoriteIds: Set<int>.from(_favoriteIds),
        ),
      );
      return;
    }

    emit(SingleProductInitial(favoriteIds: Set<int>.from(_favoriteIds)));
  }
}

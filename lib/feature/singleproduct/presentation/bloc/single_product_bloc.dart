import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goldooni/core/errors/failure.dart';
import 'package:goldooni/feature/singleproduct/domain/entities/single_product_entity.dart';
import 'package:goldooni/feature/singleproduct/domain/repositories/single_product_repository.dart';
part 'single_product_state.dart';

class SingleProductBloc extends Cubit<SingleProductState> {
  final SingleproductRepository _singleProductRepository;
  SingleProductBloc(this._singleProductRepository)
    : super(SingleProductInitial());
  final List<SingleProductEntity> singleProduct = [];
  Future<void> getSingleProduct(int id) async {
    singleProduct.clear();
    emit(SingleProductLoading());
    final result = await _singleProductRepository.getSingleProduct(id);
    result.fold((l) => emit(SingleProductError(failure: l)), (r) {
      emit(SingleProductLoaded());
      singleProduct.addAll(r);
    });
  }
}

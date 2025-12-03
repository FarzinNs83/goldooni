import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goldooni/core/errors/failure.dart';
import 'package:goldooni/feature/home/domain/entities/amazing_products_entity.dart';
import 'package:goldooni/feature/home/domain/entities/new_products_entity.dart';
import 'package:goldooni/feature/home/domain/entities/top_products_entity.dart';
import 'package:goldooni/feature/home/domain/repositories/home_repository.dart';

import '../../domain/entities/cats_entity.dart';
part 'home_state.dart';

class HomeBloc extends Cubit<HomeState> {
  final HomeRepository homeRepository;
  HomeBloc(this.homeRepository) : super(HomeInitial());
  final List<CatsEntity> cats = [];
  final List<AmazingProductsEntity> amazProducts = [];
  final List<NewProductsEntity> newProducts = [];
  final List<TopProductsEntity> topProducts = [];
  Future<void> getCats(int page) async {
    emit(HomeCatsLoading());
    final res = await homeRepository.getCats(page);
    res.fold((l) => emit(HomeFailed(failure: l)), (r) {
      cats.addAll(r);
      emit(HomeSuccess());
    });
  }
  Future<void> getAmazProducts(int page) async {
    emit(HomeAmazLoading());
    final res = await homeRepository.getAmazingProducts(page);
    res.fold((l) => emit(HomeFailed(failure: l)), (r) {
      amazProducts.addAll(r);
      emit(HomeSuccess());
    });
  }
  Future<void> getNewProducts(int page) async {
    emit(HomeNewLoading());
    final res = await homeRepository.getNewProducts(page);
    res.fold((l) => emit(HomeFailed(failure: l)), (r) {
      newProducts.addAll(r);
      emit(HomeSuccess());
    });
  }
  Future<void> getTopProducts(int page) async {
    emit(HomeTopLoading());
    final res = await homeRepository.getTopProducts(page);
    res.fold((l) => emit(HomeFailed(failure: l)), (r) {
      topProducts.addAll(r);
      emit(HomeSuccess());
    });
  }
}

import 'dart:developer';

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
  final List<AmazingProductsEntity> amazMoreProducts = [];
  final List<NewProductsEntity> newProducts = [];
  final List<NewProductsEntity> newMoreProducts = [];
  final List<TopProductsEntity> topProducts = [];
  final List<TopProductsEntity> topMoreProducts = [];
  int amazingPage = 1;
  int newPage = 1;
  int topPage = 1;
  bool isLoadingMore = false;
  bool isNew = false;
  bool isTop = true;
  Future<void> getCats() async {
    emit(HomeCatsLoading());
    final res = await homeRepository.getCats(1);
    res.fold((l) => emit(HomeFailed(failure: l)), (r) {
      cats.addAll(r);
      emit(HomeSuccess());
    });
  }

  Future<void> getAmazProducts() async {
    log("This was called");
    emit(HomeAmazLoading());
    final res = await homeRepository.getAmazingProducts(1);
    res.fold((l) => emit(HomeFailed(failure: l)), (r) {
      amazProducts.addAll(r);
      amazMoreProducts.addAll(r);
      emit(HomeSuccess());
    });
  }

  Future<void> getMoreAmazProducts() async {    
    if (isLoadingMore) return;
    isLoadingMore = true;
    emit(HomeMoreAmazingLoading());
    amazingPage++;
    log("Your page is : $amazingPage");
    final res = await homeRepository.getAmazingProducts(amazingPage);
    res.fold(
      (l) {
        emit(HomeMoreAmazingFailed(failure: l));
        isLoadingMore = false;
      },
      (r) {
        amazMoreProducts.addAll(r);
        emit(HomeMoreAmazingSuccess());
        isLoadingMore = false;
      },
    );
  }

  Future<void> getNewProducts() async {
    emit(HomeNewLoading());
    final res = await homeRepository.getNewProducts(1);
    res.fold((l) => emit(HomeFailed(failure: l)), (r) {
      newProducts.addAll(r);
      newMoreProducts.addAll(r);
      emit(HomeSuccess());
    });
  }

  Future<void> getMoreNewProducts() async {
    isNew = true;
    isTop = false;
    if (isLoadingMore) return;
    isLoadingMore = true;
    emit(HomeNewLoading());
    newPage++;
    log("Your page is : $newPage");
    final res = await homeRepository.getNewProducts(newPage);
    res.fold(
      (l) {
        emit(HomeFailed(failure: l));
        isLoadingMore = false;
      },
      (r) {
        newMoreProducts.addAll(r);
        emit(HomeSuccess());
        isLoadingMore = false;
      },
    );
  }

  Future<void> getTopProducts() async {
    emit(HomeTopLoading());
    final res = await homeRepository.getTopProducts(1);
    res.fold((l) => emit(HomeFailed(failure: l)), (r) {
      topProducts.addAll(r);
      topMoreProducts.addAll(r);
      emit(HomeSuccess());
    });
  }

  Future<void> getMoreTopProducts() async {
    isNew = false;
    isTop = true;
    if (isLoadingMore) return;
    isLoadingMore = true;
    emit(HomeTopLoading());
    topPage++;
    log("Your page is : $topPage");
    final res = await homeRepository.getTopProducts(topPage);
    res.fold(
      (l) {
        emit(HomeFailed(failure: l));
        isLoadingMore = false;
      },
      (r) {
        topMoreProducts.addAll(r);
        emit(HomeSuccess());
        isLoadingMore = false;
      },
    );
  }
}

import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geolocator/geolocator.dart';
import 'package:goldooni/core/errors/failure.dart';
import 'package:goldooni/feature/home/domain/entities/amazing_products_entity.dart';
import 'package:goldooni/feature/home/domain/entities/new_products_entity.dart';
import 'package:goldooni/feature/home/domain/entities/search_entity.dart';
import 'package:goldooni/feature/home/domain/entities/slider_entity.dart';
import 'package:goldooni/feature/home/domain/entities/top_products_entity.dart';
import 'package:goldooni/feature/home/domain/repositories/home_repository.dart';
import '../../../../core/utils/app_ext.dart';
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
  final List<SliderEntity> slider = [];
  final List<SearchEntity> searchByNameList = [];
  late double lat;
  late double lon;

  int time = 3700;
  int amazingPage = 1;
  int newPage = 1;
  int topPage = 1;
  bool isLoadingMore = false;
  bool isNew = false;
  bool isTop = true;
  Future<void> searchByName(String name) async {
    log("Search was called with name: $name");
    emit(HomeSearchLoading());
    final res = await homeRepository.searchByName(name);
    res.fold((l) => emit(HomeSearchFailed(failure: l)), (r) {
      searchByNameList.clear();
      searchByNameList.addAll(r);
      emit(HomeSearchSuccess(search: r));
    });
  }

  Future<void> getCats() async {
    emit(HomeCatsLoading());
    final res = await homeRepository.getCats();
    res.fold((l) => emit(HomeFailed(failure: l)), (r) {
      cats.addAll(r);
      emit(HomeSuccess());
    });
  }

  Future<void> getSlider() async {
    emit(HomeCatsLoading());
    final res = await homeRepository.getSlider();
    res.fold((l) => emit(HomeFailed(failure: l)), (r) {
      slider.addAll(r);
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

  void startTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      time--;
      final timers = formatTime(time);
      emit(
        HomeStartTimer(
          hours: timers.$1,
          minutes: timers.$2,
          seconds: timers.$3,
        ),
      );
      if (time == 0) {
        emit(
          HomeStartTimer(
            hours: '00'.toPersianNumber(),
            minutes: '00'.toPersianNumber(),
            seconds: '00'.toPersianNumber(),
          ),
        );
        timer.cancel();
      }
    });
  }

  (String h, String m, String s) formatTime(int time) {
    final h = (time ~/ 3600).toString().padLeft(2, '0').toPersianNumber();
    final m = ((time % 3600) ~/ 60)
        .toString()
        .padLeft(2, '0')
        .toPersianNumber();
    final s = (time % 60).toString().padLeft(2, '0').toPersianNumber();
    return (h, m, s);
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<void> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    final position = await Geolocator.getCurrentPosition();
    lat = position.latitude;
    lon = position.longitude;
  }
}

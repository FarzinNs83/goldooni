import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goldooni/core/errors/failure.dart';
import 'package:goldooni/feature/cats/domain/repositories/cats_repository.dart';

import '../../domain/entities/cats_entity.dart';
part 'cats_state.dart';

class CatsBloc extends Cubit<CatsState> {
  final CatsRepository catsRepository;
  CatsBloc(this.catsRepository) : super(CatsInitial());
  final List<CatsEntity> cats = [];
  int page = 1;
  Future<void> getCatsData(int id) async {
    emit(CatsLoading());
    final res = await catsRepository.getCatData(id, 1);
    res.fold((l) => emit(CatsFailed(failure: l)), (r) {
      cats.addAll(r);
      emit(CatsSuccess());
    });
  }
}

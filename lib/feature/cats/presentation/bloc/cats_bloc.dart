import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

part 'cats_event.dart';
part 'cats_state.dart';

class CatsBloc extends Bloc<CatsEvent, CatsState> {
  CatsBloc() : super(CatsInitial()) {
    on<CatsEvent>((event, emit) {
      // TODO: Add event handling
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:riadh_pfe/api/datasource.dart';
import 'package:riadh_pfe/presentations/home/home_event.dart';
import 'package:riadh_pfe/presentations/home/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UbidotsRepository _mRepository;

  HomeBloc(this._mRepository) : super(HomeLoadingState()) {
    on<LoadLastValueEvent>((event, emit) async {
      emit(HomeLoadingState());
      try {
        final mLastValue = await _mRepository.getLastValue();
        emit(HomeSuccessState(mLastValue));
      } catch (e) {
        emit(HomeErrorState(e.toString()));
      }
    });
  }
}

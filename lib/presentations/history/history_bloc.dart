import 'package:bloc/bloc.dart';
import 'package:riadh_pfe/api/datasource.dart';
import 'package:riadh_pfe/presentations/history/history_event.dart';
import 'package:riadh_pfe/presentations/history/history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final UbidotsRepository _mRepository;

  HistoryBloc(this._mRepository) : super(HistoryLoadingState()) {
    on<LoadHistoryEvent>((event, emit) async {
      emit(HistoryLoadingState());
      try {
        final history = await _mRepository.getHistory();
        emit(HistorySuccessState(history));
      } catch (e) {
        emit(HistoryErrorState(e.toString()));
      }
    });
  }
}
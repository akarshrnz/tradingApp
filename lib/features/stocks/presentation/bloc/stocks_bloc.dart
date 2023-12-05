import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trading_app/core/utils/data_state.dart';
import 'package:trading_app/core/utils/usecase.dart';
import 'package:trading_app/features/stocks/domain/entity/stock_entity.dart';
import 'package:trading_app/features/stocks/domain/usecases/stocks_usecase.dart';

part 'stocks_event.dart';
part 'stocks_state.dart';

class StocksBloc extends Bloc<StocksEvent, StocksState> {
  final GetStocksUsecase getStocksUsecase;
  StocksBloc(this.getStocksUsecase) : super(StocksInitial()) {
    on<GetStocksEvent>(_getStocks);
    on<UpdateStockEvent>(_updateStocks);
  }

  FutureOr<void> _getStocks(
      GetStocksEvent event, Emitter<StocksState> emit) async {
    emit(StocksLoading());
    var response = await getStocksUsecase(NoParams());
    if (response is DataSuccess && response.data != null) {
      emit(StartTimer());
      emit(StocksData(
          stocksList: response.data!, errorMessage: "", isUpdateEvent: false));
    } else {
      emit(StocksData(
          stocksList: const [],
          errorMessage: response.error!,
          isUpdateEvent: false));
    }
  }

  FutureOr<void> _updateStocks(
      UpdateStockEvent event, Emitter<StocksState> emit) {
    /// final currentState = state as StocksData;

    final random = Random();

    final currentDate =
        state.stocksList.last.date!.add(const Duration(days: 1));

    // Generate random values within specified ranges
    double open = random.nextDouble() * (130 - 70) + 70;
    double close = random.nextDouble() * (130 - 70) + 70;
    double high = max(open, close) + random.nextDouble() * 10;
    double low = min(open, close) - random.nextDouble() * 10;

    high = min(high, 130.0);
    low = max(low, 70.0);
    StockEntity newStock = StockEntity(
        date: currentDate, open: open, close: close, high: high, low: low);
    List<StockEntity> newStocks = List.from(state.stocksList);
    newStocks.add(newStock);

    emit(StocksData(
        errorMessage: "", isUpdateEvent: true, stocksList: newStocks));
  }
}

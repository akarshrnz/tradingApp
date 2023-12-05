part of 'stocks_bloc.dart';

sealed class StocksEvent extends Equatable {
  const StocksEvent();

  @override
  List<Object> get props => [];
}

 class GetStocksEvent extends StocksEvent {
  const GetStocksEvent();

  @override
  List<Object> get props => [];
}

class UpdateStockEvent extends StocksEvent {
  const UpdateStockEvent();

  @override
  List<Object> get props => [];
}

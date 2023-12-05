part of 'stocks_bloc.dart';

abstract class StocksState extends Equatable {
  final List<StockEntity> stocksList;
  

  const StocksState({required this.stocksList, });

  @override
  List<Object> get props => [stocksList, ];
}

final class StocksInitial extends StocksState {
  StocksInitial() : super(stocksList: [],);
  @override
  List<Object> get props => [stocksList, ];
}
final class StocksLoading extends StocksState {
  StocksLoading() : super(stocksList: [], );
  @override
  List<Object> get props => [stocksList, ];
}


final class StartTimer extends StocksState {
  StartTimer() : super(stocksList: [], );
  @override
  List<Object> get props => [stocksList, ];
}

final class StocksData extends StocksState {
  final bool isUpdateEvent;
  final String errorMessage;
  StocksData(
      {required this.errorMessage,
      required this.isUpdateEvent,
      required super.stocksList,
     });
  @override
  List<Object> get props =>
      [stocksList, errorMessage, isUpdateEvent];


  StocksData copyWith({
    bool? isUpadteevent,
    String? errorMessage,
    List<StockEntity>? stocksList,
    bool? isLoading,
  }) {
    return StocksData(
        errorMessage: errorMessage ?? this.errorMessage,
        isUpdateEvent: isUpadteevent ?? this.isUpdateEvent,
        stocksList: stocksList ?? this.stocksList,
        );
  }
}



import 'package:trading_app/core/utils/data_state.dart';
import 'package:trading_app/core/utils/usecase.dart';
import 'package:trading_app/features/stocks/domain/entity/stock_entity.dart';
import 'package:trading_app/features/stocks/domain/repository/stocks_repo.dart';

class GetStocksUsecase
    implements UseCase<DataState<List<StockEntity>>, Params> {
  final StocksRepository _stocksRepository;

  GetStocksUsecase(this._stocksRepository);
  @override
  Future<DataState<List<StockEntity>>> call(Params param) {
    return _stocksRepository.getStocks();
  }
}

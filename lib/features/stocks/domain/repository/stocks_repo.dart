



import 'package:trading_app/core/utils/data_state.dart';
import 'package:trading_app/features/stocks/domain/entity/stock_entity.dart';

abstract class StocksRepository{
  Future<DataState<List<StockEntity>>> getStocks();
  
}
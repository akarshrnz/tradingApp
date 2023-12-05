

import 'package:trading_app/core/utils/data_state.dart';
import 'package:trading_app/features/stocks/data/data%20source/remote/stocks_remote_services.dart';
import 'package:trading_app/features/stocks/data/model/stock_model.dart';
import 'package:trading_app/features/stocks/domain/repository/stocks_repo.dart';

class StocksRepositoryImpl implements StocksRepository {
  final StocksService _stockService;


  StocksRepositoryImpl(this._stockService, );

  @override
  Future<DataState<List<StockModel>>> getStocks() async {
    return _stockService.getStocks();}
}

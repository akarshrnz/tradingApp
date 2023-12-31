import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trading_app/core/utils/data_state.dart';
import 'package:trading_app/core/utils/endpoints.dart';

import 'package:trading_app/features/stocks/data/model/stock_model.dart';

abstract class StocksService {
  Future<DataState<List<StockModel>>> getStocks();
}

class StocksServiceImpl implements StocksService {
  final FirebaseFirestore _firestore;

  StocksServiceImpl(this._firestore);

  @override
  Future<DataState<List<StockModel>>> getStocks() async {
   
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection(Endpoints.stocksCollection).get();
          

      return DataSuccess(querySnapshot.docs
          .map((doc) => StockModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList());
    } catch (e) {
       
      throw DataFailed(e.toString());
    }
  }
}

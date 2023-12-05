

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trading_app/features/stocks/domain/entity/stock_entity.dart';

class StockModel extends StockEntity {
  StockModel({
    DateTime? date,
    num? open,
    num? close,
    num? low,
    num? high,
  }) : super(close: close, date: date, high: high, low: low, open: open);

  // Factory method to create an instance of ChartSampleModel from a JSON map
  factory StockModel.fromJson(Map<String, dynamic> json) {
    return StockModel(
      date: json['date'] != null ? (json['date'] as Timestamp).toDate() : null,
      open: json['open'] as num?,
      close: json['close'] as num?,
      low: json['low'] as num?,
      high: json['high'] as num?,
    );
  }

  // Method to convert an instance of ChartSampleModel to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'date': date?.toIso8601String(),
      'open': open,
      'close': close,
      'low': low,
      'high': high,
    };
  }
}

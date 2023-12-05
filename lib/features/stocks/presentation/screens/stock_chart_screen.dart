import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

import 'package:trading_app/features/stocks/domain/entity/stock_entity.dart';
import 'package:trading_app/features/stocks/presentation/bloc/stocks_bloc.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({Key? key}) : super(key: key);

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  DateTime currentDate = DateTime.now();
  Timer? _timer;
  late TrackballBehavior _trackballBehavior;
  late ChartSeriesController _chartSeriesController;

  @override
  void initState() {
    context.read<StocksBloc>().add(const GetStocksEvent());
    _trackballBehavior = TrackballBehavior(
        enable: true, activationMode: ActivationMode.singleTap);

    super.initState();
  }

  _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), _updateStock);
  }

  void _updateStock(Timer timer) {
    context.read<StocksBloc>().add(const UpdateStockEvent());
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: BlocConsumer<StocksBloc, StocksState>(
      listener: (context, state) {
        if (state is StartTimer) {
          _startTimer();
        }
         else if (state is StocksData && state.isUpdateEvent) {
          _chartSeriesController.updateDataSource(
            addedDataIndex: state.stocksList.length - 1,
          );
        }
      },
      builder: (context, state) {
        if (state is StocksLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is StocksData) {
          return candleChart(state);
        } else {
          return const SizedBox();
        }
      },
    )));
  }

  SfCartesianChart candleChart(StocksData state) {
    return SfCartesianChart(
      
      zoomPanBehavior: ZoomPanBehavior(
        enableDoubleTapZooming: true,
        enableMouseWheelZooming: true,
        enableSelectionZooming: true,
        enablePanning: true,
      ),
      legend: const Legend(
          isVisible: true, isResponsive: true, shouldAlwaysShowScrollbar: true),
      trackballBehavior: _trackballBehavior,
      series: <CandleSeries>[
        CandleSeries<StockEntity, DateTime>(
          animationDuration: 0,
            onRendererCreated: (ChartSeriesController controller) {
              _chartSeriesController = controller;
            },
            dataSource: state.stocksList,
            name: null,
            xValueMapper: (StockEntity sales, _) => sales.date,
            lowValueMapper: (StockEntity sales, _) => sales.low,
            highValueMapper: (StockEntity sales, _) => sales.high,
            openValueMapper: (StockEntity sales, _) => sales.open,
            closeValueMapper: (StockEntity sales, _) => sales.close)
      ],
      primaryXAxis: DateTimeAxis(
          dateFormat: DateFormat("MM/dd/yyyy"),
          majorGridLines: const MajorGridLines(width: 0),
          zoomFactor: 0.7,
          zoomPosition: 0.2,
          labelRotation: -45,
          enableAutoIntervalOnZooming: true),
      primaryYAxis: NumericAxis(
          opposedPosition: true,
          majorGridLines: const MajorGridLines(width: 0),
          minimum: 70,
          maximum: 130,
          interval: 5,
          numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0)),
    );
  }
}

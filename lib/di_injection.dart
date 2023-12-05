import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get_it/get_it.dart';
import 'package:trading_app/features/stocks/data/data%20source/remote/stocks_remote_services.dart';
import 'package:trading_app/features/stocks/data/repository/stocks_repo_impl.dart';
import 'package:trading_app/features/stocks/domain/repository/stocks_repo.dart';
import 'package:trading_app/features/stocks/domain/usecases/stocks_usecase.dart';
import 'package:trading_app/features/stocks/presentation/bloc/stocks_bloc.dart';

GetIt locator = GetIt.instance;
Future<void> initializeDependency() async {
  //firebase
  locator.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  locator.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);

  //stocks
  locator.registerLazySingleton<StocksService>(
      () => StocksServiceImpl(locator.call()));

  locator.registerLazySingleton<StocksRepository>(() => StocksRepositoryImpl(
        locator.call(),
      ));
  locator.registerLazySingleton<GetStocksUsecase>(
      () => GetStocksUsecase(locator.call()));
  locator.registerFactory(() => StocksBloc(
        locator.call(),
      ));
}

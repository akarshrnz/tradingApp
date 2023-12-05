import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:trading_app/core/config/route/app_route.dart';
import 'package:trading_app/core/utils/string_constants.dart';
import 'package:trading_app/di_injection.dart';
import 'package:trading_app/features/stocks/presentation/bloc/stocks_bloc.dart';
import 'package:trading_app/features/stocks/presentation/screens/stock_chart_screen.dart';

import 'firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDependency();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<StocksBloc>(
          create: (_) => locator<StocksBloc>(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRoute.router,
        title: StringConstants.appname,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }
}

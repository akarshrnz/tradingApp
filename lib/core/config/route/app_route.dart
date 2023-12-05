import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trading_app/core/config/route/route_path.dart';
import 'package:trading_app/features/splash/splash.dart';
import 'package:trading_app/features/stocks/presentation/screens/stock_chart_screen.dart';

class AppRoute {
 
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
              path: RoutePath.home,
              pageBuilder: (context, state) {
                return const MaterialPage(child: StockScreen());
              },
            ),
      GoRoute(
          path: '/',
          pageBuilder: (context, state) {
            return const MaterialPage(child: SplashScreen());
          },
         ),
    ],
  );
}

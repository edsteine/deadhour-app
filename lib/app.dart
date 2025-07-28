import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'routes/app_routes.dart';
import 'services/app_performance_service.dart';

class DeadHourApp extends StatelessWidget {
  const DeadHourApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: PerformanceMonitor(
        child: MaterialApp.router(
          title: 'DeadHour Morocco',
          routerConfig: AppRouter.router,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'utils/app_routes.dart';
// import 'services/app_performance_service.dart'; // Commented out - performance overlay disabled

class DeadHourApp extends StatelessWidget {
  const DeadHourApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      // TEMPORARILY COMMENTED OUT - Performance overlay hides important UI elements
      // Uncomment if needed for performance debugging
      // child: PerformanceMonitor(
      child: MaterialApp.router(
        title: 'DeadHour Morocco',
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
      ),
      // ),
    );
  }
}

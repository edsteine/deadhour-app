import 'package:flutter/material.dart';
import 'routes/app_routes.dart';

class DeadHourApp extends StatelessWidget {
  const DeadHourApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'DeadHour Morocco',
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}


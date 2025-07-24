import 'package:deadhour_flutter/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'utils/theme.dart';
import 'utils/guest_mode.dart';
import 'widgets/common/addon_toggle.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize guest mode state
  await GuestMode.initialize();
  
  runApp(const DeadHourApp());
}

class DeadHourApp extends StatelessWidget {
  const DeadHourApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddonToggleProvider(),
      child: MaterialApp.router(
        title: 'DeadHour Morocco',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/routes/app_routes.dart';
import 'app/theme/app_theme.dart';
import 'providers/auth_provider.dart';
import 'providers/crop_provider.dart';
import 'providers/fertilizer_provider.dart';
import 'providers/yield_provider.dart';
import 'providers/weather_provider.dart';
import 'providers/analysis_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AgroSmartApp());
}

class AgroSmartApp extends StatelessWidget {
  const AgroSmartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CropProvider()),
        ChangeNotifierProvider(create: (_) => FertilizerProvider()),
        ChangeNotifierProvider(create: (_) => YieldProvider()),
        ChangeNotifierProvider(create: (_) => WeatherProvider()),
        ChangeNotifierProvider(create: (_) => AnalysisProvider()),
      ],
      child: MaterialApp(
        title: 'AgroSmart',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        initialRoute: AppRoutes.splash,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}

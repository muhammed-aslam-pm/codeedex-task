import 'package:codeedex_machinetest/core/services/api_service.dart';
import 'package:codeedex_machinetest/core/services/storage_service.dart';
import 'package:codeedex_machinetest/viewmodels/auth_viemodel.dart';
import 'package:codeedex_machinetest/views/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (_) => ApiService(),
        ),
        Provider(
          create: (_) => StorageService(prefs),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthViewModel(
            context.read<ApiService>(),
            context.read<StorageService>(),
          ),
        ),
        // Add other providers here
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter MVVM Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}

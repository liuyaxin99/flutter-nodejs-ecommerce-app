import 'package:dealhub/common/widgets/bottom_bar.dart';
import 'package:dealhub/constants/global_variable.dart';
import 'package:dealhub/features/auth/screens/auth_screen.dart';
import 'package:dealhub/features/admin/screens/admin_screen.dart';
import 'package:dealhub/features/auth/screens/services/auth_service.dart';
import 'package:dealhub/providers/user_provider.dart';
import 'package:dealhub/router.dart';
import 'package:dealhub/slash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    )
  ], child: const MainApp()));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Deal Hub",
        theme: ThemeData(
          backgroundColor: GlobalVariables.backgroundColor,
          primarySwatch: Colors.blue,
          colorScheme: const ColorScheme.light(
            primary: GlobalVariables.secondaryColor,
          ),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
        ),
        onGenerateRoute: (settings) => generateRoute(settings),
        home: const SplashScreen(title: 'Deal Hub'));
  }
}

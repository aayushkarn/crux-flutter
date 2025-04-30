import 'package:crux/global_key.dart';
import 'package:crux/widgets/home_page.dart';
import 'package:crux/widgets/splash_screen.dart';
import 'package:crux/widgets/screens/auth/login.dart';
import 'package:crux/services/auth_provider.dart';

import 'package:crux/services/bookmark.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

// This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => Bookmark()),
//         ChangeNotifierProvider(create: (_) => AuthProvider()..initializeAuth()),
//       ],

//       child: Main(),
//     );
//   }
// }

// class Main extends StatelessWidget {
//   const Main({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Crux',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       debugShowCheckedModeBanner: false,
//       home: Consumer<AuthProvider>(
//         builder: (context, authProvider, child) {
//           print("MAIN isAuthenticated: ${authProvider.isAuthenticated}");

//           // return SplashScreen();
//           if (authProvider.isInitialized == false) {
//             return SplashScreen();
//           }

//           if (authProvider.isAuthenticated) {
//             return HomePage();
//           } else {
//             return Login();
//           }
//         },
//       ),
//     );
//   }
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider()..initializeAuth(),
        ), // AuthProvider initialized here
        ChangeNotifierProvider(create: (_) => Bookmark()),
      ],
      child: Main(),
    ),
  );
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crux',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (_) => MyApp());
      },
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      // Ensure this is a Consumer to listen to changes
      builder: (context, authProvider, child) {
        print("MAIN isAuthenticated: ${authProvider.isAuthenticated}");
        // authProvider.ensureValidToken();
        // return Profile();
        // THIS IS WORKING
        if (authProvider.isInitialized == false) {
          return SplashScreen();
        }

        if (authProvider.isAuthenticated) {
          return HomePage();
        } else {
          return Login();
        }
      },
    );
  }
}

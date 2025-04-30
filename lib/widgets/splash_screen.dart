import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // final authProvider = Provider.of<AuthProvider>(context, listen: false);
    // // _checkAuthentication();
    // Future.delayed(Duration(seconds: 2), () async {
    //   while (!authProvider.isInitialized) {
    //     await Future.delayed(Duration(milliseconds: 100));
    //   }
    // });
    // if (!mounted) return;
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (authProvider.isAuthenticated) {
    //     Navigator.of(
    //       context,
    //     ).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    //   } else {
    //     Navigator.of(
    //       context,
    //     ).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
    //   }
    // });
  }

  // void _checkAuthentication() async {
  // final authProvider = Provider.of<AuthProvider>(context, listen: false);
  // await Future.wait([
  //   authProvider.checkAuth(),
  //   Future.delayed(const Duration(seconds: 2)),
  // ]);
  // }

  // @override
  // void initState() {
  //   super.initState();
  // Future.delayed(Duration(seconds: 2), () {
  //   if (mounted) {
  //     Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(
  //         builder:
  //             (context) =>
  //                 widget.authProvider.isLoggedIn
  //                     ? const HomePage()
  //                     : const Login(),
  //       ),
  //     );
  //   }
  // });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/img/splash_screen.png",
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "crux",
                  style: TextStyle(
                    fontFamily: "Lato",
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    fontSize: 80,
                  ),
                ),
                Text(
                  "Your daily dose of insight",
                  style: TextStyle(
                    fontFamily: "Kanit",
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

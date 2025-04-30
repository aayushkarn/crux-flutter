import 'package:flutter/material.dart';

class MessageTemplate extends StatelessWidget {
  final String? message;
  final Widget? child;
  const MessageTemplate({super.key, this.message, this.child});

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
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  message != null && message!.isNotEmpty
                      ? Text(
                        "${message!}",
                        style: TextStyle(
                          fontFamily: "Lato",
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      )
                      : SizedBox.shrink(),
                  Container(child: child),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

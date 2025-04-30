import 'package:crux/services/token_storage.dart';
import 'package:crux/widgets/utils/bottom_navigation.dart';

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _test() async {
    print(await getAccessToken());
  }

  @override
  Widget build(BuildContext context) {
    _test();
    return Scaffold(body: BottomNavigation());
  }
}

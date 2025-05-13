import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart'; // sesuaikan dengan path kamu
import 'services/token_service.dart'; // pastikan path ini sesuai

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<Widget> _getInitialPage() async {
    final token = await TokenService.getToken();
    if (token != null && token.isNotEmpty) {
      return HomePage();
    } else {
      return LoginPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KaukabaPay',
      theme: ThemeData(primarySwatch: Colors.green, fontFamily: 'Chonburi'),
      home: FutureBuilder<Widget>(
        future: _getInitialPage(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return snapshot.data!;
          } else {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}

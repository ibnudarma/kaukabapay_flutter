import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../pages/login_page.dart';
import 'token_service.dart';

Future<void> checkTokenValidity(BuildContext context) async {
  final token = await TokenService.getToken();

  if (token == null) {
    _goToLogin(context);
    return;
  }

  try {
    final response = await http.get(
      Uri.parse('http://34.101.197.61/api/auth/cek_token'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode != 200) {
      await TokenService.removeToken();
      _goToLogin(context);
    }
  } catch (e) {
    // Gagal koneksi / error lain
    debugPrint('Token check error: $e');
    await TokenService.removeToken();
    _goToLogin(context);
  }
}

void _goToLogin(BuildContext context) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (_) => LoginPage()),
    (route) => false,
  );
}

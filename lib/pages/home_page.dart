import 'package:flutter/material.dart';
import 'package:kaukabapay_app/pages/riwayat_pembayaran_page.dart';
import 'package:kaukabapay_app/services/token_service.dart';
import 'package:kaukabapay_app/services/auth_service.dart';
import 'profile_page.dart';
import 'login_page.dart';
import 'tagihan_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkTokenValidity(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF00BF63),
        title: const Text('KaukabaPay', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          color: const Color(0xFFC8E6C9),
          width: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Text(
                "Menu",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  children: [
                    _buildMenuItem(
                      context,
                      'assets/profil.jpg',
                      'Profil Siswa',
                      ProfilePage(),
                    ),
                    _buildMenuItem(
                      context,
                      'assets/payment.jpg',
                      'Tagihan',
                      const TagihanPage(),
                    ),
                    _buildMenuItem(
                      context,
                      'assets/payment2.jpg',
                      'Riwayat Pembayaran',
                      const RiwayatPembayaranPage(),
                    ),
                    _buildLogoutButton(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    String imagePath,
    String label,
    Widget page,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  spreadRadius: 2,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: Image.asset(imagePath, width: 60, height: 60),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await TokenService.removeToken();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => LoginPage()),
          (route) => false,
        );
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  spreadRadius: 2,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: Image.asset('assets/signout.png', width: 60, height: 60),
          ),
          const SizedBox(height: 8),
          const Text('Keluar', style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}

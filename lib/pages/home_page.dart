import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/riwayat_pembayaran_page.dart';
import 'profile_page.dart';
import 'login_page.dart';
import 'tagihan_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => LoginPage()),
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5,
                                  spreadRadius: 2,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                            child: Image.asset(
                              'assets/signout.png',
                              width: 60,
                              height: 60,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text('Keluar', style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
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
              boxShadow: [
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
}

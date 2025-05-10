import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Map<String, String> studentData = {
    'Nama': 'Budi Santoso',
    'NIS': '123456789',
    'Jenis Kelamin': 'Laki-laki',
    'Tempat/Tanggal Lahir': 'Jakarta, 10 Mei 2005',
    'Kelas': '10A',
    'Nama Ayah': 'Sutrisno',
    'Nama Ibu': 'Siti Aminah',
    'No. Telp': '081234567890',
    'Alamat': 'Jl. Merdeka No. 10',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5DC),
      appBar: AppBar(
        title: const Text(
          "Profil Siswa",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF00BF63),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Foto Profil
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white, width: 2),
                image: const DecorationImage(
                  image: AssetImage('assets/profil.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Tabel dengan semua data tampil rapi & tidak bisa diedit
            Table(
              columnWidths: const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(4),
              },
              border: TableBorder.all(color: Colors.grey),
              children:
                  studentData.entries.map((entry) {
                    return TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 8.0,
                          ),
                          child: Text(
                            entry.key,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 8.0,
                          ),
                          child: Text(
                            entry.value,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

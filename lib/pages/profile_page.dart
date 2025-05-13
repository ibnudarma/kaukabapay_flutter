import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../services/token_service.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, String>? studentData;
  bool isLoading = true;
  String? errorMessage;
  String? studentPhoto;

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    try {
      final token = await TokenService.getToken();

      final response = await http.get(
        Uri.parse(
          'http://34.101.197.61/api/siswa/profile',
        ), // Ganti sesuai API kamu
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      final data = json.decode(response.body);

      if (response.statusCode == 200 && data['status'] == true) {
        final profile = data['data'];

        setState(() {
          studentData = {
            'Nama': profile['nama'] ?? '',
            'NIS': profile['nis'] ?? '',
            'Jenis Kelamin': profile['jenis_kelamin'],
            'Tempat/Tanggal Lahir':
                '${profile['tempat_lahir']}, ${profile['tanggal_lahir']}',
            'Alamat': profile['alamat'] ?? '',
            'Nama Orang Tua': profile['nama_orang_tua'] ?? '',
            'Kontak Orang Tua': profile['kontak_orang_tua'] ?? '',
            'Pekerjaan Orang Tua': profile['pekerjaan_orang_tua'] ?? '',
          };
          studentPhoto = profile['foto'];

          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = data['message'] ?? 'Gagal mengambil data';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Terjadi kesalahan koneksi.';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profil Siswa",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF00BF63),
        centerTitle: true,
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : errorMessage != null
              ? Center(child: Text(errorMessage!))
              : SingleChildScrollView(
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
                        image: DecorationImage(
                          image:
                              studentPhoto != null && studentPhoto!.isNotEmpty
                                  ? NetworkImage(
                                    'http://34.101.197.61/uploads/foto/$studentPhoto',
                                  )
                                  : NetworkImage(
                                    'http://34.101.197.61/uploads/foto/default.jpg',
                                  ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Tabel data profil
                    Table(
                      columnWidths: const {
                        0: FlexColumnWidth(2),
                        1: FlexColumnWidth(4),
                      },
                      border: TableBorder.all(color: Colors.grey),
                      children:
                          studentData!.entries.map((entry) {
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

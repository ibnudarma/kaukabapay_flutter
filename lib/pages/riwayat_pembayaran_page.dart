import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../services/token_service.dart';
import 'detail_pembayaran_page.dart';

class RiwayatPembayaranPage extends StatefulWidget {
  const RiwayatPembayaranPage({super.key});

  @override
  State<RiwayatPembayaranPage> createState() => _RiwayatPembayaranPageState();
}

class _RiwayatPembayaranPageState extends State<RiwayatPembayaranPage> {
  List<Map<String, dynamic>> riwayat = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchRiwayat();
  }

  Future<void> fetchRiwayat() async {
    try {
      final token = await TokenService.getToken();
      final response = await http.get(
        Uri.parse('http://34.101.197.61/api/siswa/pembayaran'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      final jsonData = json.decode(response.body);
      if (response.statusCode == 200 && jsonData['status'] == true) {
        final List<dynamic> data = jsonData['data'];
        setState(() {
          riwayat =
              data.map((item) => Map<String, dynamic>.from(item)).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = jsonData['message'] ?? 'Gagal memuat data riwayat.';
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
        backgroundColor: const Color(0xFF00BF63),
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Riwayat Pembayaran',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : errorMessage != null
              ? Center(child: Text(errorMessage!))
              : riwayat.isEmpty
              ? const Center(child: Text('Belum ada riwayat pembayaran.'))
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: riwayat.length,
                itemBuilder: (context, index) {
                  final pembayaran = riwayat[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          infoText(
                            "ID Pembayaran",
                            pembayaran['id_pembayaran'],
                          ),
                          const SizedBox(height: 8),
                          infoText(
                            "Jenis Tagihan",
                            pembayaran['jenis_tagihan'],
                          ),
                          const SizedBox(height: 8),
                          infoText(
                            "Jumlah Bayar",
                            "Rp${pembayaran['jumlah_bayar']}",
                          ),
                          const SizedBox(height: 8),
                          infoText(
                            "Waktu Pembayaran",
                            pembayaran['tanggal_pembayaran'],
                          ),
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF00BF63),
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => DetailPembayaranPage(
                                          id: pembayaran['id_pembayaran'],
                                          jumlah: pembayaran['jumlah_bayar'],
                                          tanggal:
                                              pembayaran['tanggal_pembayaran'],
                                          tagihan: pembayaran['jenis_tagihan'],
                                          metode:
                                              pembayaran['metode_pembayaran'] ??
                                              'tidak tersedia',
                                        ),
                                  ),
                                );
                              },
                              child: const Text('Lihat Detail'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
    );
  }

  Widget infoText(String label, String value) {
    return RichText(
      text: TextSpan(
        text: '$label: ',
        style: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
        children: [
          TextSpan(
            text: value,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

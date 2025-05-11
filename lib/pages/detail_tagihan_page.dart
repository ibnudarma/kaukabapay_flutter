import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../services/token_service.dart';
import 'notifikasi_tagihan.dart';

class DetailTagihanPage extends StatefulWidget {
  final String id_tagihan;
  final String bulan;
  final String jumlahTagihan;

  const DetailTagihanPage({
    super.key,
    required this.id_tagihan,
    required this.bulan,
    required this.jumlahTagihan,
  });

  @override
  State<DetailTagihanPage> createState() => _DetailTagihanPageState();
}

class _DetailTagihanPageState extends State<DetailTagihanPage> {
  Map<String, dynamic>? detail;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchDetailTagihan();
  }

  Future<void> fetchDetailTagihan() async {
    try {
      final token = await TokenService.getToken();
      final response = await http.get(
        Uri.parse(
          'http://34.101.197.61/api/siswa/tagihan?id_tagihan=${widget.id_tagihan}',
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      final data = json.decode(response.body);
      if (response.statusCode == 200 && data['status'] == true) {
        setState(() {
          detail = data['data'];
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = data['message'] ?? 'Gagal memuat detail tagihan.';
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
      backgroundColor: const Color(0xFFFFFDE7),
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        elevation: 4,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Detail Tagihan',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : errorMessage != null
              ? Center(child: Text(errorMessage!))
              : detail == null
              ? const Center(child: Text('Data tidak ditemukan.'))
              : SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEDEDED),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InfoRow(
                              label: 'ID Tagihan',
                              value: detail!['id_tagihan'] ?? '-',
                            ),
                            const SizedBox(height: 10),
                            InfoRow(
                              label: 'Nama Siswa',
                              value: detail!['nama'] ?? '-',
                            ),
                            const SizedBox(height: 10),
                            InfoRow(
                              label: 'Jenis Tagihan',
                              value: detail!['jenis_tagihan'] ?? '-',
                            ),
                            const SizedBox(height: 10),
                            InfoRow(
                              label: 'Jumlah Tagihan',
                              value: 'Rp${detail!['jumlah'] ?? '0'}',
                            ),
                            const SizedBox(height: 10),
                            InfoRow(
                              label: 'Dibayar',
                              value: 'Rp${detail!['dibayar'] ?? '0'}',
                            ),
                            const SizedBox(height: 10),
                            InfoRow(
                              label: 'Sisa Tagihan',
                              value: 'Rp${detail!['sisa_tagihan'] ?? '0'}',
                            ),
                            const SizedBox(height: 10),
                            InfoRow(
                              label: 'Status',
                              value:
                                  (detail!['status'] ?? '-')
                                      .toString()
                                      .toUpperCase(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.greenAccent,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            final token = await TokenService.getToken();
                            try {
                              final response = await http.post(
                                Uri.parse(
                                  'http://34.101.197.61/api/siswa/bayar',
                                ),
                                headers: {
                                  'Authorization': 'Bearer $token',
                                  'Content-Type': 'application/json',
                                },
                                body: jsonEncode({
                                  'id_tagihan': widget.id_tagihan,
                                }),
                              );

                              final responseData = json.decode(response.body);
                              if (response.statusCode == 200 &&
                                  responseData['status'] == true) {
                                // Pembayaran berhasil, arahkan ke halaman notifikasi
                                if (!mounted) return;
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => const NotifikasiTagihan(),
                                  ),
                                );
                              } else {
                                // Tampilkan pesan error
                                if (!mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      responseData['message'] ??
                                          'Pembayaran gagal.',
                                    ),
                                    backgroundColor: Colors.redAccent,
                                  ),
                                );
                              }
                            } catch (e) {
                              if (!mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Terjadi kesalahan saat memproses pembayaran.',
                                  ),
                                  backgroundColor: Colors.redAccent,
                                ),
                              );
                            }
                          },
                          child: const Text(
                            'Bayar Sekarang',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({required this.label, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            '$label:',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(value, style: const TextStyle(fontSize: 16)),
        ),
      ],
    );
  }
}

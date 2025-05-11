import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../services/token_service.dart';
import 'detail_tagihan_page.dart';

class TagihanPage extends StatefulWidget {
  const TagihanPage({super.key});

  @override
  State<TagihanPage> createState() => _TagihanPageState();
}

class _TagihanPageState extends State<TagihanPage> {
  List<dynamic> tagihanList = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchTagihan();
  }

  Future<void> fetchTagihan() async {
    try {
      final token = await TokenService.getToken();
      final response = await http.get(
        Uri.parse('http://34.101.197.61/api/siswa/tagihan'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      final data = json.decode(response.body);
      if (response.statusCode == 200 && data['status'] == true) {
        setState(() {
          tagihanList = data['data'];
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = data['message'] ?? 'Gagal mengambil data tagihan';
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
        backgroundColor: Colors.greenAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Tagihan',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(child: Text(errorMessage!))
              : tagihanList.isEmpty
                  ? const Center(child: Text('Tidak ada data tagihan'))
                  : ListView.builder(
                      itemCount: tagihanList.length,
                      padding: const EdgeInsets.all(12),
                      itemBuilder: (context, index) {
                        final item = tagihanList[index];
                        final status = item['status'] ?? 'Belum Diketahui';
                        final isLunas = status.toLowerCase() == 'lunas';
                        final jenisTagihan = item['jenis_tagihan'] ?? 'Tidak diketahui';
                        final jumlah = item['jumlah'] ?? 0;
                        final id_tagihan = item['id_tagihan'];

                        return Card(
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            title: Text(jenisTagihan),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Jumlah: Rp$jumlah'),
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: isLunas ? Colors.green : Colors.yellow,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    status,
                                    style: TextStyle(
                                      color: isLunas ? Colors.white : Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                            onTap: () {
                              if (id_tagihan != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailTagihanPage(
                                      id_tagihan: id_tagihan,
                                      bulan: jenisTagihan,
                                      jumlahTagihan: 'Rp$jumlah',
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        );
                      },
                    ),
    );
  }
}

import 'package:flutter/material.dart';
import 'detail_pembayaran_page.dart';

class RiwayatPembayaranPage extends StatelessWidget {
  const RiwayatPembayaranPage({super.key});

  final List<Map<String, String>> riwayat = const [
    {'id': '12356', 'jumlah': '350.000', 'tanggal': '03-07-2025'},
    {'id': '12356', 'jumlah': '350.000', 'tanggal': '03-08-2025'},
    {'id': '12356', 'jumlah': '350.000', 'tanggal': '03-09-2025'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: const Color(0xFF00BF63),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Riwayat Pembayaran',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(0)),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: riwayat.length,
        itemBuilder: (context, index) {
          final pembayaran = riwayat[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InfoRow(label: 'ID Pembayaran', value: pembayaran['id']!),
                    const SizedBox(height: 6),
                    InfoRow(
                      label: 'Jumlah Pembayaran',
                      value: pembayaran['jumlah']!,
                    ),
                    const SizedBox(height: 6),
                    InfoRow(label: 'Tanggal', value: pembayaran['tanggal']!),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => DetailPembayaranPage(
                                    id: pembayaran['id']!,
                                    jumlah: pembayaran['jumlah']!,
                                    tanggal: pembayaran['tanggal']!,
                                  ),
                            ),
                          );
                        },

                        child: const Text('Detail'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
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
      children: [
        Expanded(child: Text('$label :', style: const TextStyle(fontSize: 14))),
        Expanded(child: Text(value, style: const TextStyle(fontSize: 14))),
      ],
    );
  }
}

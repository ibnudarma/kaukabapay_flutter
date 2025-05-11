import 'package:flutter/material.dart';

class DetailPembayaranPage extends StatelessWidget {
  final String id;
  final String jumlah;
  final String tanggal;

  const DetailPembayaranPage({
    super.key,
    required this.id,
    required this.jumlah,
    required this.tanggal,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFDE7),
      appBar: AppBar(
        backgroundColor: const Color(0xFF00BF63),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Detail Pembayaran',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Card(
                color: const Color(0xFFEFEFEF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 24,
                  ),
                  child: Column(
                    children: [
                      _buildCenteredDetail('ID Pembayaran', id),
                      const Divider(),
                      _buildCenteredDetail('Jumlah Pembayaran', jumlah),
                      const Divider(),
                      _buildCenteredDetail('Tanggal Pembayaran', tanggal),
                      const Divider(),
                      _buildCenteredDetail('Nama Siswa', 'Budi Santoso'),
                      const Divider(),
                      _buildCenteredDetail('Status Pembayaran', 'Sudah Lunas'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Aksi cetak bisa ditambahkan di sini
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF72F2B9),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('Cetak Bukti Pembayaran'),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCenteredDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

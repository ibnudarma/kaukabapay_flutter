import 'package:flutter/material.dart';
import 'detail_tagihan_page.dart';

class TagihanPage extends StatelessWidget {
  const TagihanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> dataTagihan = [
      {'bulan': 'Januari', 'tagihan': 'Rp500.000', 'status': 'Belum Lunas'},
      {'bulan': 'Februari', 'tagihan': 'Rp450.000', 'status': 'Lunas'},
      {'bulan': 'Maret', 'tagihan': 'Rp520.000', 'status': 'Belum Lunas'},
    ];

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
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            'TAGIHAN BULANAN',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Expanded(
            child:
                dataTagihan.isNotEmpty
                    ? ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: dataTagihan.length,
                      itemBuilder: (context, index) {
                        final data = dataTagihan[index];
                        final status = data['status']!;
                        final isLunas = status == 'Lunas';
                        final badgeColor =
                            isLunas ? Colors.green : Colors.yellow;
                        final badgeTextColor =
                            isLunas ? Colors.white : Colors.black;

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          child: Card(
                            elevation: 4,
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              title: Text(
                                data['bulan']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Jumlah: ${data['tagihan']!}'),
                                  const SizedBox(height: 4),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: badgeColor,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      status,
                                      style: TextStyle(
                                        color: badgeTextColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              trailing: const Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => DetailTagihanPage(
                                          bulan: data['bulan']!,
                                          jumlahTagihan: data['tagihan']!,
                                        ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    )
                    : const Center(
                      child: Text(
                        'Tidak ada data tagihan',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
          ),
        ],
      ),
    );
  }
}

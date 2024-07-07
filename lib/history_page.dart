import 'package:flutter/material.dart';
import 'database_helper.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan History'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: DatabaseHelper().getQRCodes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No scan history'));
          }
          final qrCodes = snapshot.data!;
          return ListView.builder(
            itemCount: qrCodes.length,
            itemBuilder: (context, index) {
              final qrCode = qrCodes[index];
              return ListTile(
                title: Text(qrCode['data']),
                subtitle: Text('Format: ${qrCode['format']}'),
                trailing: Text(qrCode['timestamp']),
              );
            },
          );
        },
      ),
    );
  }
}

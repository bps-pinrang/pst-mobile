import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';

import '../controllers/download_history_controller.dart';

class DownloadHistoryView extends GetView<DownloadHistoryController> {
  const DownloadHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Unduhan'),
      ),
      body: FutureBuilder<List<DownloadTask>?>(
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitFadingCircle(
                size: 30,
                color: theme.colorScheme.primary,
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Gagal memuat data unduhan!'),
                ],
              ),
            );
          }

          if(snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Belum ada data unduhan!'),
                ],
              ),
            );
          }

          return ListView.separated(
            itemBuilder: (_, index) {
              final item = snapshot.data![index];
              return ListTile(
                title: Text(item.filename.toString()),
                subtitle: Text(item.progress.toStringAsFixed(0)),
              );
            },
            separatorBuilder: (_, __) => const Divider(
              height: 2,
            ),
            itemCount: snapshot.data?.length ?? 0,
          );
        },
        future: FlutterDownloader.loadTasks(),
      ),
    );
  }
}

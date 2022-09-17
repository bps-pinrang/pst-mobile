
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pst_online/app/core/utils/view_helper.dart';
import 'package:pst_online/app/core/values/size.dart';

import '../../../core/extensions/custom_color.dart';
import '../controllers/download_history_controller.dart';

class DownloadHistoryView extends GetView<DownloadHistoryController> {
  const DownloadHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final customColor = theme.extension<CustomColors>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Unduhan'),
      ),
      body: Obx(
        () {
          final downloadTasks = controller.downloads.value;
          if (downloadTasks.isEmpty) {
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
              final item = downloadTasks[index];
              var progressColor = theme.colorScheme.primary;
              var status = 'Mengunduh';

              if (item.status == DownloadTaskStatus.paused) {
                progressColor = theme.colorScheme.secondary;
                status = 'Dihentikan Sementara';
              } else if (item.status == DownloadTaskStatus.canceled ||
                  item.status == DownloadTaskStatus.undefined) {
                progressColor = theme.disabledColor;
                status = 'Dibatalkan';
              } else if (item.status == DownloadTaskStatus.complete) {
                progressColor = customColor!.success!;
                status = 'Selesai';
              } else if (item.status == DownloadTaskStatus.failed) {
                progressColor = theme.colorScheme.error;
                status = 'Gagal';
              } else if (item.status == DownloadTaskStatus.enqueued) {
                status = 'Dalam Antrian';
              }

              return Slidable(
                enabled: true,
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  dragDismissible: true,
                  children: [
                    SlidableAction(
                      onPressed: (value) {
                        print(value);
                        showConfirmationDialog(
                          context,
                          title: 'Yakin?',
                          content:
                              'Apakah anda ingin menghapus unduhan ini? File yang diunduh akan ikut terhapus!',
                          onConfirm: () =>
                              controller.handleDeleteTask(item.taskId),
                          confirmLabel: 'Ya',
                          cancelLabel: 'Tidak',
                        );
                      },
                      label: 'Hapus',
                      backgroundColor: theme.colorScheme.error,
                      icon: Icons.delete,
                    )
                  ],
                ),
                child: InkWell(
                  onTap: () {
                    FlutterDownloader.open(taskId: item.taskId);
                  },
                  child: Container(
                    padding: kPadding16,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          LineIcons.file,
                          size: 48,
                        ),
                        horizontalSpace(8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.filename ?? '',
                                style: textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              verticalSpace(4),
                              Text(
                                'Lokasi',
                                style: textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                item.savedDir,
                                maxLines: 2,
                                style: textTheme.caption,
                              ),
                              verticalSpace(8),
                              LinearPercentIndicator(
                                animation: true,
                                barRadius: const Radius.circular(10),
                                padding: EdgeInsets.zero,
                                percent: item.progress / 100,
                                progressColor: progressColor,
                              ),
                              verticalSpace(4),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  FittedBox(
                                    child: Text(status),
                                  ),
                                  Text(
                                    '${(item.progress).toStringAsFixed(0)}%',
                                    style: textTheme.labelSmall,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        horizontalSpace(8),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.download),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (_, __) => const Divider(
              height: 2,
            ),
            itemCount: downloadTasks.length,
          );
        },
      ),
    );
  }
}

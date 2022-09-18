import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pst_online/app/core/values/size.dart';
import 'package:pst_online/app/core/values/strings.dart';
import 'package:pst_online/app/data/models/statistic_table.dart';
import 'package:pst_online/app/global_widgets/infinite_scroll.dart';
import 'package:pst_online/app/global_widgets/statistic_table_card.dart';
import 'package:pst_online/app/routes/app_pages.dart';

import '../controllers/statistics_controller.dart';
import '../../../../i18n/strings.g.dart';

class StatisticsView extends GetView<StatisticsController> {
  const StatisticsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: theme.canvasColor,
        title: Text(t.label.menu.statistics),
        scrolledUnderElevation: 10.0,
        bottom: PreferredSize(
          preferredSize: Size(Get.width, 24),
          child: Padding(
            padding: kPadding16H,
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: '${controller.apiMeta.value?.total ?? 0} ',
                      style: textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      children: [
                        TextSpan(
                          text: t.label.menu.statistics,
                          style: textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: ' ${t.loaded}',
                          style: textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      body: InfiniteScroll(
        scrollController: controller.scrollController,
        pagingController: controller.pagingController,
        noItemDescription: 'Tidak ada tabel statistik!',
        noItemTitle: 'Kosong',
        itemBuilder: (_, item, index) {
          final statisticTable = item as StatisticTable;
          return StatisticTableCard(
            onTap: () {
              Get.toNamed(
                Routes.statisticDetail,
                arguments: {
                  kArgumentKeyUser: controller.user.value,
                  kArgumentKeyId: statisticTable.id.toString(),
                },
              );
              controller.handleRead(statisticTable);
            },
            statisticTable: statisticTable,
          );
        },
        showDivider: true,
      ),
    );
  }
}

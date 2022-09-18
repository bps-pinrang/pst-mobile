import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pst_online/app/data/models/statistic_table.dart';

import '../core/enums/button_size.dart';
import '../core/utils/helper.dart';
import '../core/utils/view_helper.dart';
import '../core/values/size.dart';
import 'app_button.dart';

class StatisticTableCard extends StatelessWidget {
  const StatisticTableCard({
    super.key,
    required this.onTap,
    required this.statisticTable,
  });

  final GestureTapCallback onTap;
  final StatisticTable statisticTable;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: kPadding16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              statisticTable.title,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            verticalSpace(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatDate('EEEE, dd MMMM yyyy', statisticTable.updateDate),
                  style: textTheme.caption,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(LineIcons.excelFileAlt),
                      horizontalSpace(4),
                      Text(statisticTable.size),
                    ],
                  ),
                )
              ],
            ),
            verticalSpace(16),
            AppButton.primary(
              buttonSize: ButtonSize.large,
              label: 'Lihat Detail',
              onPressed: onTap,
              isDense: true,
            )
          ],
        ),
      ),
    );
  }
}

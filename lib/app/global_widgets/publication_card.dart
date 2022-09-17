import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pst_online/app/data/models/publication.dart';
import 'package:pst_online/app/global_widgets/app_network_image.dart';

import '../core/enums/button_size.dart';
import '../core/utils/helper.dart';
import '../core/utils/view_helper.dart';
import '../core/values/size.dart';
import 'app_button.dart';

class PublicationCard extends StatelessWidget {
  const PublicationCard({
    super.key,
    this.onDetail,
    this.onDownload,
    required this.publication,
  });

  final Publication publication;
  final GestureTapCallback? onDetail;
  final GestureTapCallback? onDownload;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Container(
      padding: kPadding16,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: theme.canvasColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppNetworkImage(
            url: publication.cover,
            width: Get.width * 0.3,
            height: Get.height * 0.2,
          ),
          horizontalSpace(8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  publication.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                verticalSpace(16),
                Text(
                  'ISSN : ${publication.issn}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.labelSmall,
                ),
                verticalSpace(16),
                Row(
                  children: [
                    Icon(
                      LineIcons.calendarAlt,
                      color: theme.hintColor,
                      size: 16,
                    ),
                    horizontalSpace(4),
                    Expanded(
                      child: Text(
                        formatDate('EEEE, dd MMM y', publication.releaseDate),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.labelSmall,
                      ),
                    )
                  ],
                ),
                verticalSpace(8),
                Row(
                  children: [
                    Icon(
                      LineIcons.pdfFile,
                      color: theme.hintColor,
                      size: 16,
                    ),
                    horizontalSpace(4),
                    Expanded(
                      child: Text(
                        publication.size,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  ],
                ),
                verticalSpace(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: AppButton.secondary(
                        onPressed: onDetail,
                        label: 'Lihat Detail',
                        buttonSize: ButtonSize.medium,
                        isDense: true,
                      ),
                    ),
                    horizontalSpace(16),
                    Expanded(
                      child: AppButton.primary(
                        onPressed: onDownload,
                        label: 'Unduh',
                        buttonSize: ButtonSize.medium,
                        isDense: true,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

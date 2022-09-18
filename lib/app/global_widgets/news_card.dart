import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:pst_online/app/data/models/news.dart';

import '../core/utils/helper.dart';
import '../core/utils/view_helper.dart';
import '../core/values/size.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({
    super.key,
    required this.news,
    required this.readTime,
    required this.onPressed,
  });

  final News news;
  final String readTime;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Container(
      margin: kPadding16,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(Get.isDarkMode ? 0.6 : 0.1),
            blurRadius: 12,
          )
        ],
      ),
      child: Material(
        elevation: 0,
        color: theme.canvasColor,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: kPadding16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  news.title,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                verticalSpace(4),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        formatDate('EEEE, dd MMMM yyyy', news.releaseDate),
                        style: textTheme.subtitle2,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '#${news.categoryName?.toLowerCase().replaceAll(' ', '')}',
                        style: textTheme.caption,
                        textAlign: TextAlign.end,
                      ),
                    )
                  ],
                ),
                const Divider(),
                verticalSpace(8),
                HtmlWidget(
                  news.news,
                  textStyle: textTheme.caption,
                ),
                verticalSpace(8),
                const Divider(),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: theme.colorScheme.primaryContainer,
                      child: ExtendedImage.asset(
                        'assets/logo/bps_icon.png',
                        width: 15,
                        height: 15,
                      ),
                    ),
                    horizontalSpace(4),
                    Text(
                      'BPS Kabupaten Pinrang',
                      style: textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        readTime,
                        style: textTheme.caption,
                        textAlign: TextAlign.end,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

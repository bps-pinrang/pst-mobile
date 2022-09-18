import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pst_online/app/core/utils/helper.dart';
import 'package:pst_online/app/core/utils/view_helper.dart';
import 'package:pst_online/app/core/values/size.dart';
import 'package:pst_online/app/core/values/strings.dart';
import 'package:pst_online/app/data/models/news.dart';
import 'package:pst_online/app/global_widgets/app_action_chip.dart';
import 'package:pst_online/app/global_widgets/infinite_scroll.dart';
import 'package:pst_online/app/global_widgets/news_card.dart';
import 'package:pst_online/app/routes/app_pages.dart';
import 'package:reading_time/reading_time.dart';

import '../../../data/models/news_category.dart';
import '../../../global_widgets/app_filter_chip.dart';
import '../controllers/news_controller.dart';
import '../../../../i18n/strings.g.dart';

class NewsView extends GetView<NewsController> {
  const NewsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(t.label.menu.news),
        surfaceTintColor: theme.canvasColor,
        scrolledUnderElevation: 10.0,
        bottom: PreferredSize(
          preferredSize: Size(Get.width, 48),
          child: Padding(
            padding: kPadding16H,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(LineIcons.filter),
                      horizontalSpace(8),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Obx(
                                () => AppActionChip(
                                  label: controller.selectedYear.value == null
                                      ? 'Tahun'
                                      : controller.selectedYear.value ?? '',
                                  bgColor: controller.selectedYear.value == null
                                      ? theme.canvasColor
                                      : theme.colorScheme.primaryContainer,
                                  onPressed: () {
                                    DatePicker.showDatePicker(
                                      context,
                                      dateFormat: 'yyyy',
                                      initialDateTime: DateTime(int.parse(
                                          controller.selectedYear.value ??
                                              DateTime.now().year.toString())),
                                      locale: DateTimePickerLocale.id,
                                      maxDateTime:
                                          DateTime(DateTime.now().year),
                                      minDateTime: DateTime(2016),
                                      onMonthChangeStartWithFirstDate: true,
                                      pickerMode: DateTimePickerMode.date,
                                      onConfirm: (date, data) {
                                        controller.applyYearFilter(
                                            date.year.toString());
                                      },
                                      onCancel: () {
                                        controller.applyYearFilter(null);
                                      },
                                    );
                                  },
                                ),
                              ),
                              horizontalSpace(8),
                              Obx(
                                () => AppActionChip(
                                  label: controller.selectedMonth.value == null
                                      ? 'Bulan'
                                      : controller.monthName.value,
                                  bgColor:
                                      controller.selectedMonth.value == null
                                          ? theme.canvasColor
                                          : theme.colorScheme.primaryContainer,
                                  onPressed: () {
                                    DatePicker.showDatePicker(
                                      context,
                                      dateFormat: 'MMMM',
                                      locale: DateTimePickerLocale.id,
                                      maxDateTime:
                                          DateTime(DateTime.now().year, 12),
                                      minDateTime:
                                          DateTime(DateTime.now().year, 1),
                                      onMonthChangeStartWithFirstDate: true,
                                      pickerMode: DateTimePickerMode.date,
                                      onConfirm: (date, data) {
                                        controller.applyMonthFilter(
                                            date.month.toString());
                                        controller.monthName.value =
                                            formatDate('MMMM', date);
                                      },
                                      onCancel: () {
                                        controller.applyMonthFilter(null);
                                      },
                                    );
                                  },
                                ),
                              ),
                              horizontalSpace(8),
                              Obx(
                                () => AppActionChip(
                                  label: controller.selectedCategory.value ==
                                          null
                                      ? 'Kategori'
                                      : controller.selectedCategory.value?.id ??
                                          '',
                                  bgColor:
                                      controller.selectedCategory.value == null
                                          ? theme.canvasColor
                                          : theme.colorScheme.primaryContainer,
                                  onPressed: () {
                                    showBottomSheetDialog(
                                      context: context,
                                      content: Obx(
                                        () => _CategoryFilterWidget(
                                          applyFilter:
                                              controller.applyCategoryFilter,
                                          newsCategories:
                                              controller.newsCategories.value,
                                          selectedCategory:
                                              controller.selectedCategory.value,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Obx(
                    () => FittedBox(
                      child: RichText(
                        text: TextSpan(
                          text: '${controller.apiMeta.value?.total ?? 0} ',
                          style: textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                          children: [
                            TextSpan(
                              text: t.label.menu.news,
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
                      ),
                    ),
                  ),
                  verticalSpace(8),
                ],
              ),
            ),
          ),
        ),
      ),
      body: InfiniteScroll(
        scrollController: controller.scrollController,
        pagingController: controller.pagingController,
        noItemDescription: 'Tidak ada berita!',
        noItemTitle: 'Kosong!',
        itemBuilder: (_, item, index) {
          final news = item as News;
          final readTime = readingTime(Bidi.stripHtmlIfNeeded(news.news),
              suffix: ' menit', lessMsg: ' kurang dari satu menit');
          return NewsCard(
            news: news,
            readTime: readTime.msg,
            onPressed: () {
              Get.toNamed(
                Routes.newsDetail,
                arguments: {
                  kArgumentKeyId: news.id.toString(),
                  kArgumentKeyUser: controller.user.value,
                },
              );
              controller.handleRead(news);
            },
          );
        },
        showDivider: false,
      ),
    );
  }
}

class _CategoryFilterWidget extends StatelessWidget {
  const _CategoryFilterWidget({
    required this.applyFilter,
    required this.newsCategories,
    required this.selectedCategory,
  });

  final NewsCategory? selectedCategory;
  final List<NewsCategory> newsCategories;
  final void Function(NewsCategory?) applyFilter;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pilih Kategori',
          style: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        verticalSpace(8),
        Wrap(
          direction: Axis.horizontal,
          spacing: 8,
          children: newsCategories
              .map(
                (element) => AppFilterChip(
                  label: element.id,
                  onSelected: (value) => applyFilter.call(element),
                  selected: selectedCategory?.id == element.id,
                ),
              )
              .toList()
              .followedBy(
            [
              AppFilterChip(
                label: 'Semua',
                onSelected: (value) => applyFilter.call(null),
                selected: selectedCategory == null,
              )
            ],
          ).toList(),
        ),
      ],
    );
  }
}

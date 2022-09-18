import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';

import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pst_online/app/core/utils/view_helper.dart';
import 'package:pst_online/app/core/values/size.dart';
import 'package:pst_online/app/core/values/strings.dart';
import 'package:pst_online/app/data/models/publication.dart';
import 'package:pst_online/app/global_widgets/infinite_scroll.dart';
import 'package:pst_online/app/global_widgets/publication_card.dart';
import 'package:pst_online/app/routes/app_pages.dart';

import '../../../global_widgets/unauthenticated_placeholder.dart';
import '../controllers/publications_controller.dart';
import '../../../../i18n/strings.g.dart';

class PublicationsView extends GetView<PublicationsController> {
  const PublicationsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(t.label.menu.publication(count: 2)),
        surfaceTintColor: theme.canvasColor,
        scrolledUnderElevation: 10.0,
        bottom: PreferredSize(
          preferredSize: Size(Get.width, 28),
          child: Padding(
            padding: kPadding16H,
            child: Center(
              child: Row(
                children: [
                  const Icon(LineIcons.filter),
                  horizontalSpace(8),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ActionChip(
                            label: Obx(
                              () {
                                if (controller.selectedDate.value == null) {
                                  return const Text('Tahun');
                                }

                                return Text(
                                  controller.selectedDate.value!.year
                                      .toString(),
                                );
                              },
                            ),
                            avatar: const Icon(Icons.arrow_drop_down),
                            backgroundColor: theme.canvasColor,
                            shadowColor: theme.shadowColor.withOpacity(0.3),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)),
                            side: BorderSide(
                              width: 1,
                              color: theme.dividerColor,
                            ),
                            onPressed: () {
                              DatePicker.showDatePicker(context,
                                  dateFormat: 'yyyy',
                                  initialDateTime:
                                      controller.selectedDate.value ??
                                          DateTime.now(),
                                  locale: DateTimePickerLocale.id,
                                  maxDateTime: DateTime(DateTime.now().year),
                                  minDateTime: DateTime(2010),
                                  onMonthChangeStartWithFirstDate: true,
                                  pickerMode: DateTimePickerMode.date,
                                  onConfirm: (date, data) {
                                controller.applyYearFilter(date);
                              }, onCancel: () {
                                controller.applyYearFilter(null);
                              });
                            },
                            surfaceTintColor: theme.disabledColor,
                            labelStyle: textTheme.caption?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  horizontalSpace(8),
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
                              text: t.label.menu.publication(
                                count: controller.apiMeta.value?.total ?? 0,
                              ),
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
                ],
              ),
            ),
          ),
        ),
      ),
      body: InfiniteScroll(
        scrollController: controller.scrollController,
        pagingController: controller.pagingController,
        noItemDescription: 'Tidak ada publikasi',
        noItemTitle: 'Kosong!',
        itemBuilder: (_, item, index) {
          final publication = item as Publication;
          return PublicationCard(
            publication: publication,
            onDetail: () {
              FirebaseAnalytics.instance.logSelectContent(
                contentType:'Publikasi',
                itemId: publication.title,
              );
              Get.toNamed(
                Routes.publicationDetail,
                arguments: {
                  kArgumentKeyUser: controller.user.value,
                  kArgumentKeyPublicationId: publication.id,
                },
              );
            },
            onDownload: () {
              final user = controller.user.value;
              if (user != null) {
                controller.handleDownload(
                  url: publication.pdf,
                  fileName: publication.title,
                  extension: 'pdf',
                );
              } else {
                showBottomSheetDialog(
                  context: context,
                  content: const UnauthenticatedPlaceholder(),
                );
              }
            },
          );
        },
        showDivider: true,
      ),
    );
  }
}

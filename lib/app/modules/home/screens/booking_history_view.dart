// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:pst_online/app/core/enums/app_animation.dart';
import 'package:pst_online/app/core/extensions/custom_color.dart';
import 'package:pst_online/app/core/utils/helper.dart';
import 'package:pst_online/app/core/utils/view_helper.dart';
import 'package:pst_online/app/global_widgets/lottie_with_author.dart';
import 'package:pst_online/app/global_widgets/shimmer_widget.dart';

import '../../../core/values/size.dart';
import '../../../global_widgets/unauthenticated_placeholder.dart';
import '../controllers/home_controller.dart';

class BookingHistoryView extends GetView<HomeController> {
  const BookingHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final extensionColor = Theme.of(context).extension<CustomColors>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Kunjungan'),
        scrolledUnderElevation: 10.0,
        surfaceTintColor: theme.canvasColor,
      ),
      body: Obx(() => _buildBody(context)),
    );
  }

  Widget _buildBody(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final extensionColor = Theme.of(context).extension<CustomColors>();

    if (controller.user.value == null) {
      return Container(
        padding: kPadding16,
        height: Get.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [UnauthenticatedPlaceholder()],
        ),
      );
    }

    if (controller.isAppointmentLoading.value) {
      return ListView.separated(
        itemBuilder: (_, __) => Container(
          padding: kPadding16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerWidget(width: Get.width, height: 12),
              verticalSpace(8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.calendar_month_rounded),
                        horizontalSpace(8),
                        ShimmerWidget(width: Get.width * 0.25, height: 10),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(Icons.access_time_rounded),
                        horizontalSpace(8),
                        ShimmerWidget(width: Get.width * 0.15, height: 12),
                      ],
                    ),
                  )
                ],
              ),
              verticalSpace(8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(
                    label: ShimmerWidget(width: Get.width * 0.1, height: 12),
                    labelStyle: textTheme.caption?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                    backgroundColor: theme.colorScheme.primaryContainer,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ShimmerWidget(width: Get.width * 0.2, height: 12),
                      ],
                    ),
                  )
                ],
              ),
              verticalSpace(8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerWidget(width: Get.width * 0.2, height: 12),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            RatingBar(
                              initialRating: 0,
                              minRating: 0,
                              direction: Axis.horizontal,
                              maxRating: 5,
                              itemSize: 16,
                              updateOnDrag: false,
                              allowHalfRating: true,
                              ignoreGestures: true,
                              itemCount: 5,
                              ratingWidget: RatingWidget(
                                full: const Icon(
                                  Icons.star_rate_rounded,
                                  color: Colors.amber,
                                ),
                                half: const Icon(
                                  Icons.star_half_rounded,
                                  color: Colors.amber,
                                ),
                                empty: Icon(
                                  Icons.star_rate_rounded,
                                  color: theme.disabledColor.withOpacity(0.2),
                                ),
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                            verticalSpace(4),
                            Text(
                              '0/5',
                              style: textTheme.caption,
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        separatorBuilder: (_, __) => const Divider(),
        shrinkWrap: true,
        itemCount: 10,
      );
    }

    if (controller.appointments.isEmpty) {
      return const Padding(
        padding: kPadding16,
        child: Center(
          child: LottieWithAuthor(
            title: 'Kosong',
            message: 'Anda belum pernah melakukan kunjungan',
            animation: AppAnimation.notFound,
            semanticLabel:
                'Anda belum memiliki riwayat kunjungan. Silahkan buat janji kunjungan melalui menu Booking Kunjungan',
          ),
        ),
      );
    }

    return ListView.separated(
      itemBuilder: (_, index) {
        final item = controller.appointments[index];
        return InkWell(
          onTap: () {},
          child: Container(
            padding: kPadding16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.purpose ?? item.usage.name,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                verticalSpace(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(Icons.calendar_month_rounded),
                          horizontalSpace(8),
                          Text(
                            formatDate(
                              'EEEE, dd MMMM yyyy',
                              item.appointmentDate.toLocal(),
                            ),
                            style: textTheme.caption,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(Icons.access_time_rounded),
                          horizontalSpace(8),
                          Text(
                            formatDate(
                              'HH:mm',
                              item.appointmentDate.toLocal(),
                            ),
                            style: textTheme.caption,
                          )
                        ],
                      ),
                    )
                  ],
                ),
                verticalSpace(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Chip(
                      label: Text(item.status.name),
                      labelStyle: textTheme.caption?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                      backgroundColor: theme.colorScheme.primaryContainer,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${item.services.length} layanan dipilih',
                            style: textTheme.caption,
                          )
                        ],
                      ),
                    )
                  ],
                ),
                verticalSpace(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.rating == null ? 'Belum Dinilai' : item.rating!.name,
                      style: textTheme.caption?.copyWith(),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              RatingBar(
                                initialRating: item.score.toDouble(),
                                minRating: 0,
                                direction: Axis.horizontal,
                                maxRating: 5,
                                itemSize: 16,
                                updateOnDrag: false,
                                allowHalfRating: true,
                                ignoreGestures: true,
                                itemCount: 5,
                                ratingWidget: RatingWidget(
                                  full: const Icon(
                                    Icons.star_rate_rounded,
                                    color: Colors.amber,
                                  ),
                                  half: const Icon(
                                    Icons.star_half_rounded,
                                    color: Colors.amber,
                                  ),
                                  empty: Icon(
                                    Icons.star_rate_rounded,
                                    color: theme.disabledColor.withOpacity(0.2),
                                  ),
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                              verticalSpace(4),
                              Text(
                                '${item.score}/5',
                                style: textTheme.caption,
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
      separatorBuilder: (_, __) => const Divider(),
      itemCount: controller.appointments.value.length,
      shrinkWrap: true,
    );
  }
}

import 'package:drop_shadow/drop_shadow.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';
import 'package:pst_online/app/core/enums/button_size.dart';
import 'package:pst_online/app/core/utils/helper.dart';
import 'package:pst_online/app/core/utils/view_helper.dart';
import 'package:pst_online/app/core/values/size.dart';
import 'package:pst_online/app/core/values/strings.dart';
import 'package:pst_online/app/global_widgets/app_button.dart';
import 'package:pst_online/app/global_widgets/app_network_image.dart';
import 'package:pst_online/app/global_widgets/shimmer_widget.dart';
import 'package:pst_online/app/routes/app_pages.dart';

import '../../../data/models/failure.dart';
import '../../../data/models/publication.dart';
import '../../../global_widgets/unauthenticated_placeholder.dart';
import '../controllers/publication_detail_controller.dart';

class PublicationDetailView extends GetView<PublicationDetailController> {
  const PublicationDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: FooterLayout(
        footer: Container(
          decoration: BoxDecoration(
            color: theme.canvasColor,
            boxShadow: [
              BoxShadow(
                color: theme.shadowColor.withOpacity(0.2),
                blurRadius: 12,
                spreadRadius: 6,
              )
            ],
          ),
          padding: kPadding16,
          child: Row(
            children: [
              Expanded(
                child: Obx(
                  () => AppButton.secondary(
                    label: 'Baca',
                    onPressed: controller.publication.value == null
                        ? null
                        : () {
                            final user = controller.user.value;
                            if (user != null) {
                              controller.handleRead();
                              Get.toNamed(
                                Routes.pdfReader,
                                arguments: {
                                  kArgumentKeyTitle:
                                      controller.publication.value?.title,
                                  kArgumentKeyUrl:
                                      controller.publication.value?.pdf,
                                },
                              );

                            } else {
                              showBottomSheetDialog(
                                context: context,
                                content: const UnauthenticatedPlaceholder(),
                              );
                            }
                          },
                    icon: Icons.book,
                    buttonSize: ButtonSize.large,
                  ),
                ),
              ),
              horizontalSpace(8),
              Expanded(
                child: Obx(
                  () => AppButton.primary(
                    label: 'Unduh',
                    onPressed: controller.publication.value != null
                        ? () {
                            final user = controller.user.value;
                            if (user != null) {
                              controller.handleDownload(
                                url: controller.publication.value!.pdf,
                                fileName: controller.publication.value!.title,
                                extension: 'pdf',
                              );
                            } else {
                              showBottomSheetDialog(
                                context: context,
                                content: const UnauthenticatedPlaceholder(),
                              );
                            }
                          }
                        : null,
                    icon: Icons.download,
                    buttonSize: ButtonSize.large,
                    isBusy: controller.isDownloadProcessing.value,
                  ),
                ),
              )
            ],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Text('Detail Publikasi'),
              surfaceTintColor: theme.canvasColor,
              centerTitle: true,
              pinned: true,
              floating: true,
              expandedHeight: Get.height * 0.45,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: Obx(
                  () => _buildFlexibleHeaderContainer(theme),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const FaIcon(FontAwesomeIcons.share),
                )
              ],
            ),
            SliverToBoxAdapter(
              child: Container(
                constraints: BoxConstraints(
                  minHeight: Get.height * 0.5,
                ),
                padding: kPadding16,
                decoration: BoxDecoration(
                  color: theme.canvasColor,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: Obx(() => _buildPublicationDetailSection(theme)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPublicationDetailSection(ThemeData theme) {
    final textTheme = theme.textTheme;
    final failure = controller.failure.value;
    final isLoading = controller.isLoading.value;
    final publication = controller.publication.value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: SizedBox(
                width: Get.width * 0.3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Terakhir Diperbarui',
                      style: textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    verticalSpace(4),
                    Row(
                      children: [
                        const Icon(Icons.edit_calendar_rounded),
                        horizontalSpace(8),
                        Expanded(
                          child: _LastUpdateWidget(
                            failure: failure,
                            isLoading: isLoading,
                            publication: publication,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            horizontalSpace(8),
            SizedBox(
              height: 40,
              child: VerticalDivider(
                width: 1,
                thickness: 2,
                color: theme.dividerColor,
              ),
            ),
            horizontalSpace(8),
            Expanded(
              child: SizedBox(
                width: Get.width * 0.3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nomor Publikasi',
                      style: textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    verticalSpace(4),
                    Row(
                      children: [
                        const Icon(Icons.book_outlined),
                        horizontalSpace(8),
                        Expanded(
                          child: _PublicationNumberWidget(
                            failure: failure,
                            isLoading: isLoading,
                            publication: publication,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            horizontalSpace(8),
            SizedBox(
              height: 40,
              child: VerticalDivider(
                width: 1,
                thickness: 2,
                color: theme.dividerColor,
              ),
            ),
            horizontalSpace(8),
            Expanded(
              child: SizedBox(
                width: Get.width * 0.3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nomor Katalog',
                      style: textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    verticalSpace(4),
                    Row(
                      children: [
                        const Icon(Icons.file_present_outlined),
                        horizontalSpace(8),
                        Expanded(
                          child: _CatalogueNumberWidget(
                            failure: failure,
                            isLoading: isLoading,
                            publication: publication,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        const Divider(
          thickness: 1,
        ),
        Text(
          'Abstrak',
          style: textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        verticalSpace(16),
        _AbstractSectionWidget(
          failure: failure,
          isLoading: isLoading,
          publication: publication,
        ),
      ],
    );
  }

  Widget _buildFlexibleHeaderContainer(ThemeData theme) {
    final failure = controller.failure.value;
    final isLoading = controller.isLoading.value;
    final publication = controller.publication.value;
    final decoration = isLoading
        ? BoxDecoration(
            color: theme.disabledColor.withOpacity(0.1),
          )
        : BoxDecoration(
            image: DecorationImage(
              image: ExtendedNetworkImageProvider(
                controller.publication.value?.cover ?? '',
              ),
              fit: BoxFit.cover,
              opacity: 0.1,
            ),
          );

    return AnimatedContainer(
      padding: kPadding16,
      decoration: decoration,
      duration: 500.milliseconds,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          verticalSpace(32),
          DropShadow(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: _PublicationCoverWidget(
                isLoading: isLoading,
                failure: failure,
                publication: publication,
              ),
            ),
          ),
          verticalSpace(16),
          _PublicationTitleWidget(
            failure: failure,
            isLoading: isLoading,
            publication: publication,
          ),
          verticalSpace(8),
          _PublicationReleaseDateWidget(
            failure: failure,
            isLoading: isLoading,
            publication: publication,
          )
        ],
      ),
    );
  }
}

class _PublicationReleaseDateWidget extends StatelessWidget {
  const _PublicationReleaseDateWidget({
    required this.isLoading,
    this.failure,
    this.publication,
  });

  final bool isLoading;
  final Failure? failure;
  final Publication? publication;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    if (isLoading) {
      return ShimmerWidget(width: Get.width * 0.4, height: 10);
    }

    if (failure != null) {
      return const Text('-');
    }

    return Text(
      formatDate('dd MMMM yyyy', publication?.releaseDate),
      style: textTheme.caption,
      maxLines: 2,
      textAlign: TextAlign.center,
    );
  }
}

class _PublicationTitleWidget extends StatelessWidget {
  const _PublicationTitleWidget({
    required this.isLoading,
    this.failure,
    this.publication,
  });

  final bool isLoading;
  final Failure? failure;
  final Publication? publication;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    if (isLoading) {
      return ShimmerWidget(width: Get.width, height: 12);
    }

    if (failure != null) {
      return const Text('-');
    }

    return Text(
      publication?.title ?? '',
      style: textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
      ),
      maxLines: 2,
      textAlign: TextAlign.center,
    );
  }
}

class _PublicationCoverWidget extends StatelessWidget {
  const _PublicationCoverWidget({
    required this.isLoading,
    this.failure,
    this.publication,
  });

  final bool isLoading;
  final Failure? failure;
  final Publication? publication;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return ShimmerWidget(
        width: Get.width * 0.25,
        height: Get.height * 0.18,
      );
    }

    return Semantics(
      label: 'Cover ${publication?.title}',
      child: AppNetworkImage(
        url: publication?.cover ?? '',
        width: Get.width * 0.25,
        height: Get.height * 0.18,
      ),
    );
  }
}

class _CatalogueNumberWidget extends StatelessWidget {
  const _CatalogueNumberWidget({
    required this.isLoading,
    this.failure,
    this.publication,
  });

  final bool isLoading;
  final Failure? failure;
  final Publication? publication;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return ShimmerWidget(width: Get.width * 0.15, height: 10);
    }

    if (failure != null) {
      return const Text('-');
    }

    return FittedBox(
      child: Text(
        publication?.catalogueNumber ?? '',
      ),
    );
  }
}

class _LastUpdateWidget extends StatelessWidget {
  const _LastUpdateWidget({
    required this.isLoading,
    this.failure,
    this.publication,
  });

  final bool isLoading;
  final Failure? failure;
  final Publication? publication;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return ShimmerWidget(width: Get.width * 0.15, height: 10);
    }

    if (failure != null) {
      return const Text('-');
    }

    return FittedBox(
      child: Text(
        formatDate(
          'dd MMMM yyyy',
          publication?.updateDate,
          placeholder: 'Belum ada pembaruan',
        ),
      ),
    );
  }
}

class _PublicationNumberWidget extends StatelessWidget {
  const _PublicationNumberWidget({
    required this.isLoading,
    this.failure,
    this.publication,
  });

  final bool isLoading;
  final Failure? failure;
  final Publication? publication;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return ShimmerWidget(width: Get.width * 0.15, height: 10);
    }

    if (failure != null) {
      return const Text('-');
    }

    return FittedBox(
      child: Text(
        publication?.publicationNumber ?? '',
      ),
    );
  }
}

class _AbstractSectionWidget extends StatelessWidget {
  const _AbstractSectionWidget({
    required this.isLoading,
    this.failure,
    this.publication,
  });

  final bool isLoading;
  final Failure? failure;
  final Publication? publication;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    if (isLoading) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ShimmerWidget(width: Get.width * 0.8, height: 10),
          verticalSpace(8),
          ShimmerWidget(width: Get.width, height: 10),
          verticalSpace(8),
          ShimmerWidget(width: Get.width, height: 10),
          verticalSpace(8),
          ShimmerWidget(width: Get.width, height: 10),
          verticalSpace(8),
          ShimmerWidget(width: Get.width, height: 10),
          verticalSpace(8),
          ShimmerWidget(width: Get.width, height: 10),
          verticalSpace(8),
          ShimmerWidget(width: Get.width, height: 10),
          verticalSpace(8),
          ShimmerWidget(width: Get.width, height: 10),
          verticalSpace(8),
          ShimmerWidget(width: Get.width, height: 10),
          verticalSpace(8),
        ],
      );
    }

    if (failure != null) {
      return Column();
    }

    return HtmlWidget(
      publication?.abstract ?? '',
      textStyle: textTheme.bodySmall,
      isSelectable: true,
    );
  }
}

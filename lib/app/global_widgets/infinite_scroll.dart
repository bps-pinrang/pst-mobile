import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pst_online/app/core/enums/app_animation.dart';
import 'package:pst_online/app/core/enums/button_size.dart';
import 'package:pst_online/app/core/utils/view_helper.dart';
import 'package:pst_online/app/core/values/size.dart';
import 'package:pst_online/app/global_widgets/app_button.dart';
import 'package:pst_online/app/global_widgets/lottie_with_author.dart';

class InfiniteScroll extends StatelessWidget {
  const InfiniteScroll({
    super.key,
    required this.scrollController,
    required this.pagingController,
    required this.noItemDescription,
    required this.noItemTitle,
    required this.itemBuilder,
    this.emptyBuilder,
    this.firstProgressIndicatorBuilder,
    this.progressIndicatorBuilder,
    required this.showDivider,
  });

  final ScrollController scrollController;
  final PagingController pagingController;
  final String noItemDescription;
  final String noItemTitle;
  final Widget Function(BuildContext, Object?, int) itemBuilder;
  final Widget Function(BuildContext)? emptyBuilder;
  final Widget Function(BuildContext)? firstProgressIndicatorBuilder;
  final Widget Function(BuildContext)? progressIndicatorBuilder;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Scrollbar(
      trackVisibility: true,
      radius: const Radius.circular(4),
      thickness: 2,
      controller: scrollController,
      child: PagedListView.separated(
        pagingController: pagingController,
        scrollController: scrollController,
        builderDelegate: PagedChildBuilderDelegate(
          itemBuilder: itemBuilder,
          animateTransitions: true,
          transitionDuration: 700.milliseconds,
          noItemsFoundIndicatorBuilder: emptyBuilder ??
              (context) {
                return SizedBox(
                  height: Get.height * 0.84,
                  child: Center(
                    child: LottieWithAuthor(
                      title: noItemTitle,
                      message: noItemDescription,
                      animation: AppAnimation.notFound,
                      semanticLabel: noItemDescription,
                      height: Get.height * 0.4,
                    ),
                  ),
                );
              },
          firstPageErrorIndicatorBuilder: (_) {
            return SizedBox(
              height: Get.height * 0.84,
              child: Padding(
                padding: kPadding16,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LottieWithAuthor(
                      title: 'Kesalahan',
                      message: 'Terjadi kesalahan saat memuat data!',
                      animation: AppAnimation.warning,
                      semanticLabel: 'Terjadi kesalahan saat memuat data!',
                      height: Get.height * 0.2,
                    ),
                    verticalSpace(32),
                    Text(
                      pagingController.error.toString(),
                      style: textTheme.bodySmall,
                    ),
                    verticalSpace(32),
                    AppButton.primary(
                      buttonSize: ButtonSize.large,
                      onPressed: pagingController.refresh,
                      label: 'Coba Lagi',
                    )
                  ],
                ),
              ),
            );
          },
          firstPageProgressIndicatorBuilder: firstProgressIndicatorBuilder ??
              (_) {
                return SizedBox(
                  height: Get.height * 0.84,
                  child: SpinKitFadingCircle(
                    color: theme.colorScheme.primary,
                    size: 30,
                  ),
                );
              },
          newPageProgressIndicatorBuilder: progressIndicatorBuilder ??
              (_) {
                return Center(
                  child: Column(
                    children: [
                      SpinKitFadingCircle(
                        color: theme.colorScheme.primary,
                        size: 30,
                      ),
                      verticalSpace(8),
                      Text(
                        'Muat Lagi..',
                        style: textTheme.bodySmall,
                      ),
                      verticalSpace(8),
                    ],
                  ),
                );
              },
          newPageErrorIndicatorBuilder: (_) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const LottieWithAuthor(
                  title: 'Kesalahan!',
                  message: 'Kesalahan memuat data terbaru!',
                  animation: AppAnimation.warning,
                  semanticLabel: 'Kesalahan memuat data terbaru!',
                ),
                verticalSpace(8),
                Text(
                  pagingController.error.toString(),
                  style: textTheme.bodySmall,
                ),
                verticalSpace(16),
                AppButton.primary(
                  buttonSize: ButtonSize.large,
                  label: 'Coba Lagi',
                  onPressed: pagingController.refresh,
                )
              ],
            );
          },
        ),
        shrinkWrap: true,
        separatorBuilder: (_, __) => showDivider
            ? const Divider(
                height: 1,
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}

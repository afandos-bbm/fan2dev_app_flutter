
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fan2dev/features/about/cubit/about_cubit/about_cubit.dart';
import 'package:fan2dev/features/about/view/widgets/about_image_carrousel_widget.dart';
import 'package:fan2dev/l10n/l10n.dart';
import 'package:fan2dev/utils/utils.dart';
import 'package:fan2dev/utils/widgets/page_load_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AboutHomePage extends StatelessWidget {
  const AboutHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final aboutCubit = context.read<AboutCubit>();
    if (aboutCubit.state.status == AboutCubitStateStatus.initial ||
        aboutCubit.state.status == AboutCubitStateStatus.error) {
      aboutCubit.loadImages();
    }

    return const AboutHomePageView();
  }
}

class AboutHomePageView extends StatelessWidget {
  const AboutHomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AboutCubit, AboutCubitState>(
      builder: (context, state) {
        if (state.status == AboutCubitStateStatus.loading ||
            state.status == AboutCubitStateStatus.initial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.status == AboutCubitStateStatus.error) {
          return PageLoadErrorWidget(
            onRefresh: () => context.read<AboutCubit>().loadImages(),
            errorMessage: state.error.toString(),
          );
        }

        return SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: ResponsiveWidget.isMobile(context)
                    ? MediaQuery.of(context).size.width
                    : 520,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const SizedBox(width: 20),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: CircleAvatar(
                            radius: 50,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: CachedNetworkImage(
                                key: UniqueKey(),
                                imageUrl: state.aboutImages!.headerImageUrl!,
                                fit: BoxFit.cover,
                                height: 100,
                                errorWidget: (context, error, stackTrace) {
                                  l('Error: $stackTrace');
                                  return Image.asset(
                                    kLogoPath,
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${context.l10n.about_title} 👋',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                context.l10n.about_sort_description,
                                overflow: TextOverflow.visible,
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text(
                                  context.l10n.about_text_1,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                              const SizedBox(width: 10),
                              CachedNetworkImage(
                                key: UniqueKey(),
                                imageUrl:
                                    state.aboutImages!.flutterDashImageUrl!,
                                fit: BoxFit.cover,
                                height: 150,
                                errorWidget: (context, error, stackTrace) {
                                  return Image.asset(
                                    kLogoPath,
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ],
                          ),
                          Text(
                            context.l10n.about_text_2,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          AboutImageCarrouselWidget(
                            carouselImages:
                                state.aboutImages!.carrouselImagesUrls,
                          ),
                          Text(
                            context.l10n.about_text_3,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 70),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:edc_v2/core/di/get_it.dart';
import 'package:edc_v2/core/theme/app_colors.dart';
import 'package:edc_v2/core/ui/widgets/default_button.dart';
import 'package:edc_v2/core/utils/date_utils.dart';
import 'package:edc_v2/core/utils/int_utils.dart';
import 'package:edc_v2/core/utils/url_utils.dart';
import 'package:edc_v2/features/main/presentation/bloc/single_application_bloc.dart';
import 'package:edc_v2/features/main/domain/entity/application_entity.dart';
import 'package:edc_v2/features/main/presentation/bloc/single_application_event.dart';
import 'package:edc_v2/features/main/presentation/bloc/single_application_state.dart';
import 'package:edc_v2/features/main/presentation/page/payment_page.dart';
import 'package:edc_v2/features/main/presentation/page/donate_application_page.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:edc_v2/core/data/dummy_applications.dart';

class SingleApplicationPage extends StatefulWidget {
  final String applicationId;

  const SingleApplicationPage({super.key, required this.applicationId});

  static String path(String id) => '/application/$id';

  @override
  State<SingleApplicationPage> createState() => _SingleApplicationPageState();
}

class _SingleApplicationPageState extends State<SingleApplicationPage> {
  int currentImage = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SingleApplicationBloc>()
        ..add(GetSingleApplicationEvent(applicationId: widget.applicationId)),
      child: SafeArea(
        child: Scaffold(
          body: BlocBuilder<SingleApplicationBloc, SingleApplicationState>(
            builder: (context, state) {
              // allow falling back to local dummy data when backend isn't available
              ApplicationEntity? application;
              try {
                application =
                    state.applicationEntity ??
                    dummyApplications.firstWhere(
                      (e) => e.id == widget.applicationId,
                    );
              } catch (e) {
                application = state.applicationEntity;
              }

              if (state.status == SingleApplicationStatus.success ||
                  application != null) {
                return SizedBox.expand(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Positioned.fill(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  SizedBox(
                                    height: 300,
                                    child: PageView(
                                      children:
                                          application?.images.map((e) {
                                            if (e.startsWith('http') ||
                                                e.startsWith('https')) {
                                              return CachedNetworkImage(
                                                imageUrl: e,
                                                fit: BoxFit.cover,
                                              );
                                            }
                                            if (e.startsWith('assets/')) {
                                              return Image.asset(
                                                e,
                                                fit: BoxFit.cover,
                                              );
                                            }
                                            return CachedNetworkImage(
                                              imageUrl: UrlUtils.buildImageUrl(
                                                e,
                                              ),
                                              fit: BoxFit.cover,
                                            );
                                          }).toList() ??
                                          [],
                                      onPageChanged: (page) {
                                        setState(() {
                                          currentImage = page;
                                        });
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: IconButton(
                                      onPressed: () {
                                        context.pop();
                                      },
                                      icon: const Icon(CupertinoIcons.back),
                                      style: IconButton.styleFrom(
                                        backgroundColor: AppColors.surface,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              DotsIndicator(
                                dotsCount: application?.images.length ?? 0,
                                position: currentImage.toDouble(),
                              ),
                              const SizedBox(height: 12),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            '${application?.title}',
                                            style: Theme.of(
                                              context,
                                            ).textTheme.headlineMedium,
                                          ),
                                        ),
                                        const SizedBox(width: 20),

                                        Text(
                                          '${application?.donorCount} ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall
                                              ?.copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.text
                                                    .withOpacity(0.8),
                                              ),
                                        ),
                                        const SizedBox(width: 4),

                                        Row(
                                          children: [
                                            Icon(
                                              CupertinoIcons.person_2_fill,
                                              size: 25,
                                              color: AppColors.text.withOpacity(
                                                0.8,
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              'Donated',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                    color: AppColors.text
                                                        .withOpacity(0.8),
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 8),

                                    Text(
                                      '${application?.description}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.text.withOpacity(
                                              0.8,
                                            ),
                                          ),
                                    ),

                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Donations Collected: ₱ ${application?.collectedAmount?.formatNumber()}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                color: AppColors.text
                                                    .withOpacity(0.7),
                                              ),
                                        ),


                                      ],
                                    ),
                                    // Organization Details
                                const SizedBox(height: 24),
                                Text(
                                  'About the Organization',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                                const SizedBox(height: 16),
                                Builder(builder: (context) {
                                  final details =
                                      dummyApplicationDetails[application?.id];
                                  if (details == null) return Container();

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ListTile(
                                        leading: const Icon(Icons.flag,
                                            color: AppColors.primary),
                                        title: const Text('Mission'),
                                        subtitle:
                                            Text(details['mission'] as String),
                                      ),
                                      ListTile(
                                        leading: const Icon(Icons.people,
                                            color: AppColors.primary),
                                        title: const Text('Partner Organizations / Sponsors / Supporting Partners'),
                                        subtitle: Text(
                                            (details['members'] as List<String>)
                                                .join(', ')),
                                      ),
                                      ListTile(
                                        leading: const Icon(Icons.location_on,
                                            color: AppColors.primary),
                                        title: const Text('Main Office Address'),
                                        subtitle:
                                            Text(details['address'] as String),
                                      ),
                                      ListTile(
                                        leading: const Icon(Icons.language,
                                            color: AppColors.primary),
                                        title: const Text('Website'),
                                        subtitle:
                                            Text(details['website'] as String),
                                        onTap: () {
                                          // TODO: Implement URL launcher
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                'Opening ${details['website']}'),
                                          ));
                                        },
                                      ),
                                    ],
                                  );
                                }),
                                const SizedBox(height: 120),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '${application?.deadline.timeLeft()}',
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(
                                    color: AppColors.text.withOpacity(0.7),
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: DefaultButton(
                                    text: 'Donate Money',
                                    onPressed: () {
                                      context
                                          .push(
                                            PaymentPage.path(widget.applicationId),
                                          )
                                          .then((v) {
                                            context.read<SingleApplicationBloc>().add(
                                              GetSingleApplicationEvent(
                                                applicationId: widget.applicationId,
                                              ),
                                            );
                                          });
                                    },
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 12,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: DefaultButton(
                                    text: 'Donate Device',
                                    onPressed: () {
                                      context
                                          .push(
                                            DonateApplicationPage.path(widget.applicationId),
                                          )
                                          .then((v) {
                                            context.read<SingleApplicationBloc>().add(
                                              GetSingleApplicationEvent(
                                                applicationId: widget.applicationId,
                                              ),
                                            );
                                          });
                                    },
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator.adaptive());
            },
          ),
        ),
      ),
    );
  }
}

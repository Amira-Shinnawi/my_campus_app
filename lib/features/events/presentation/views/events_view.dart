import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../domain/entities/event_entity.dart';
import '../cubit/events_cubit.dart';
import '../cubit/events_state.dart';
import '../widgets/event_card.dart';

/// Main screen view displaying campus events list with category filtering.
class EventsView extends StatelessWidget {
  const EventsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EventsCubit>(
      create: (BuildContext context) => sl<EventsCubit>()..fetchEvents(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: const CustomAppBar(title: 'Campus Events'),
        body: BlocBuilder<EventsCubit, EventsState>(
          builder: (BuildContext context, EventsState state) {
            if (state is EventsLoading) {
              return const LoadingWidget();
            }

            if (state is EventsError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.p24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Icon(
                        Icons.error_outline_rounded,
                        color: AppColors.error,
                        size: AppSizes.iconXl,
                      ),
                      const SizedBox(height: AppSizes.p16),
                      Text(
                        state.message,
                        style: AppTextStyles.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppSizes.p24),
                      CustomButton(
                        text: 'Retry',
                        onPressed: () {
                          context.read<EventsCubit>().fetchEvents();
                        },
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state is EventsLoaded) {
              if (state.allEvents.isEmpty) {
                return const EmptyStateWidget(
                  title: 'No Events Scheduled',
                  message: 'Check back later for university workshops and activities.',
                  icon: Icons.event_busy_outlined,
                );
              }

              final List<EventEntity> currentEvents = state.sortedEvents;
              final List<String> categories = state.availableCategories;

              return Column(
                children: <Widget>[
                  const SizedBox(height: AppSizes.p12),

                  // Categories Filter Row
                  SizedBox(
                    height: 40.0,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.p16,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: AppSizes.p8),
                      itemBuilder: (context, index) {
                        final String category = categories[index];
                        final bool isSelected =
                            (state.categoryFilter == null &&
                                    category.toLowerCase() == 'all') ||
                                (state.categoryFilter != null &&
                                    state.categoryFilter!.toLowerCase() ==
                                        category.toLowerCase());

                        return FilterChip(
                          selected: isSelected,
                          label: Text(
                            category,
                            style: AppTextStyles.caption.copyWith(
                              color: isSelected
                                  ? AppColors.surface
                                  : AppColors.textPrimary,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                          selectedColor: AppColors.primary,
                          backgroundColor: AppColors.surface,
                          onSelected: (bool selected) {
                            context
                                .read<EventsCubit>()
                                .selectCategory(category);
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: AppSizes.p12),

                  // Events List View
                  Expanded(
                    child: currentEvents.isEmpty
                        ? const EmptyStateWidget(
                            title: 'No Events in Category',
                            message: 'No upcoming campus events for this category.',
                            icon: Icons.event_available_outlined,
                          )
                        : RefreshIndicator(
                            color: AppColors.primary,
                            onRefresh: () async {
                              await context
                                  .read<EventsCubit>()
                                  .fetchEvents();
                            },
                            child: ListView.builder(
                              padding: const EdgeInsets.all(AppSizes.p16),
                              itemCount: currentEvents.length,
                              itemBuilder: (BuildContext context, int index) {
                                final EventEntity event = currentEvents[index];
                                return EventCard(
                                  event: event,
                                  onTap: () {
                                    context.push(
                                      '/events/details',
                                      extra: event,
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

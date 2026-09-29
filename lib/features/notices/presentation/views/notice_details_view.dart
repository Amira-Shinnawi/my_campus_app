import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../domain/entities/notice_entity.dart';
import '../widgets/notice_category_badge.dart';

/// Screen view displaying full details of a selected notice entity.
class NoticeDetailsView extends StatelessWidget {
  /// Notice entity passed from navigation.
  final NoticeEntity notice;

  const NoticeDetailsView({
    super.key,
    required this.notice,
  });

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} at ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: 'Notice Details',
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.p20),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSizes.r24),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 12.0,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(AppSizes.p20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  NoticeCategoryBadge(category: notice.category),
                  if (notice.isImportant)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.p8,
                        vertical: AppSizes.p4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        borderRadius: BorderRadius.circular(AppSizes.r12),
                      ),
                      child: const Text(
                        'IMPORTANT',
                        style: TextStyle(
                          color: AppColors.surface,
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: AppSizes.p16),
              Text(
                notice.title,
                style: AppTextStyles.headlineMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: AppSizes.p12),
              Row(
                children: <Widget>[
                  const Icon(
                    Icons.access_time_rounded,
                    size: AppSizes.iconSm,
                    color: AppColors.textMuted,
                  ),
                  const SizedBox(width: AppSizes.p4),
                  Text(
                    'Posted on ${_formatDate(notice.date)}',
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: AppSizes.p16),
                child: Divider(color: AppColors.border),
              ),
              Text(
                notice.description,
                style: AppTextStyles.bodyLarge.copyWith(
                  height: 1.6,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

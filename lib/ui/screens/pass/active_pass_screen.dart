import 'package:bike_rental_app/ui/screens/pass/widgets/active_pass.dart';
import 'package:bike_rental_app/ui/screens/pass/view_model/pass_view_model.dart';
import 'package:bike_rental_app/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:bike_rental_app/ui/widgets/button.dart';
import 'package:provider/provider.dart';

class ActivePassScreen extends StatelessWidget {
  const ActivePassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool hasActivePass = context.select<PassViewModel, bool>(
      (viewModel) => viewModel.activePass != null,
    );

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        shape: const Border(
          bottom: BorderSide(color: AppColors.outlineVariant),
        ),
        title: const Text(
          'My Pass',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: AppColors.onSurface,
          ),
        ),
      ),
      body: const SafeArea(child: ActivePassView()),
      bottomNavigationBar: hasActivePass
          ? Container(
              padding: const EdgeInsets.fromLTRB(
                AppTextStyles.spaceXS,
                AppTextStyles.spaceS,
                AppTextStyles.spaceXS,
                AppTextStyles.spaceS,
              ),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                border: Border(
                  top: BorderSide(color: AppColors.outlineVariant),
                ),
              ),
              child: SafeArea(
                top: false,
                child: PrimaryButton(
                  text: 'Cancel Current Pass',
                  callback: () async {
                    final bool cancelled = await context
                        .read<PassViewModel>()
                        .cancelActivePass();

                    if (!cancelled && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Failed to cancel active pass.'),
                        ),
                      );
                    }
                  },
                  backgroundColor: AppColors.primary,
                ),
              ),
            )
          : null,
    );
  }
}

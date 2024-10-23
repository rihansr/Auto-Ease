import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/config/app_settings.dart';
import '../../../core/routing/routes.dart';
import '../../../core/shared/dimens.dart';
import '../../../core/shared/enums.dart';
import '../../../core/shared/strings.dart';
import '../../../core/shared/utils.dart';
import '../../../core/widget/base_widget.dart';
import '../viewmodel/account_viewmodel.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          centerTitle: false,
          title: Text(string.of(context).settings),
          toolbarHeight: dimen.toolBarHeight,
          titleTextStyle: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          pinned: true,
        ),
        const SliverList(
          delegate: SliverChildListDelegate.fixed([
            _UserInformationSection(
              key: ValueKey('user_info_section'),
            ),
            _LanguageSection(
              key: ValueKey('language_section'),
            ),
            _ThemeSection(
              key: ValueKey('theme_section'),
            ),
            _LogoutSection(
              key: ValueKey('logout_section'),
            ),
          ]),
        ),
      ],
    );
  }
}

class _UserInformationSection extends StatelessWidget {
  const _UserInformationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BaseWidget<AccountViewModel>(
      model: Provider.of<AccountViewModel>(context),
      builder: (context, controller, child) {
        return CupertinoFormSection.insetGrouped(
          backgroundColor: Colors.transparent,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(12),
            color: theme.cardColor,
          ),
          children: [
            ListTile(
              onTap: () => context.pushNamed(Routes.update),
              leading: CircleAvatar(
                backgroundColor: theme.colorScheme.primary,
                child: Text(
                  controller.user?.name?.first ?? '',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              ),
              title: Text(
                controller.user?.name ?? string.of(context).annonymous,
              ),
              subtitle: Text(
                controller.user?.email ?? '',
              ),
            )
          ],
        );
      },
    );
  }
}

class _LanguageSection extends StatelessWidget {
  const _LanguageSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CupertinoFormSection.insetGrouped(
      backgroundColor: Colors.transparent,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(12),
        color: theme.cardColor,
      ),
      header: Text(string.of(context).language),
      children: Language.values
          .map(
            (language) => RadioListTile(
              key: ValueKey(language.name),
              title:
                  Text(language.displayName, style: theme.textTheme.titleSmall),
              value: language,
              groupValue: appSettings.language,
              contentPadding: const EdgeInsets.symmetric(horizontal: 4),
              activeColor: theme.colorScheme.primary,
              onChanged: (_) => appSettings.language = language,
            ),
          )
          .toList(),
    );
  }
}

class _ThemeSection extends StatelessWidget {
  const _ThemeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CupertinoFormSection.insetGrouped(
      backgroundColor: Colors.transparent,
      header: Text(string.of(context).thememode),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(12),
        color: theme.cardColor,
      ),
      children: ThemeMode.values
          .map(
            (mode) => RadioListTile(
              key: ValueKey(mode.name),
              title:
                  Text(mode.name.capitalize, style: theme.textTheme.titleSmall),
              value: mode,
              groupValue: appSettings.theme,
              contentPadding: const EdgeInsets.symmetric(horizontal: 4),
              activeColor: theme.colorScheme.primary,
              onChanged: (_) => appSettings.theme = mode,
            ),
          )
          .toList(),
    );
  }
}

class _LogoutSection extends StatelessWidget {
  const _LogoutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = context.read<AccountViewModel>();
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
      child: TextButton(
        onPressed: controller.logout,
        child: Text(
          string.of(context).logout,
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.tertiary,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../auth/model/user_model.dart';
import '../../../core/shared/utils.dart';

class UserSuggessionItem extends StatelessWidget {
  final User user;
  const UserSuggessionItem({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      dense: true,
      leading: CircleAvatar(
        backgroundColor: theme.colorScheme.onPrimary,
        child: Text(
          user.name?.first ?? '',
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.primary,
          ),
        ),
      ),
      title: Text(
        user.name ?? "",
        style: TextStyle(color: theme.colorScheme.onPrimary),
      ),
      subtitle: Text(
        user.email ?? "",
        style: TextStyle(color: theme.colorScheme.onPrimary),
      ),
    );
  }
}

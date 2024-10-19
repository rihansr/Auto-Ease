import 'dart:ui';

enum AlertType { success, error, info }

enum Role { admin, mechanic, customer }

enum BookingStatus { pending, accepted, completed, cancelled }

enum Language {
  english,
  newZealand;

  String get displayName {
    switch (this) {
      case Language.newZealand:
        return 'New Zealand';
      default:
        return 'English';
    }
  }

  Locale get locale {
    switch (this) {
      case Language.newZealand:
        return const Locale('en', 'NZ');
      default:
        return const Locale('en', 'US');
    }
  }
}

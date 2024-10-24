final drawable = _Drawable.value;

class _Drawable {
  static _Drawable get value => _Drawable._();
  _Drawable._();

  /// Splash
  final splashLogo = 'assets/icons/ic_logo.svg';
  final blurryBackdrop = 'assets/images/blurry_backdrop.png';

  /// Other
  final loading = 'assets/animations/loading.json';
  final empty = 'assets/animations/empty.json';
  final receiptLogo = 'assets/images/receipt_logo.png';
}

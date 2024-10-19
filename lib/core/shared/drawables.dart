final drawable = _Drawable.value;

class _Drawable {
  static _Drawable get value => _Drawable._();
  _Drawable._();

  /// Splash
  final splashLogo = 'assets/icons/ic_logo.svg';
  final blurryBackdrop = 'assets/images/ic_blurry_backdrop.png';

  /// Other
  String placeholder([String? text]) => text == null
      ? ""
      : "https://via.placeholder.com/150/e6ebf3/b0c1db/?text=$text";
}

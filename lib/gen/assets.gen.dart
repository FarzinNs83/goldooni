// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsPngGen {
  const $AssetsPngGen();

  /// File path: assets/png/blog.png
  AssetGenImage get blog => const AssetGenImage('assets/png/blog.png');

  /// File path: assets/png/empty.png
  AssetGenImage get empty => const AssetGenImage('assets/png/empty.png');

  /// File path: assets/png/gol-car.png
  AssetGenImage get golCar => const AssetGenImage('assets/png/gol-car.png');

  /// File path: assets/png/gol.png
  AssetGenImage get gol => const AssetGenImage('assets/png/gol.png');

  /// File path: assets/png/test.png
  AssetGenImage get test => const AssetGenImage('assets/png/test.png');

  /// List of all assets
  List<AssetGenImage> get values => [blog, empty, golCar, gol, test];
}

class $AssetsSvgGen {
  const $AssetsSvgGen();

  /// File path: assets/svg/add-circle.svg
  String get addCircle => 'assets/svg/add-circle.svg';

  /// File path: assets/svg/arrow-left.svg
  String get arrowLeft => 'assets/svg/arrow-left.svg';

  /// File path: assets/svg/arrow-right.svg
  String get arrowRight => 'assets/svg/arrow-right.svg';

  /// File path: assets/svg/call-calling.svg
  String get callCalling => 'assets/svg/call-calling.svg';

  /// File path: assets/svg/category.svg
  String get category => 'assets/svg/category.svg';

  /// File path: assets/svg/cil_list-rich.svg
  String get cilListRich => 'assets/svg/cil_list-rich.svg';

  /// File path: assets/svg/discount.svg
  String get discount => 'assets/svg/discount.svg';

  /// File path: assets/svg/dislike.svg
  String get dislike => 'assets/svg/dislike.svg';

  /// File path: assets/svg/edit.svg
  String get edit => 'assets/svg/edit.svg';

  /// File path: assets/svg/empty.svg
  String get empty => 'assets/svg/empty.svg';

  /// File path: assets/svg/home.svg
  String get home => 'assets/svg/home.svg';

  /// File path: assets/svg/iconamoon_notification-light.svg
  String get iconamoonNotificationLight =>
      'assets/svg/iconamoon_notification-light.svg';

  /// File path: assets/svg/iconsax-location.svg
  String get iconsaxLocation => 'assets/svg/iconsax-location.svg';

  /// File path: assets/svg/like.svg
  String get like => 'assets/svg/like.svg';

  /// File path: assets/svg/location.svg
  String get location => 'assets/svg/location.svg';

  /// File path: assets/svg/lock.svg
  String get lock => 'assets/svg/lock.svg';

  /// File path: assets/svg/logo-mini.svg
  String get logoMini => 'assets/svg/logo-mini.svg';

  /// File path: assets/svg/logo.svg
  String get logo => 'assets/svg/logo.svg';

  /// File path: assets/svg/logo_sec.svg
  String get logoSec => 'assets/svg/logo_sec.svg';

  /// File path: assets/svg/message-question.svg
  String get messageQuestion => 'assets/svg/message-question.svg';

  /// File path: assets/svg/minus-cirlce.svg
  String get minusCirlce => 'assets/svg/minus-cirlce.svg';

  /// File path: assets/svg/mynaui_heart.svg
  String get mynauiHeart => 'assets/svg/mynaui_heart.svg';

  /// File path: assets/svg/search.svg
  String get search => 'assets/svg/search.svg';

  /// File path: assets/svg/shopping-cart.svg
  String get shoppingCart => 'assets/svg/shopping-cart.svg';

  /// File path: assets/svg/solar_share-outline.svg
  String get solarShareOutline => 'assets/svg/solar_share-outline.svg';

  /// File path: assets/svg/status-delivered.svg
  String get statusDelivered => 'assets/svg/status-delivered.svg';

  /// File path: assets/svg/status-processing.svg
  String get statusProcessing => 'assets/svg/status-processing.svg';

  /// File path: assets/svg/status-returned.svg
  String get statusReturned => 'assets/svg/status-returned.svg';

  /// File path: assets/svg/tooman.svg
  String get tooman => 'assets/svg/tooman.svg';

  /// File path: assets/svg/trash.svg
  String get trash => 'assets/svg/trash.svg';

  /// File path: assets/svg/user.svg
  String get user => 'assets/svg/user.svg';

  /// File path: assets/svg/user1.svg
  String get user1 => 'assets/svg/user1.svg';

  /// List of all assets
  List<String> get values => [
    addCircle,
    arrowLeft,
    arrowRight,
    callCalling,
    category,
    cilListRich,
    discount,
    dislike,
    edit,
    empty,
    home,
    iconamoonNotificationLight,
    iconsaxLocation,
    like,
    location,
    lock,
    logoMini,
    logo,
    logoSec,
    messageQuestion,
    minusCirlce,
    mynauiHeart,
    search,
    shoppingCart,
    solarShareOutline,
    statusDelivered,
    statusProcessing,
    statusReturned,
    tooman,
    trash,
    user,
    user1,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsPngGen png = $AssetsPngGen();
  static const $AssetsSvgGen svg = $AssetsSvgGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}

library images;

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../enums/app_enum.dart';

part 'widgets/svg_image.dart';
part 'widgets/backdrop_blur.dart';
part 'widgets/show_image.dart';

class ImageAssets{
  final String suffix;
  final AssetEnum asset;
  final TypeFileEnum type;

  const ImageAssets(this.suffix, {required this.asset, required  this.type});
  String get patch => "${asset.patch}$suffix.${type.name}";
}

class Images {
  Images._();
  //clear sky
  static const ImageAssets bg = ImageAssets("bg",
      asset: AssetEnum.pictures, type: TypeFileEnum.jpg);
  static const ImageAssets whatsapp = ImageAssets("whatsapp",
      asset: AssetEnum.icons, type: TypeFileEnum.png);
}
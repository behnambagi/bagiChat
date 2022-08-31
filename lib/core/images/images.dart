library images;

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../enums/app_enum.dart';

part 'widgets/backdrop_blur.dart';
part 'widgets/show_image.dart';
part 'widgets/video_player_widget.dart';

class MediaAssets{
  final String suffix;
  final AssetEnum asset;
  final TypeFileEnum type;

  const MediaAssets(this.suffix, {required this.asset, required  this.type});
  String get patch => "${asset.patch}$suffix.${type.name}";
}

class Images {
  Images._();
  static const MediaAssets bg = MediaAssets("bg",
      asset: AssetEnum.pictures, type: TypeFileEnum.jpg);
  static const MediaAssets whatsapp = MediaAssets("whatsapp",
      asset: AssetEnum.icons, type: TypeFileEnum.png);
}
class Videos {
  Videos._();
  static const MediaAssets screen = MediaAssets("screen",
      asset: AssetEnum.videos, type: TypeFileEnum.webm);
}
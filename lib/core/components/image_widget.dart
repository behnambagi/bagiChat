import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../utils/utils.dart';

class MBSvg extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final Color? color;
  final int? asset;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const MBSvg(this.url,
      {Key? key,
        this.width,
        this.height,
        this.color,
        this.asset,
        this.padding,
        this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> assets = [
      VECTORS_ASSET,
      PICTURES_ASSET,
      ICONS_ASSET,
      DEVICE_ASSET
    ];
    return Container(
      padding: padding,
      margin: margin,
      width: width,
      height: height,
      color: Colors.transparent,
      child: SvgPicture.asset(
        asset != null ? "${assets[asset!]}$url.svg": "$VECTORS_ASSET$url.svg", color: color,),
    );
  }
}

class NotFound extends StatelessWidget {
  const NotFound({Key? key, this.padding, this.margin, this.report, this.width, this.height}) : super(key: key);
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final bool? report;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MBSvg((report!=null&&report!)?"not_found_report":"notFound", width: (report!=null&&report!)?300:250, height: height??((report!=null&&report!)?300:250),padding: padding,margin: margin,),
        Text("No data found".tr, style: const TextStyle(fontSize: 18)),
      ],
    );
  }
}


class MBPng extends StatelessWidget {
  const MBPng(this.url, {Key? key, this.width, this.height, this.asset,
    this.padding, this.margin, this.color, this.colorBlendMode, this.fit}) : super(key: key);

  final String url;
  final double? width;
  final double? height;
  final Color? color;
  final int? asset;
  final BoxFit? fit;
  final BlendMode? colorBlendMode;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    List<String> assets = [
      VECTORS_ASSET,
      PICTURES_ASSET,
      ICONS_ASSET,
      DEVICE_ASSET,
      HOME_ASSET,
      PROFILE_ASSET
    ];
    return Container(
      padding: padding,
      margin: margin,
      width: width,
      height: height ,
      child: Image.asset( asset != null ? "${assets[asset!]}$url.png":
      "$PICTURES_ASSET$url.png", color:color,colorBlendMode: colorBlendMode,fit: fit),
    );
  }
}

class MBJpeg extends StatelessWidget {
  const MBJpeg(this.url, {Key? key, this.width, this.height,
    this.asset, this.padding, this.margin}) : super(key: key);

  final String url;
  final double? width;
  final double? height;
  final int? asset;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    List<String> assets = [
      VECTORS_ASSET,
      PICTURES_ASSET,
      ICONS_ASSET,
      DEVICE_ASSET,
      HOME_ASSET
    ];
    return Container(
      padding: padding,
      margin: margin,
      width: width,
      height: height,
      child: Image.asset( asset != null ? "${assets[asset!]}$url.jpeg": "$PICTURES_ASSET$url.jpeg"),
    );
  }
}
class MBJpg extends StatelessWidget {
  const MBJpg(this.url, {Key? key, this.width, this.height,
    this.asset, this.padding, this.margin, this.boxFit}) : super(key: key);

  final String url;
  final double? width;
  final double? height;
  final BoxFit? boxFit;
  final int? asset;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    List<String> assets = [
      VECTORS_ASSET,
      PICTURES_ASSET,
      ICONS_ASSET,
      DEVICE_ASSET,
      HOME_ASSET
    ];
    return Container(
      padding: padding,
      margin: margin,
      width: width,
      height: height,
      child: Image.asset( asset != null ? "${assets[asset!]}$url.jpg":
      "$PICTURES_ASSET$url.jpg", fit: boxFit,),
    );
  }
}


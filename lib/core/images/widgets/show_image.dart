part of images;

class ShowMedia extends StatelessWidget {
  const ShowMedia(this.image, {Key? key, this.width, this.height,
    this.padding, this.margin, this.color,
    this.colorBlendMode, this.boxShadow, this.fit}) : super(key: key);

  final MediaAssets image;
  final double? width;
  final double? height;
  final Color? color;
  final  List<BoxShadow>? boxShadow;
  final BlendMode? colorBlendMode;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding, margin: margin,
      width: width, height: height,
      decoration: BoxDecoration(
        color: Colors.transparent,
        boxShadow: boxShadow
      ),
      child: image.type==TypeFileEnum.svg?
      SvgPicture.asset(image.patch, color: color, fit: fit??BoxFit.contain,
        colorBlendMode: colorBlendMode??BlendMode.srcIn )
          :Image.asset(image.patch,
          color:color,colorBlendMode: colorBlendMode, fit: fit),
    );
  }
}

class ImageBlur extends StatelessWidget {
  const ImageBlur(this.image, {Key? key, required this.type, this.width, this.height,
    this.padding, this.margin, this.color, this.colorBlendMode, this.boxShadow}) : super(key: key);

  final MediaAssets image;
  final TypeFileEnum type;
  final double? width;
  final double? height;
  final Color? color;
  final  List<BoxShadow>? boxShadow;
  final BlendMode? colorBlendMode;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding, margin: margin,
      width: width, height: height,
      decoration: BoxDecoration(
          backgroundBlendMode: colorBlendMode,
          boxShadow: boxShadow,
          image: DecorationImage(image: AssetImage("${image.patch}.${type.name}"), )
      ),
      child:  BackdropFilter(
        blendMode: BlendMode.darken,
        filter: ImageFilter.blur(sigmaX: 44.0, sigmaY: 44.0),
        child: Container(
          width: width==null?null:width!-40,
          height: height==null?null:height!-40,
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
          child: Image.asset("${image.patch}.${type.name}",
              color:color,colorBlendMode: colorBlendMode,),
        ),
      ),
    );
  }
}

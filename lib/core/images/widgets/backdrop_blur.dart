part of images;


class BackdropBlur extends StatelessWidget {
  const BackdropBlur({Key? key, required this.children, required this.image}) : super(key: key);

  final List<Widget> children;
  final ImageAssets image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        image: DecorationImage(image: AssetImage(
            image.patch), fit: BoxFit.fill),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: children,
        ),

      ),
    );
  }
}

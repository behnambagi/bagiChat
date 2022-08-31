part of images;

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget(
      {Key? key, required this.media, required this.change, bool? isLooping})
      : isLooping = isLooping ?? false,
        super(key: key);
  final bool isLooping;
  final MediaAssets media;
  final Function(VideoPlayerController controller) change;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.media.patch)
      ..initialize().then((_) {
        setState(() {});
        _controller.setLooping(widget.isLooping);
      });
  }

  @override
  Widget build(BuildContext context) {
    widget.change(_controller);
    return Stack(
      children: [
        SizedBox.expand(
          child: Container(
            color: Colors.green,
            child: FittedBox(
              fit: BoxFit.fill,
              child: SizedBox(
                width: _controller.value.size.width,
                height:_controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
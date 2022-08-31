library slider;
import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../enums/app_enum.dart';
import '../../images/images.dart';

part 'slide_model.dart';


class SliderWidget extends StatefulWidget {
  const SliderWidget({Key? key, required this.sliders, bool? autoPlay})
      : autoPlay = autoPlay ?? false,
        super(key: key);
  final SlideTypeList sliders;
  final bool autoPlay;

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> with SingleTickerProviderStateMixin {
  int indexPage = 0;
  bool b = false;

  late AnimationController animateControllerTitle;
  @override
  initState(){
    animateControllerTitle = AnimationController(vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
            itemCount: widget.sliders.length,
            itemBuilder: (BuildContext context, int index, i) {
              var slider = widget.sliders[index];
              if (slider.assets.type == TypeFileEnum.webm ||
                  slider.assets.type == TypeFileEnum.mp4) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.red,
                    height: 500,
                    width: 350,
                    child: VideoPlayerWidget(
                        change: (controller) {
                          if (indexPage == index) controller.play();
                          if (controller.value.isPlaying &&
                              indexPage != index) controller.pause();
                        },
                        media: Videos.screen,
                        isLooping: true),
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    height: 500,
                    width: 350,
                    color: Colors.black,
                    child: ShowMedia(
                      slider.assets,
                      width: 350,
                      fit: BoxFit.fill,
                    )),
              );
            },
            options: CarouselOptions(
                height: 450,
                aspectRatio: 16 / 9,
                viewportFraction: 0.6,
                padEnds: true,
                initialPage: 0,
                enableInfiniteScroll: false,
                reverse: false,
                autoPlay: widget.autoPlay,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: false,
                onPageChanged: (i, c) => {
                  setState(() => indexPage = i),
                  animateControllerTitle.reset()
            },
                scrollDirection: Axis.horizontal
            )),
        FadeInUp(
          from: 10,
        manualTrigger: true,
        controller: (c)=>animateControllerTitle = c,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.sliders[indexPage].name),
            Text(widget.sliders[indexPage].description),
          ],
        )),

      ],
    );
  }
}
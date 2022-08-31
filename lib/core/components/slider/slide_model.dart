part of slider;
typedef SlideTypeList = List<SlideModel>;

class SlideModel {
  final String name;
  final String description;
  final MediaAssets assets;

  SlideModel(
      {required this.assets, required this.name, required this.description});
}
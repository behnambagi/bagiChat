part of app_enum;

enum AssetEnum { assets,images, vectors, icons, pictures, fonts }

extension AssetExtension on AssetEnum{
  String get patch {
    switch(this){
      case AssetEnum.assets :return "assets/";
      case AssetEnum.fonts :return "assets/fonts/";
      case AssetEnum.images :return "assets/images/";
      case AssetEnum.vectors :return "assets/images/vectors/";
      case AssetEnum.icons :return "assets/images/icons/";
      case AssetEnum.pictures :return "assets/images/pictures/";
    }
  }
}
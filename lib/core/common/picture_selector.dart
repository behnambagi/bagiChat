import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

class PictureSelector{
  ImagePicker picker = ImagePicker();

  Future<Uint8List?> _selectPicture(ImageSource type)async{
    var file = await picker.pickImage(source: type);
    if(file==null) return null;
    return await file.readAsBytes();
  }
  Future<Uint8List?> fromCamera()async{
    return _selectPicture(ImageSource.camera);
  }
  Future<Uint8List?> fromGallery()async{
    return _selectPicture(ImageSource.gallery);
  }
}
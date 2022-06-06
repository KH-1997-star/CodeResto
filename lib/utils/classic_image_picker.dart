// this file require to add "image_picker: ^0.8.5"

import 'package:image_picker/image_picker.dart';

class ClassicImagePicker {
  final ImagePicker _picker = ImagePicker();

  Future pickImageFromGallery(ImageSource source) async {
    XFile? file = await _picker.pickImage(source: source);
    return file;
  }
}

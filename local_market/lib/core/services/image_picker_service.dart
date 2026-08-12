import 'package:image_picker/image_picker.dart';

abstract class ImagePickerService {
  Future<String?> takeCameraPhoto();
  Future<String?> pickGalleryImage();
}

class AppImagePickerService implements ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  @override
  Future<String?> takeCameraPhoto() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      return image?.path;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<String?> pickGalleryImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      return image?.path;
    } catch (e) {
      return null;
    }
  }
}

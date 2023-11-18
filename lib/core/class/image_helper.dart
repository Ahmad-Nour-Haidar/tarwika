import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

abstract class ImageHelper {
  static final ImagePicker _imagePicker = ImagePicker();
  static final ImageCropper _imageCropper = ImageCropper();

  static Future<XFile?> pickImage({
    ImageSource source = ImageSource.gallery,
    int imageQuality = 100,
  }) async {
    return await _imagePicker.pickImage(
      source: source,
      imageQuality: imageQuality,
    );
  }

  static Future<CroppedFile?> cropImage({
    required XFile file,
    CropStyle style = CropStyle.circle,
  }) async {
    return await _imageCropper.cropImage(
      sourcePath: file.path,
      compressQuality: 100,
      cropStyle: style,
      uiSettings: [
        AndroidUiSettings(),
        WebUiSettings(context: Get.context!),
      ],
    );
  }
}

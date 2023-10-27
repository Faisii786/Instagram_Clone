import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker imgpicker = ImagePicker();

  XFile? file = await imgpicker.pickImage(source: source);
  if (file != null) {
    return await file.readAsBytes();
  }
  // ignore: avoid_print
  print("No image selected");
}

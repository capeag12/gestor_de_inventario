import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:gestor_de_inventario/Models/serviceLogin.dart';
import 'package:image_picker/image_picker.dart';

class UserPageVM {
  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  ServiceLogin serviceLogin = ServiceLogin.getInstance();

  UserPageVM() {}

  Future<XFile?> getImage() async {
    if (Platform.isAndroid) {
      _image = await _picker.pickImage(source: ImageSource.gallery);
    } else if (Platform.isWindows) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowedExtensions: ['jpg', 'png'],
      );

      if (result != null) {
        _image = XFile(result.files.single.path!);
      } else {}
    }
    return _image;
  }

  Future<bool> uploadImage() async {
    if (_image != null) {
      bool resultado = await serviceLogin.cambiarAvatar(_image!.path);
      return resultado;
    }
    return false;
  }

  XFile? get image => _image;
}

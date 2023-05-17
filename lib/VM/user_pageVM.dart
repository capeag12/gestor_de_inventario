import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:gestor_de_inventario/Models/serviceLogin.dart';
import 'package:image_picker/image_picker.dart';

class UserPageVM {
  bool changedImg = false;
  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  ServiceLogin serviceLogin = ServiceLogin.getInstance();

  UserPageVM() {}

  Future<XFile?> getImage() async {
    if (Platform.isAndroid) {
      _image = await _picker.pickImage(source: ImageSource.gallery);

      if (_image != null) {
        changedImg = true;
      }
    } else if (Platform.isWindows) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: ['jpg', 'png'],
      );
      if (result != null) {
        changedImg = true;
        _image = XFile(result.files.single.path!);
      }
    }
    return _image;
  }

  Future<bool> uploadImage() async {
    if (_image != null) {
      bool resultado = await serviceLogin.cambiarAvatar(_image!.path);
      changedImg = false;
      return resultado;
    }
    return false;
  }

  Future<bool> logoutAll() async {
    bool resultado = await serviceLogin.logoutAll();
    return resultado;
  }

  XFile? get image => _image;

  set image(XFile? value) {
    _image = value;
  }
}

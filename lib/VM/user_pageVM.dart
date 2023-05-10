import 'package:gestor_de_inventario/Models/serviceLogin.dart';
import 'package:image_picker/image_picker.dart';

class UserPageVM {
  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  ServiceLogin serviceLogin = ServiceLogin.getInstance();

  UserPageVM() {}

  Future<XFile?> getImage() async {
    _image = await _picker.pickImage(source: ImageSource.gallery);
    return _image;
  }

  Future<void> uploadImage() async {
    if (_image != null) {
      await serviceLogin.cambiarAvatar(_image!);
    }
  }

  XFile? get image => _image;
}

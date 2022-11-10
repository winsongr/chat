import 'package:chat/app/utils/exports.dart';

class Box {
  GetStorage box = GetStorage();
  boxWrite(value) async {
    await box.write("uid", value);
  }

  boxRemove() async {
    await box.write('uid', null);
  }

  boxread() {
    var boxread = box.read('uid');
    return boxread;
  }
}

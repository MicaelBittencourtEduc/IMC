import 'package:imc/app/core/interfaces/shared_preferences_interface.dart';
import 'package:imc/app/core/local_storage/local_storage.dart';

class SharedRepository implements ISharedRepositoryInterface {
  static const String data = 'listIMC';

  @override
  Future<List> readData() async {
    return await LocalStorage.getValue<List>(data).then((value) {
      return value;
    });
  }

  @override
  Future<bool> saveData(List value) async {
    print('+$value+');
    return await LocalStorage.setValue<List<String>>(data, value);
  }
}

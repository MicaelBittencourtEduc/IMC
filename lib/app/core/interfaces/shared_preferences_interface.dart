abstract class ISharedRepositoryInterface {
  Future<List> readData();
  Future<bool> saveData(List value);
}

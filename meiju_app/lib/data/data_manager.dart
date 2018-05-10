import 'package:meiju_app/data/source/data_repository.dart';
import 'package:meiju_app/data/source/data_repository_impl.dart';

class DataManager {
  static final DataManager _singleton = new DataManager._internal();
  factory DataManager() {
    return _singleton;
  }

  DataManager._internal();

  DataRepository get dataRepository {
    return DataRepositoryImpl();
  }
}

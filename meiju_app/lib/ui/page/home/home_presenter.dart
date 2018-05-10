import 'package:meiju_app/data/bean/moive.dart';
import 'package:meiju_app/data/data_manager.dart';
import 'package:meiju_app/data/source/data_repository.dart';
abstract class HomeContract {
  void onLoadComplete(List<MoiveGroup> items);
  void onLoadError();
}

class HomePresenter {
  HomeContract _view;
  DataRepository _repository;
  HomePresenter(this._view) {
    _repository = DataManager().dataRepository;
  }

  void loadDatas() {
    _repository
    .getRecommendMoive()
    .then((groups)=> _view.onLoadComplete(groups))
    .catchError((onError)=>_view.onLoadError());
  }
}

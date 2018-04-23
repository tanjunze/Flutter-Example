import 'package:meiju_app/api/meiju_api.dart';
import 'package:meiju_app/api/meiju_api_impl.dart';
import 'recommend_repository.dart';
import 'recommend_repository_impl.dart';

class RepositoryFactory {
  static final RepositoryFactory _singleton = new RepositoryFactory._internal();
  factory RepositoryFactory() {
    return _singleton;
  }
  MeijuApi _api;
  RecommendRepository recommendRepository;
  RepositoryFactory._internal() {
    _api = new MeijuApiImpl();
    recommendRepository = new RecommendRepositoryImpl(_api, new List());
  }
  RecommendRepository getRecommendRepository() {
    return recommendRepository;
  }
}
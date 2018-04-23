import 'dart:async';
import 'package:meiju_app/models/moive.dart';
import 'package:meiju_app/repository/recommend_repository.dart';
import 'package:meiju_app/api/meiju_api.dart';

class RecommendRepositoryImpl implements RecommendRepository {
  MeijuApi _api;

  List<MoiveGroup> _cache = <MoiveGroup>[];

  bool isDirty = true;

  RecommendRepositoryImpl(this._api, this._cache);

  @override
  Future<List<MoiveGroup>> findMoiveGroups() {
    if (!isDirty && _cache.isNotEmpty) {
      return new Future.value(_cache);
    }
    return _api.getRecommendMoive(refresh: isDirty).then((groups) {
      isDirty = false;
      _cache = groups;
      return groups;
    });
  }
}

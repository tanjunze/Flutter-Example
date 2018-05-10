import 'dart:async';
import 'package:meiju_app/data/bean/moive.dart';

abstract class DataRepository{
  // 获取推荐美剧
   Future<List<MoiveGroup>> getRecommendMoive({bool refresh});
}
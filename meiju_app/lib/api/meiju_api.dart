import 'dart:async';
import 'package:meiju_app/models/moive.dart';

abstract class MeijuApi{
  // 获取推荐美剧
   Future<List<MoiveGroup>> getRecommendMoive({bool refresh});
}
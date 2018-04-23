import 'dart:async';
import 'package:meiju_app/models/moive.dart';

abstract class RecommendRepository{
  Future<List<MoiveGroup>> findMoiveGroups();
}
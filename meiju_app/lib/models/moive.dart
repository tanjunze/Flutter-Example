import 'package:json_annotation/json_annotation.dart';
part 'moive.g.dart';

/// 电影bean
@JsonSerializable()
class Moive extends Object with _$MoiveSerializerMixin {
  Moive(
      {this.name,
      this.img,
      this.classify,
      this.moiveNum,
      this.type,
      this.num,
      this.state});
  final String name;
  final String img;
  final String type;
  final String classify;
  final String moiveNum;
  final String num;
  final String state;

  factory Moive.fromJson(Map<String, dynamic> json) => _$MoiveFromJson(json);
}

/// 电影分组bean[Moive]
@JsonSerializable()
class MoiveGroup extends Object with _$MoiveGroupSerializerMixin {
  MoiveGroup({this.title, this.moives});

  final String title;
  final List<Moive> moives;

  factory MoiveGroup.fromJson(Map<String, dynamic> json) =>
      _$MoiveGroupFromJson(json);
}

@JsonSerializable()
class HomeBean extends Object with _$HomeBeanSerializerMixin {
  HomeBean({this.message, this.items});
  final String message;
  final List<MoiveGroup> items;
  factory HomeBean.fromJson(Map<String, dynamic> json) =>
      _$HomeBeanFromJson(json);
}

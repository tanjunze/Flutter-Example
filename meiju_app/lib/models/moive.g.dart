// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moive.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

Moive _$MoiveFromJson(Map<String, dynamic> json) => new Moive(
    name: json['name'] as String,
    img: json['img'] as String,
    classify: json['classify'] as String,
    moiveNum: json['moiveNum'] as String,
    type: json['type'] as String);

abstract class _$MoiveSerializerMixin {
  String get name;
  String get img;
  String get type;
  String get classify;
  String get moiveNum;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'img': img,
        'type': type,
        'classify': classify,
        'moiveNum': moiveNum
      };
}

MoiveGroup _$MoiveGroupFromJson(Map<String, dynamic> json) => new MoiveGroup(
    title: json['title'] as String,
    moives: (json['moives'] as List)
        ?.map((e) =>
            e == null ? null : new Moive.fromJson(e as Map<String, dynamic>))
        ?.toList());

abstract class _$MoiveGroupSerializerMixin {
  String get title;
  List<Moive> get moives;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'title': title, 'moives': moives};
}

HomeBean _$HomeBeanFromJson(Map<String, dynamic> json) => new HomeBean(
    message: json['message'] as String,
    items: (json['items'] as List)
        ?.map((e) => e == null
            ? null
            : new MoiveGroup.fromJson(e as Map<String, dynamic>))
        ?.toList());

abstract class _$HomeBeanSerializerMixin {
  String get message;
  List<MoiveGroup> get items;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'message': message, 'items': items};
}

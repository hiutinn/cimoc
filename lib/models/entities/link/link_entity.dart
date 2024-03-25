import 'package:json_annotation/json_annotation.dart';

part 'link_entity.g.dart';

@JsonSerializable()
class LinkEntity {
  @JsonKey()
  String? url;
  @JsonKey()
  String label;
  @JsonKey()
  bool active;

  LinkEntity({this.url, required this.label, required this.active});

  factory LinkEntity.fromJson(Map<String, dynamic> json) => _$LinkEntityFromJson(json);

  Map<String, dynamic> toJson() => _$LinkEntityToJson(this);
}
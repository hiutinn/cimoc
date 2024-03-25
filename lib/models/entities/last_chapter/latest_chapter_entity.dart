
import 'package:json_annotation/json_annotation.dart';

part 'latest_chapter_entity.g.dart';

@JsonSerializable()
class LatestChapterEntity {
  @JsonKey()
  int id;
  @JsonKey()
  String name;
  @JsonKey(name: "tale_id")
  int taleId;
  @JsonKey(name: "created_at")
  String createdAt;
  @JsonKey(name: "updated_at")
  String updatedAt;
  @JsonKey(name: "source_name_id")
  String sourceNameId;

  LatestChapterEntity({
    required this.id,
    required this.name,
    required this.taleId,
    required this.createdAt,
    required this.updatedAt,
    required this.sourceNameId,
  });

  factory LatestChapterEntity.fromJson(Map<String, dynamic> json) => _$LatestChapterEntityFromJson(json);

  Map<String, dynamic> toJson() => _$LatestChapterEntityToJson(this);
}

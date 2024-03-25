import 'package:flutter_base/models/entities/last_chapter/latest_chapter_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tale_entity.g.dart';

@JsonSerializable()
class TaleEntity {
  int id;
  @JsonKey(name: 'slug')
  String slug;
  @JsonKey(name: 'type_id')
  String typeId;
  @JsonKey(name: 'source_id')
  String sourceId;
  @JsonKey(name: 'uploaded_by')
  int uploadedBy;
  @JsonKey(name: 'source_name_id')
  String sourceNameId;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'another_name')
  String? anotherName;
  @JsonKey(name: 'author')
  String author;
  @JsonKey(name: 'status')
  String status;
  @JsonKey(name: 'description')
  String description;
  @JsonKey(name: 'latest_chapter_id')
  int latestChapterId;
  @JsonKey(name: 'latest_chapter')
  LatestChapterEntity latestChapter;
  @JsonKey(name: 'created_at')
  String createdAt;
  @JsonKey(name: 'updated_at')
  String updatedAt;
  @JsonKey(name: 'thumbnail_url')
  String thumbnailUrl;

  TaleEntity({
    required this.id,
    required this.slug,
    required this.typeId,
    required this.sourceId,
    required this.uploadedBy,
    required this.sourceNameId,
    required this.name,
    this.anotherName,
    required this.author,
    required this.status,
    required this.description,
    required this.latestChapterId,
    required this.latestChapter,
    required this.createdAt,
    required this.updatedAt,
    required this.thumbnailUrl,
  });

  factory TaleEntity.fromJson(Map<String, dynamic> json) =>
      _$TaleEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TaleEntityToJson(this);
}

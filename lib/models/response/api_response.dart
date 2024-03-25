import 'package:flutter_base/models/entities/link/link_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable()
class ApiResponse {
  @JsonKey(name: "current_page")
  int currentPage;
  @JsonKey()
  List<dynamic> data;
  @JsonKey(name: "first_page_url")
  String firstPageUrl;
  @JsonKey()
  int from;
  @JsonKey(name: "last_page")
  int lastPage;
  @JsonKey(name: "last_page_url")
  String lastPageUrl;
  @JsonKey()
  List<LinkEntity> links;
  @JsonKey(name: "next_page_url")
  String? nextPageUrl;
  @JsonKey()
  String path;
  @JsonKey(name: "per_page")
  int perPage;
  @JsonKey(name: "prev_page_url")
  String? prevPageUrl;
  @JsonKey()
  int to;
  @JsonKey()
  int total;

  ApiResponse({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    this.nextPageUrl,
    required this.path,
    required this.perPage,
    this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) => _$ApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);
}

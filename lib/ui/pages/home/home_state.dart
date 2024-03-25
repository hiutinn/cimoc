import 'package:equatable/equatable.dart';
import 'package:flutter_base/models/entities/movie_entity.dart';
import 'package:flutter_base/models/entities/tale/tale_entity.dart';
import 'package:flutter_base/models/enums/load_status.dart';

class HomeState extends Equatable {
  final LoadStatus loadTaleStatus;
  final List<MovieEntity> movies;
  final List<TaleEntity> tales;
  final int page;
  final int totalResults;
  final int totalPages;

  const HomeState({
    this.loadTaleStatus = LoadStatus.initial,
    this.movies = const [],
    this.tales = const [],
    this.page = 1,
    this.totalResults = 0,
    this.totalPages = 0,
  });

  bool get hasReachedMax {
    return page >= totalPages;
  }

  @override
  List<Object?> get props => [
        loadTaleStatus,
        movies,
        tales,
        page,
        totalResults,
        totalPages,
      ];

  HomeState copyWith({
    LoadStatus? loadMovieStatus,
    List<MovieEntity>? movies,
    List<TaleEntity>? tales,
    int? page,
    int? totalResults,
    int? totalPages,
  }) {
    return HomeState(
      loadTaleStatus: loadMovieStatus ?? this.loadTaleStatus,
      movies: movies ?? this.movies,
      tales: tales ?? this.tales,
      page: page ?? this.page,
      totalResults: totalResults ?? this.totalResults,
      totalPages: totalPages ?? this.totalPages,
    );
  }
}

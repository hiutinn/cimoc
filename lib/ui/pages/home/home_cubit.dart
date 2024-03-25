import 'package:flutter_base/models/entities/tale/tale_entity.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/repositories/tale_repository.dart';
import 'package:flutter_base/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_navigator.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeNavigator navigator;
  final TaleRepository taleRepo;

  HomeCubit({
    required this.navigator,
    required this.taleRepo,
  }) : super(const HomeState());

  void fetchInitialMovies() async {
    if (state.loadTaleStatus == LoadStatus.loading) {
      return;
    }
    emit(state.copyWith(loadMovieStatus: LoadStatus.loading));
    await Future.delayed(const Duration(seconds: 1));
    try {
      final result = await taleRepo.getTales(page: 1);
      final tales = result.data.map((e) => TaleEntity.fromJson(e)).toList();
      emit(state.copyWith(
        loadMovieStatus: LoadStatus.success,
        tales: tales,
        page: result.currentPage,
        totalPages: result.total,
      ));
    } catch (e) {
      logger.e(e);
      emit(state.copyWith(loadMovieStatus: LoadStatus.failure));
    }
  }

// void fetchNextMovies() async {
//   if (state.page == state.totalPages) {
//     return;
//   }
//   if (state.loadMovieStatus == LoadStatus.loading) {
//     return;
//   }
//   emit(state.copyWith(
//     loadMovieStatus: LoadStatus.loadingMore,
//   ));
//   await Future.delayed(const Duration(seconds: 1));
//   try {
//     final result = await movieRepo.getMovies(page: state.page + 1);
//     final resultList = state.movies..addAll(result.results);
//     emit(state.copyWith(
//         loadMovieStatus: LoadStatus.success,
//         movies: resultList,
//         page: result.page + 1,
//         totalPages: result.totalPages));
//   } catch (e) {
//     logger.i(e.toString());
//   }
// }
}

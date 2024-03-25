import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_dimens.dart';
import 'package:flutter_base/configs/app_configs.dart';
import 'package:flutter_base/global_blocs/user/user_cubit.dart';
import 'package:flutter_base/models/entities/tale/tale_entity.dart';
import 'package:flutter_base/models/entities/user/user_entity.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/repositories/tale_repository.dart';
import 'package:flutter_base/ui/pages/home/home_cubit.dart';
import 'package:flutter_base/ui/pages/home/home_navigator.dart';
import 'package:flutter_base/ui/widgets/list/list_empty_widget.dart';
import 'package:flutter_base/ui/widgets/list/list_error_widget.dart';
import 'package:flutter_base/ui/widgets/list/list_loading_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_state.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/tale_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) {
        return HomeCubit(
          navigator: HomeNavigator(context: context),
          taleRepo: context.read<TaleRepository>(),
        );
      },
      child: const HomeChildPage(),
    );
  }
}

class HomeChildPage extends StatefulWidget {
  const HomeChildPage({super.key});

  @override
  State<HomeChildPage> createState() => _HomeChildPageState();
}

class _HomeChildPageState extends State<HomeChildPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;
  final _scrollController = ScrollController();
  late HomeCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<HomeCubit>();
    _cubit.fetchInitialMovies();
    context.read<UserCubit>().updateUser(UserEntity.mockData());
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: const HomeAppBar(),
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.loadTaleStatus == LoadStatus.initial) {
          return Container();
        } else if (state.loadTaleStatus == LoadStatus.loading) {
          return const ListLoadingWidget();
        } else if (state.loadTaleStatus == LoadStatus.failure) {
          return const ListErrorWidget();
        } else {
          if (state.tales.isEmpty) {
            return ListEmptyWidget(onRefresh: _onRefreshData);
          } else {
            return _buildSuccessList(state.tales);
          }
        }
      },
    );
  }

  Widget _buildSuccessList(List<TaleEntity> items) {
    return RefreshIndicator(
      onRefresh: _onRefreshData,
      child: ListView.separated(
        padding: const EdgeInsets.all(AppDimens.paddingNormal),
        controller: _scrollController,
        itemBuilder: (context, index) {
          final item = items[index];
          return TaleWidget(
            tale: item,
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: AppDimens.paddingNormal);
        },
        itemCount: items.length,
      ),
    );
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= AppConfigs.scrollThreshold) {
      // _cubit.fetchNextMovies();
    }
  }

  Future<void> _onRefreshData() async {
    _cubit.fetchInitialMovies();
  }
}

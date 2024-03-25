import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_base/global_blocs/user/user_cubit.dart';
import 'package:flutter_base/models/entities/user/user_entity.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/repositories/auth_repository.dart';
import 'package:flutter_base/repositories/user_repository.dart';
import 'package:flutter_base/ui/pages/auth/sign_up/sign_up_navigator.dart';
import 'package:flutter_base/utils/logger.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpNavigator navigator;
  final AuthRepository authRepo;
  final UserRepository userRepo;
  final UserCubit userCubit;

  SignUpCubit({
    required this.navigator,
    required this.authRepo,
    required this.userRepo,
    required this.userCubit,
  }) : super(const SignUpState());

  void changeEmail({required String email}) {
    emit(state.copyWith(email: email));
    debugPrint("Email changed: $email");
  }

  void changePassword({required String password}) {
    emit(state.copyWith(password: password));
  }

  void changeConfirmPassword({required String confirmPassword}) {
    emit(state.copyWith(confirmPassword: confirmPassword));
  }

  void signUp() async {
    if (state.email?.isEmpty ?? true) {
      debugPrint("Email empty");
    }

    if (state.password?.isEmpty ?? true) {
      debugPrint("Password empty");
    }
    emit(state.copyWith(signUpStatus: LoadStatus.loading));
    try {
      final result = await authRepo.signUp(state.email ?? "", state.password ?? "");
      UserEntity? myProfile = await userRepo.getProfile();
      userCubit.updateUser(myProfile);
      authRepo.saveToken(result!);
      emit(state.copyWith(signUpStatus: LoadStatus.success));
      navigator.openHomePage();
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(signUpStatus: LoadStatus.failure));
    }
  }
}

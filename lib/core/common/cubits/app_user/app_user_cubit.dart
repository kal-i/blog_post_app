import 'package:blog_posting_app/core/common/entities/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit()
      : super(
          AppUserInitial(),
        );

  void updateUser(UserEntity? user) {
    emit(
      user == null
          ? AppUserInitial()
          : AppUserLoggedIn(
              user: user,
            ),
    );
  }
}

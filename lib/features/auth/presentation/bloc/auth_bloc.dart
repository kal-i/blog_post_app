import 'package:blog_posting_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_posting_app/core/usecase/no_params.dart';
import 'package:blog_posting_app/features/auth/domain/usecases/current_user.dart';
import 'package:blog_posting_app/features/auth/domain/usecases/sign_in.dart';
import 'package:blog_posting_app/features/auth/domain/usecases/sign_up.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/entities/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required SignUp signUp,
    required SignIn signIn,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
  })  : _signUp = signUp,
        _signIn = signIn,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    /// triggers whenever an event is triggered
    on<AuthEvent>(
      (_, emit) => emit(
        AuthLoading(),
      ),
    );
    on<AuthSignUp>(_onSignUp);
    on<AuthSignIn>(_onSignIn);
    on<AuthIsUserLoggedIn>(_onIsUserLoggedIn);
  }

  final SignUp _signUp;
  final SignIn _signIn;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;

  void _onSignUp(
    AuthSignUp event,
    Emitter<AuthState> emit,
  ) async {
    final response = await _signUp(
      SignUpParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );

    response.fold(
      (l) => emit(
        AuthError(
          message: l.message,
        ),
      ),
      (r) => _emitAuthSuccess(
        r,
        emit,
      ),
    );
  }

  void _onSignIn(
    AuthSignIn event,
    Emitter<AuthState> emit,
  ) async {
    final response = await _signIn(
      SignInParams(
        email: event.email,
        password: event.password,
      ),
    );

    response.fold(
      (l) => emit(
        AuthError(
          message: l.message,
        ),
      ),
      (r) => _emitAuthSuccess(
        r,
        emit,
      ),
    );
  }

  void _onIsUserLoggedIn(
    AuthIsUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _currentUser(
      NoParams(),
    );

    result.fold(
      (l) => emit(
        AuthError(
          message: l.message,
        ),
      ),
      (r) => _emitAuthSuccess(
        r,
        emit,
      ),
    );
  }

  /// emit auth success and update the app wide user
  /// whenever the user is logged in, signs up, or signs in
  void _emitAuthSuccess(
    UserEntity user,
    Emitter<AuthState> emit,
  ) {
    _appUserCubit.updateUser(
      user,
    );
    emit(
      AuthSuccess(
        user: user,
      ),
    );
  }
}

import 'package:blog_posting_app/core/usecase/no_params.dart';
import 'package:blog_posting_app/features/auth/domain/entities/user.dart';
import 'package:blog_posting_app/features/auth/domain/usecases/current_user.dart';
import 'package:blog_posting_app/features/auth/domain/usecases/sign_in.dart';
import 'package:blog_posting_app/features/auth/domain/usecases/sign_up.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required SignUp signUp,
    required SignIn signIn,
    required CurrentUser currentUser,
  })  : _signUp = signUp,
        _signIn = signIn,
        _currentUser = currentUser,
        super(AuthInitial()) {
    on<AuthSignUp>(_onSignUp);
    on<AuthSignIn>(_onSignIn);
    on<AuthIsUserLoggedIn>(_onIsUserLoggedIn);
  }

  final SignUp _signUp;
  final SignIn _signIn;
  final CurrentUser _currentUser;

  void _onSignUp(
    AuthSignUp event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

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
      (r) => emit(
        AuthSuccess(
          user: r,
        ),
      ),
    );
  }

  void _onSignIn(
    AuthSignIn event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

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
      (r) => AuthSuccess(
        user: r,
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
      (r) => emit(
        AuthSuccess(
          user: r,
        ),
      ),
    );
  }
}

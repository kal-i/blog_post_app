import 'package:blog_posting_app/features/auth/domain/entities/user.dart';
import 'package:blog_posting_app/features/auth/domain/usecases/sign_in.dart';
import 'package:blog_posting_app/features/auth/domain/usecases/sign_up.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required SignUp signUp,
    required SignIn signIn,
  })  : _signUp = signUp,
        _signIn = signIn,
        super(AuthInitial()) {
    on<AuthSignUp>(_onSignUp);
    on<AuthSignIn>(_onSignIn);
  }

  final SignUp _signUp;
  final SignIn _signIn;

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
}

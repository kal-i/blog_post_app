import 'package:blog_posting_app/features/auth/domain/entities/user.dart';
import 'package:blog_posting_app/features/auth/domain/usecases/sign_up.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required SignUp signUp,
  })  : _signUp = signUp,
        super(AuthInitial()) {
    on<AuthSignUp>(_onSignUp);
  }

  final SignUp _signUp;

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
}

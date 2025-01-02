import 'package:blog_posting_app/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({
    required this.supabaseClient,
  });

  final SupabaseClient supabaseClient;

  @override
  Future<String> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<String> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      /// for additional info in sign up, use data
      final response = await supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {
          'name': name,
        },
      );

      if (response.user == null) {
        throw const ServerException(message: 'User is null');
      }

      return response.session!.user.id;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}

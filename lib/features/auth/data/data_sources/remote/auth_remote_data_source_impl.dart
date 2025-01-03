import 'package:blog_posting_app/core/error/exceptions.dart';
import 'package:blog_posting_app/features/auth/data/models/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({
    required this.supabaseClient,
  });

  final SupabaseClient supabaseClient;

  @override
  Future<UserModel> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<UserModel> signUpWithEmailPassword({
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

      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}

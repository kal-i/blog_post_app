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
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw const ServerException(
          message: 'Invalid email or password.',
        );
      }

      return UserModel.fromJson(
        response.user!.toJson(),
      );
    } catch (e) {
      throw ServerException(
        message: e.toString(),
      );
    }
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
        throw const ServerException(
          message: 'User is null.',
        );
      }

      return UserModel.fromJson(
        response.user!.toJson(),
      );
    } catch (e) {
      throw ServerException(
        message: e.toString(),
      );
    }
  }

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      /// if current user session is not null
      /// meaning user is logged in
      if (currentUserSession != null) {
        /// .from() method directly talks to the supabase DB, inside we pass the table name
        /// .select() to get all fields cause by default it is set to '*'
        /// to select a specific field: 'id, name'
        /// .eq() will get current user data based on the id col in the table
        final userData = await supabaseClient
            .from(
              'profiles',
            )
            .select()
            .eq(
              'id',
              currentUserSession!.user.id,
            );

        /// return the first data from the list
        return UserModel.fromJson(
          userData.first,
        ).copyWith(
          email: currentUserSession!.user.email,
        );
      }
      return null;
    } catch (e) {
      throw ServerException(
        message: e.toString(),
      );
    }
  }
}

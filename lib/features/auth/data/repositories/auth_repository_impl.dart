import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserModel>> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    return _getUser(
      () async => await remoteDataSource.loginWithEmailAndPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, UserModel>> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDataSource.signUpWithEmailAndPassword(
        name: name,
        email: email,
        password: password,
      ),
    );
  }
}

Future<Either<Failure, UserModel>> _getUser(
  Future<UserModel> Function() fn,
) async {
  try {
    final user = await fn();
    return right(user);
<<<<<<< HEAD
  } on AuthException catch (e) {
    return left(Failure(msg: e.message));
=======
>>>>>>> 2b23ca92ac997e61ea64e469834d896f2a9aab7b
  } on ServerException catch (e) {
    return left(Failure(msg: e.msg));
  }
}

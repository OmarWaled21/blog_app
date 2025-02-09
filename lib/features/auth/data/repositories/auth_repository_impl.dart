import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final ConnectionChecker internetConnection;

  AuthRepositoryImpl(
      {required this.remoteDataSource, required this.internetConnection});

  @override
  Future<Either<Failure, UserModel>> currentUser() async {
    try {
      if (!await internetConnection.isConnected()) {
        final session = remoteDataSource.currentUserSession;

        if (session == null) {
          return left(Failure(msg: 'User not logged in'));
        }

        return right(
          UserModel(
            id: session.user.id,
            name: '',
            email: session.user.email ?? '',
          ),
        );
      }

      final user = await remoteDataSource.getCurrentUserData();
      if (user == null) {
        return left(Failure(msg: 'User not logged in'));
      }
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(msg: e.msg));
    }
  }

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

  Future<Either<Failure, UserModel>> _getUser(
    Future<UserModel> Function() fn,
  ) async {
    try {
      if (!await internetConnection.isConnected()) {
        return left(Failure(msg: 'No internet connection'));
      }
      final user = await fn();
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(msg: e.msg));
    }
  }
}

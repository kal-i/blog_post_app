import 'package:blog_posting_app/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UseCase<Type, Params> {

/// use to expose a high level function
Future<Either<Failure, Type>> call(Params params);
}

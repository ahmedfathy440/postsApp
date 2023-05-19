import 'package:Posts_App/core/error/failures.dart';
import 'package:Posts_App/features/posts/domain/repositries/posts_repositrory.dart';
import 'package:dartz/dartz.dart';

class DeletePostUsecase {
  final PostsRepository repository;

  DeletePostUsecase(this.repository);

  Future<Either<Failure,Unit>>call (int postId) async {
    return await repository.deletePost(postId);
  }
}
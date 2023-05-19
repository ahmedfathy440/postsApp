import 'package:Posts_App/core/error/failures.dart';
import 'package:Posts_App/features/posts/domain/entities/post.dart';
import 'package:Posts_App/features/posts/domain/repositries/posts_repositrory.dart';
import 'package:dartz/dartz.dart';

class GetAllPostsUsecase {
  final PostsRepository repository;

  GetAllPostsUsecase(this.repository);

  Future<Either<Failure, List<Post>>> call () async {
    return await repository.getAllPosts();
  }
}
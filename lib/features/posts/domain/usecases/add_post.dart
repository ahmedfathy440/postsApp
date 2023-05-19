import 'package:Posts_App/core/error/failures.dart';
import 'package:Posts_App/features/posts/domain/entities/post.dart';
import 'package:Posts_App/features/posts/domain/repositries/posts_repositrory.dart';
import 'package:dartz/dartz.dart';

class AddPostUsecase {
  final PostsRepository repository;

  AddPostUsecase(this.repository);

  Future<Either<Failure,Unit>> call (Post post) async {
    return await repository.addPost(post);
  }
}
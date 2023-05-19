import 'package:Posts_App/features/posts/domain/entities/post.dart';
import 'package:Posts_App/features/posts/domain/repositries/posts_repositrory.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

class UpdatePostUsecase {
  final PostsRepository repository ;

  UpdatePostUsecase(this.repository);

  Future<Either<Failure,Unit>> call ( Post post) async {
    return await repository.updatePost(post);
  }

}
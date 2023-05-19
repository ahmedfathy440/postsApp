import 'package:Posts_App/core/error/exception.dart';
import 'package:Posts_App/core/error/failures.dart';
import 'package:Posts_App/features/posts/data/models/post_model.dart';
import 'package:Posts_App/features/posts/domain/entities/post.dart';
import 'package:Posts_App/features/posts/domain/repositries/posts_repositrory.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/post_local_data_source.dart';
import '../datasources/post_remote_data_source.dart';

typedef DeleteOrUpdateOrAddPost = Future<Unit> Function();

class PostsRepositoryImpl extends PostsRepository{

  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PostsRepositoryImpl({required this.remoteDataSource,required this.localDataSource,required this.networkInfo});
  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if(await networkInfo.isConnected){
      try{
        final remotePosts = await remoteDataSource.getAllPosts();
        localDataSource.cachedPosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    else {
      try
      {
        final localPosts = await localDataSource.getCachedPosts();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }

    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post)async {
    final PostModel postModel = PostModel( title: post.title, body: post.body);
    return await _getMessage(() {
      return remoteDataSource.addPost(postModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id) async {
   return await _getMessage(() {
     return remoteDataSource.deletePost(id);
   });
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    final PostModel postModel = PostModel(id: post.id, title: post.title, body: post.body);
    return await _getMessage(() {
      return remoteDataSource.updatePost(postModel);
    });
  }

  Future<Either<Failure, Unit>> _getMessage (DeleteOrUpdateOrAddPost deleteOrUpdateOrAddPost) async{
    if(await networkInfo.isConnected){
      try{
        await deleteOrUpdateOrAddPost();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    }else{
      return Left(OfflineFailure());
    }
  }
}
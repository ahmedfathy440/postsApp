import 'package:Posts_App/core/Strings/failures.dart';
import 'package:Posts_App/core/error/failures.dart';
import 'package:Posts_App/features/posts/presentation/bloc/posts/posts_event.dart';
import 'package:Posts_App/features/posts/presentation/bloc/posts/posts_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/usecases/get_all_posts.dart';

class PostsBloc extends Bloc<PostsEvent,PostsState> {
  final GetAllPostsUsecase getAllPosts;
  PostsBloc({required this.getAllPosts}) : super(PostsInitial()){
    on<PostsEvent>((event, emit) async {
      if(event is GetAllPostsEvent){
        emit(LoadingPostsState());

        final FailureOrPosts = await getAllPosts();
        emit (_mapFailureOrPostsToState(FailureOrPosts));
      }
      else if (event is RefreshPosts)
      {
        emit(LoadingPostsState());

        final FailureOrPosts = await getAllPosts();
        emit (_mapFailureOrPostsToState(FailureOrPosts));
    }

    });
  }

  PostsState _mapFailureOrPostsToState (Either<Failure,List<Post>> either){
   return either.fold((failure) => 
        ErrorPostsState(message: _mapFailureToMessage(failure)),
            (posts) => LoadedPostsState(posts: posts));
  }
  String _mapFailureToMessage (Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure :
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure :
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please tru again later";
    }
  }
}
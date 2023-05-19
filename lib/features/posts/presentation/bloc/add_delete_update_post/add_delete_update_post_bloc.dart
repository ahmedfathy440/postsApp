// ignore_for_file: non_constant_identifier_names

import 'package:Posts_App/core/Strings/messages.dart';
import 'package:Posts_App/features/posts/domain/entities/post.dart';
import 'package:Posts_App/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_event.dart';
import 'package:Posts_App/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/Strings/failures.dart';
import '../../../../../core/error/failures.dart';
import '../../../domain/usecases/add_post.dart';
import '../../../domain/usecases/delete_post.dart';
import '../../../domain/usecases/update_post.dart';

class AddDeleteUpdatePostBloc
    extends Bloc<AddDeleteUpdatePostEvent, AddDeleteUpdatePostState> {
  final AddPostUsecase addPost;
  final DeletePostUsecase deletePost;
  final UpdatePostUsecase updatePost;
  AddDeleteUpdatePostBloc(
      {required this.addPost,
      required this.deletePost,
      required this.updatePost})
      : super(AddDeleteUpdatePostInitial()) {
    on<AddDeleteUpdatePostEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit (LoadingAddDeleteUpdatePostState());

        final FailureOrDoneMessage = await addPost(event.post);
        emit (_eitherDoneMessageOrErrorMessage(FailureOrDoneMessage, ADD_SUCCESS_MESSAGE));
      } else if (event is DeletePostEvent) {
        emit (LoadingAddDeleteUpdatePostState());

        final FailureOrDoneMessage = await deletePost(event.postId);
        emit(_eitherDoneMessageOrErrorMessage(FailureOrDoneMessage, DELETE_SUCCESS_MESSAGE));
      } else if (event is UpdatePostEvent) {
        emit (LoadingAddDeleteUpdatePostState());

        final FailureOrDoneMessage = await updatePost(event.post);
        emit(_eitherDoneMessageOrErrorMessage(FailureOrDoneMessage, UPDATE_SUCCESS_MESSAGE));
      }
    });
  }

  AddDeleteUpdatePostState _eitherDoneMessageOrErrorMessage ( Either<Failure,Unit> either , String message) {
    return either.fold((failure) =>
      ErrorAddDeleteUpdatePostState(message: _mapFailureToMessage(failure))
        ,
            (_) => MessageAddDeleteUpdatePostState(message: message));
  }

  String _mapFailureToMessage (Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure :
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please tru again later";
    }
  }
}

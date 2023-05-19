import 'package:equatable/equatable.dart';
import '../../../domain/entities/post.dart';

abstract class AddDeleteUpdatePostEvent extends Equatable{
  const AddDeleteUpdatePostEvent();
  @override
  List<Object?> get props => [];
}

class AddPostEvent extends AddDeleteUpdatePostEvent {
  final Post post;
  const AddPostEvent({required this.post});
  @override
  List<Object?> get props => [];
}

class UpdatePostEvent extends AddDeleteUpdatePostEvent {
  final Post post;
  const UpdatePostEvent({required this.post});
  @override
  List<Object?> get props => [];
}

class DeletePostEvent extends AddDeleteUpdatePostEvent {
  final int postId;
  const DeletePostEvent({required this.postId});
  @override
  List<Object?> get props => [];
}
import 'package:equatable/equatable.dart';

abstract class PostsEvent extends Equatable{
  const PostsEvent();

  @override
  List<Object> get props => [];
}

class GetAllPostsEvent extends PostsEvent{}
class RefreshPosts extends PostsEvent{}
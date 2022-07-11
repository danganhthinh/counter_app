import 'package:equatable/equatable.dart';
import 'package:counter_app/models/comment.dart';

abstract class CommentState extends Equatable {
  const CommentState();
}

class CommentStateInitial extends CommentState {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class CommentStateFailure extends CommentStateInitial{}

class CommentStateSuccess extends CommentState {
  final List<Comment> comments;
  final bool hasReachedEnd;

  const CommentStateSuccess({required this.comments, required this.hasReachedEnd});

  @override
  String toString() {
    // TODO: implement toString
    return "comments : $comments, hasReachedEnd: $hasReachedEnd";
  }

  @override
  List<Object> get props => [comments, hasReachedEnd];

  CommentStateSuccess cloneWith(
      {List<Comment>? comments, bool? hasReachedEnd}) {
    return CommentStateSuccess(
        comments: comments ?? this.comments,
        hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd);
  }
}

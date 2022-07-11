import 'package:equatable/equatable.dart';

abstract class CommentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CommentFetchEvent extends CommentEvent{

}
import 'package:kitchen_queue/feautures/comment/models/comment.dart';

class CommentState {
  final List<Comment> comments;
  final bool isLoading;

  CommentState({
    this.comments = const [],
    this.isLoading = false,
  });

  CommentState copyWith({
    List<Comment>? comments,
    bool? isLoading,
  }) {
    return CommentState(
      comments: comments ?? this.comments,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
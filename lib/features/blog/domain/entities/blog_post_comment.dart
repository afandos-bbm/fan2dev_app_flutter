import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'blog_post_comment.g.dart';

@JsonSerializable()
class BlogPostComment extends Equatable {
  const BlogPostComment({
    required this.id,
    required this.authorId,
    required this.authorDisplayName,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BlogPostComment.fromJson(Map<String, dynamic> json) =>
      _$BlogPostCommentFromJson(json);
  Map<String, dynamic> toJson() => _$BlogPostCommentToJson(this);

  final String id;
  final String authorId;
  final String authorDisplayName;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  List<Object?> get props =>
      [id, authorId, authorDisplayName, content, createdAt, updatedAt];

  @override
  bool get stringify => true;

  BlogPostComment copyWith({
    String? id,
    String? authorId,
    String? authorDisplayName,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BlogPostComment(
      id: id ?? this.id,
      authorId: authorId ?? this.authorId,
      authorDisplayName: authorDisplayName ?? this.authorDisplayName,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

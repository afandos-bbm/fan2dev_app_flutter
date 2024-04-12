import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:fan2dev/features/blog/domain/entities/blog_post_category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'blog_post.g.dart';

@JsonSerializable()
class BlogPost extends Equatable {
  const BlogPost({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BlogPost.fromJson(Map<String, dynamic> json) =>
      _$BlogPostFromJson(json);
  Map<String, dynamic> toJson() => _$BlogPostToJson(this);

  final String id;
  final String title;
  final String content;
  final BlogPostCategory category;
  @JsonKey(fromJson: _dateTimeFromTimestamp)
  final DateTime createdAt;
  @JsonKey(fromJson: _dateTimeFromTimestamp)
  final DateTime updatedAt;

  BlogPost copyWith({
    String? id,
    String? title,
    String? content,
    BlogPostCategory? category,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BlogPost(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props =>
      [id, title, content, category, createdAt, updatedAt];

  static DateTime _dateTimeFromTimestamp(Timestamp? timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(
      timestamp!.millisecondsSinceEpoch,
    );
  }
}

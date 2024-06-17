import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:fan2dev/core/core.dart';
import 'package:fan2dev/features/blog/domain/entities/blog_post_category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'blog_post.g.dart';

@JsonSerializable()
class BlogPost extends Equatable {
  const BlogPost({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.content,
    required this.category,
    required this.likes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BlogPost.fromJson(Map<String, dynamic> json) =>
      _$BlogPostFromJson(json);
  Map<String, dynamic> toJson() => _$BlogPostToJson(this);

  final String id;
  final String title;
  final String subtitle;
  final String content;
  final BlogPostCategory category;
  final int likes;
  @JsonKey(fromJson: _dateTimeFromTimestamp)
  final DateTime createdAt;
  @JsonKey(fromJson: _dateTimeFromTimestamp)
  final DateTime updatedAt;

  bool get isLikedByUser =>
      locator<SharedPreferencesService>().postsLiked.contains(id);

  String get url => '${ConfigurationService.i.appUrl}/blog/$id';

  BlogPost copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? content,
    BlogPostCategory? category,
    int? likes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BlogPost(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      content: content ?? this.content,
      category: category ?? this.category,
      likes: likes ?? this.likes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props =>
      [id, title, subtitle, content, category, likes, createdAt, updatedAt];

  static DateTime _dateTimeFromTimestamp(Timestamp? timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(
      timestamp!.millisecondsSinceEpoch,
    );
  }
}

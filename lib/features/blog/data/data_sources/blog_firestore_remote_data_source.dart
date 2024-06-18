import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fan2dev/core/firebase_client/firebase_client.dart';
import 'package:fan2dev/core/locator/locator.dart';
import 'package:fan2dev/features/blog/domain/domain.dart';
import 'package:fan2dev/features/blog/domain/entities/blog_post_category.dart';
import 'package:fan2dev/features/blog/domain/entities/blog_post_comment.dart';
import 'package:fan2dev/utils/result.dart';

abstract class BlogFirestoreRemoteDataSource {
  Future<Result<List<BlogPost>, Exception>> getPosts({
    required int start,
    required int limit,
    required BlogPostCategory category,
  });

  Future<Result<BlogPost, Exception>> getPostById({required String id});

  Future<Result<void, Exception>> likePost({required String id});

  Future<Result<void, Exception>> unlikePost({required String id});

  Future<Result<List<BlogPostComment>, Exception>> getPostComments({
    required String postId,
  });

  Future<Result<BlogPostComment, Exception>> addPostComment({
    required String postId,
    required String content,
  });
}

class BlogFirestoreRemoteDataSourceImpl
    implements BlogFirestoreRemoteDataSource {
  BlogFirestoreRemoteDataSourceImpl({
    required this.firebaseFirestore,
  });

  final FirebaseFirestore firebaseFirestore;

  @override
  Future<Result<List<BlogPost>, Exception>> getPosts({
    required int start,
    required int limit,
    required BlogPostCategory category,
  }) async {
    try {
      late QuerySnapshot<Map<String, dynamic>> posts;

      if (category != BlogPostCategory.all) {
        posts = await firebaseFirestore
            .collection('blogPosts')
            .where('category', isEqualTo: category.value)
            .where('isHidden', isEqualTo: false)
            .orderBy('createdAt', descending: true)
            .limit(limit)
            .get();
      } else {
        posts = await firebaseFirestore
            .collection('blogPosts')
            .where('isHidden', isEqualTo: false)
            .orderBy('createdAt', descending: true)
            .limit(limit)
            .get();
      }

      final blogPosts = posts.docs
          .map((post) => BlogPost.fromJson({...post.data(), 'id': post.id}))
          .toList();

      return Result.success(data: blogPosts);
    } catch (e) {
      return Result.failure(error: Exception(e));
    }
  }

  @override
  Future<Result<BlogPost, Exception>> getPostById({required String id}) async {
    try {
      final post =
          await firebaseFirestore.collection('blogPosts').doc(id).get();

      if (!post.exists) {
        return const Result.empty();
      }

      final blogPost = BlogPost.fromJson({...post.data()!, 'id': post.id});

      return Result.success(data: blogPost);
    } catch (e) {
      return Future.value(Result.failure(error: Exception(e)));
    }
  }

  @override
  Future<Result<void, Exception>> likePost({required String id}) async {
    try {
      final post =
          await firebaseFirestore.collection('blogPosts').doc(id).get();

      if (!post.exists) {
        return const Result.empty();
      }

      final likes = post.data()!['likes'] as int;

      await firebaseFirestore
          .collection('blogPosts')
          .doc(id)
          .update({'likes': likes + 1});

      return const Result.empty();
    } catch (e) {
      return Result.failure(error: Exception(e));
    }
  }

  @override
  Future<Result<void, Exception>> unlikePost({required String id}) async {
    try {
      final post =
          await firebaseFirestore.collection('blogPosts').doc(id).get();

      if (!post.exists) {
        return const Result.empty();
      }

      final likes = post.data()!['likes'] as int;

      if (likes <= 0) {
        return const Result.empty();
      }

      await firebaseFirestore
          .collection('blogPosts')
          .doc(id)
          .update({'likes': likes - 1});

      return const Result.empty();
    } catch (e) {
      return Result.failure(error: Exception(e));
    }
  }

  @override
  Future<Result<List<BlogPostComment>, Exception>> getPostComments({
    required String postId,
  }) async {
    try {
      late QuerySnapshot<Map<String, dynamic>> comments;

      comments = await firebaseFirestore
          .collection('blogPosts')
          .doc(postId)
          .collection('comments')
          .orderBy('createdAt', descending: true)
          .get();

      final blogPostComments = comments.docs
          .map(
            (comment) =>
                BlogPostComment.fromJson({...comment.data(), 'id': comment.id}),
          )
          .toList();

      await Future.forEach(blogPostComments, (comment) async {
        final user = await firebaseFirestore
            .collection('users')
            .doc(comment.authorId)
            .get()
            .then((user) => user.data());

        final updatedComment = comment.copyWith(
          authorDisplayName: user!['displayName'] as String,
        );

        blogPostComments[blogPostComments.indexOf(comment)] = updatedComment;
      });

      return Result.success(data: blogPostComments);
    } catch (e) {
      return Result.failure(error: Exception(e));
    }
  }

  @override
  Future<Result<BlogPostComment, Exception>> addPostComment({
    required String postId,
    required String content,
  }) async {
    try {
      final user = locator<FirebaseClient>().firebaseAuthInstance.currentUser!;

      final comment = firebaseFirestore
          .collection('blogPosts')
          .doc(postId)
          .collection('comments')
          .doc();

      await comment.set({
        'authorId': user.uid,
        'content': content,
        'createdAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
      });

      return Result.success(
        data: BlogPostComment(
          id: comment.id,
          authorId: user.uid,
          authorDisplayName: user.displayName ?? user.email!.split('@').first,
          content: content,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );
    } catch (e) {
      return Result.failure(error: Exception(e));
    }
  }
}

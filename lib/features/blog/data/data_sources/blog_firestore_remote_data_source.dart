import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fan2dev/features/blog/domain/domain.dart';
import 'package:fan2dev/features/blog/domain/entities/blog_post_category.dart';
import 'package:fan2dev/utils/result.dart';

abstract class BlogFirestoreRemoteDataSource {
  Future<Result<List<BlogPost>, Exception>> getPosts({
    required int start,
    required int limit,
    required BlogPostCategory category,
  });

  Future<Result<BlogPost, Exception>> getPostById({required String id});
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
            .orderBy('createdAt', descending: true)
            .limit(limit)
            .get();
      } else {
        posts = await firebaseFirestore
            .collection('blogPosts')
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
}

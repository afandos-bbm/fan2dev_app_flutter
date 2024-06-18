import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fan2dev/features/blog/domain/domain.dart';
import 'package:fan2dev/utils/result.dart';

abstract class SearchFirestoreRemoteDataSource {
  Future<Result<List<BlogPost>, Exception>> searchPosts({
    required String query,
  });
}

class SearchFirestoreRemoteDataSourceImpl
    implements SearchFirestoreRemoteDataSource {
  SearchFirestoreRemoteDataSourceImpl({
    required this.firebaseFirestore,
  });

  final FirebaseFirestore firebaseFirestore;

  @override
  Future<Result<List<BlogPost>, Exception>> searchPosts({
    required String query,
  }) async {
    try {
      late QuerySnapshot<Map<String, dynamic>> posts;

      // get titles of all blogPosts collection
      posts = await firebaseFirestore.collection('blogPosts').get();

      final blogPosts = posts.docs
          .map((post) => BlogPost.fromJson({...post.data(), 'id': post.id}))
          .toList();

      // filter blogPosts by query
      blogPosts.retainWhere(
        (post) => post.title.toLowerCase().contains(query.toLowerCase()),
      );

      return Result.success(data: blogPosts);
    } catch (e) {
      return Result.failure(error: e as Exception);
    }
  }
}

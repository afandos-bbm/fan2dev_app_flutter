import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fan2dev/features/blog/domain/entities/blog_post.dart';
import 'package:fan2dev/features/contact/domain/domain.dart';
import 'package:fan2dev/utils/result.dart';

abstract class BackofficeFirestoreRemoteDataSource {
  Future<Result<List<ContactForm>, Exception>> getContactForms();

  Future<Result<void, Exception>> deleteContactForm(String id);

  Future<Result<List<BlogPost>, Exception>> getBlogPosts();

  Future<Result<void, Exception>> toggleHidePost(String id);

  Future<Result<void, Exception>> editPost(BlogPost post);
}

class BackofficeFirestoreRemoteDataSourceImpl
    implements BackofficeFirestoreRemoteDataSource {
  BackofficeFirestoreRemoteDataSourceImpl({
    required this.firebaseFirestore,
  });

  final FirebaseFirestore firebaseFirestore;

  @override
  Future<Result<List<ContactForm>, Exception>> getContactForms() async {
    try {
      late QuerySnapshot<Map<String, dynamic>> forms;

      forms = await firebaseFirestore
          .collection('formSubmissions')
          .orderBy('createdAt', descending: true)
          .get();

      final formSubmissions = forms.docs
          .map((form) => ContactForm.fromJson({...form.data(), 'id': form.id}))
          .toList();

      return Result.success(data: formSubmissions);
    } catch (e) {
      return Result.failure(error: Exception(e));
    }
  }

  @override
  Future<Result<void, Exception>> deleteContactForm(String id) async {
    try {
      await firebaseFirestore.collection('formSubmissions').doc(id).delete();
      return const Result.empty();
    } catch (e) {
      return Result.failure(error: Exception(e));
    }
  }

  @override
  Future<Result<List<BlogPost>, Exception>> getBlogPosts() async {
    try {
      late QuerySnapshot<Map<String, dynamic>> posts;

      posts = await firebaseFirestore
          .collection('blogPosts')
          .orderBy('createdAt', descending: true)
          .get();

      final blogPosts = posts.docs
          .map((post) => BlogPost.fromJson({...post.data(), 'id': post.id}))
          .toList();

      return Result.success(data: blogPosts);
    } catch (e) {
      return Result.failure(error: Exception(e));
    }
  }

  @override
  Future<Result<void, Exception>> toggleHidePost(String id) async {
    try {
      final post =
          await firebaseFirestore.collection('blogPosts').doc(id).get();
      final isHidden = post.data()?['isHidden'] as bool? ?? false;
      await firebaseFirestore
          .collection('blogPosts')
          .doc(id)
          .update({'isHidden': !isHidden});
      return const Result.empty();
    } catch (e) {
      return Result.failure(error: Exception(e));
    }
  }

  @override
  Future<Result<void, Exception>> editPost(BlogPost post) async {
    final updatedPost = post.copyWith(updatedAt: DateTime.now());

    try {
      await firebaseFirestore
          .collection('blogPosts')
          .doc(updatedPost.id)
          .update(updatedPost.toJson());
      return const Result.empty();
    } catch (e) {
      return Result.failure(error: Exception(e));
    }
  }
}

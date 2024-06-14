import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fan2dev/features/contact/domain/domain.dart';
import 'package:fan2dev/utils/result.dart';

abstract class BackofficeFirestoreRemoteDataSource {
  Future<Result<List<ContactForm>, Exception>> getContactForms();

  Future<Result<void, Exception>> deleteContactForm(String id);
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
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fan2dev/features/contact/domain/entities/contact_form/contact_form.dart';
import 'package:fan2dev/utils/result.dart';

abstract class ContactFirestoreFormSubmissionsRemoteDataSource {
  Future<Result<void, Exception>> sendContactForm({
    required String email,
    required String name,
    required String message,
  });
}

class ContactFirestoreFormSubmissionsRemoteDataSourceImpl
    implements ContactFirestoreFormSubmissionsRemoteDataSource {
  ContactFirestoreFormSubmissionsRemoteDataSourceImpl({
    required this.firebaseFirestore,
  });

  final FirebaseFirestore firebaseFirestore;

  @override
  Future<Result<void, Exception>> sendContactForm({
    required String email,
    required String name,
    required String message,
  }) async {
    try {
      final formSubmission = ContactForm(
        email: email,
        subject: 'New message from $name',
        message: message,
        createdAt: DateTime.now().toUtc().toString(),
      );

      final formSubmissions =
          FirebaseFirestore.instance.collection('formSubmissions');

      await formSubmissions.add(formSubmission.toJson());

      return const Result.empty();
    } catch (e) {
      return Result.failure(error: Exception(e));
    }
  }
}

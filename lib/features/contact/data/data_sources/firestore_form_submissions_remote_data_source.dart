import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fan2dev/features/contact/domain/entities/contact_form.dart';
import 'package:fan2dev/utils/logger.dart';
import 'package:fan2dev/utils/result.dart';

abstract class FirestoreFormSubmissionsRemoteDataSource {
  Future<Result<void, Exception>> sendContactForm(
      {required String email, required String name, required String message});
}

class Web3formsRemoteDataSourceImpl
    implements FirestoreFormSubmissionsRemoteDataSource {
  Web3formsRemoteDataSourceImpl();

  @override
  Future<Result<void, Exception>> sendContactForm(
      {required String email,
      required String name,
      required String message}) async {
    try {
      final ContactForm formSubmission = ContactForm(
        email: email,
        subject: "New message from $name [Via Fan2Dev]",
        message: message,
        createdAt: DateTime.now().toUtc().toString(),
      );

      final formSubmissions =
          FirebaseFirestore.instance.collection('formSubmissions');

      final result = await formSubmissions.add(formSubmission.toJson());

      l(result.toString());

      return const Result.empty();
    } catch (e) {
      return Result.failure(error: Exception(e));
    }
  }
}

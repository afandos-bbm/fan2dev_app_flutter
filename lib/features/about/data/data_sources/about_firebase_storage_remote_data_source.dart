import 'package:fan2dev/features/about/domain/entities/about_images/about_images.dart';
import 'package:fan2dev/utils/result.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class AboutFirebaseStorageRemoteDataSource {
  Future<Result<AboutImages, Exception>> getAboutImages();
}

class AboutFirebaseStorageRemoteDataSourceImpl
    implements AboutFirebaseStorageRemoteDataSource {
  AboutFirebaseStorageRemoteDataSourceImpl({required this.firebaseStorage});

  final FirebaseStorage firebaseStorage;

  @override
  Future<Result<AboutImages, Exception>> getAboutImages() async {
    try {
      final ref = firebaseStorage.ref('about');
      final carrouselImagesRef = ref.child('carrousel');
      final carrouselResult = carrouselImagesRef.listAll();
      final headerResult =
          ref.child('fan2dev_about_profile.webp').getDownloadURL();

      final flutterDashResult =
          ref.child('fan2dev_about_flutter_dash.webp').getDownloadURL();

      final [
        carrouselResultResolved as ListResult,
        headerResultResolved as String,
        flutterDashResultResolved as String,
      ] = await Future.wait([
        carrouselResult,
        headerResult,
        flutterDashResult,
      ]);

      final carrouselImagesUrls = await Future.wait(
        carrouselResultResolved.items.map((e) => e.getDownloadURL()).toList(),
      );

      final aboutImages = AboutImages(
        carrouselImagesUrls: carrouselImagesUrls,
        headerImageUrl: headerResultResolved,
        flutterDashImageUrl: flutterDashResultResolved,
      );

      return Result.success(data: aboutImages);
    } on FirebaseException catch (e) {
      return Result.failure(error: e);
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:fan2dev/core/dio_client/dio_client.dart';
import 'package:fan2dev/core/shared_preferences_service/shared_preferences_service.dart';
import 'package:fan2dev/core/theme_service/theme_service.dart';
import 'package:fan2dev/features/about/data/data_sources/about_firebase_storage_remote_data_source.dart';
import 'package:fan2dev/features/contact/data/data_sources/contact_firestore_form_submissions_remote_data_source.dart';
import 'package:fan2dev/features/projects/data/data_sources/local_data_source.dart';
import 'package:fan2dev/utils/device_info.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

/// Initializes the GetIt service locator and registers the necessary
/// dependencies
Future<void> initGetIt() async {
  // * Storage
  locator.registerSingletonAsync<SharedPreferencesService>(
    SharedPreferencesService.initSharedPreferencesService,
  );

  await locator.isReady<SharedPreferencesService>();

  // * Core
  locator.registerLazySingleton<ThemeService>(ThemeService.new);
  locator.registerLazySingleton<DeviceInfo>(DeviceInfo.new);

  locator.registerSingleton<DioClient>(DioClient(Dio())..initDio());

  // * Data sources
  locator
      .registerLazySingleton<ContactFirestoreFormSubmissionsRemoteDataSource>(
    () => ContactFirestoreFormSubmissionsRemoteDataSourceImpl(
      firebaseFirestore: FirebaseFirestore.instance,
    ),
  );
  locator.registerLazySingleton<AboutFirebaseStorageRemoteDataSource>(
    () => AboutFirebaseStorageRemoteDataSourceImpl(
      firebaseStorage: FirebaseStorage.instance,
    ),
  );
  locator.registerLazySingleton<LocalDataSource>(
    LocalDataSourceImpl.new,
  );
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:fan2dev/core/auth_service/auth_service.dart';
import 'package:fan2dev/core/dio_client/dio_client.dart';
import 'package:fan2dev/core/firebase_client/firebase_client.dart';
import 'package:fan2dev/core/notification_service/notification_service.dart';
import 'package:fan2dev/core/shared_preferences_service/shared_preferences_service.dart';
import 'package:fan2dev/core/theme_service/theme_service.dart';
import 'package:fan2dev/features/about/data/data_sources/about_firebase_storage_remote_data_source.dart';
import 'package:fan2dev/features/backoffice/data/data_sources/backoffice_firestore_remote_data_source.dart';
import 'package:fan2dev/features/blog/data/data.dart';
import 'package:fan2dev/features/contact/data/data_sources/contact_firestore_form_submissions_remote_data_source.dart';
import 'package:fan2dev/features/projects/data/data_sources/projects_local_data_source.dart';
import 'package:fan2dev/features/search/data/data_sources/search_firestore_remote_data_source.dart';
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

  // * Auth
  locator.registerLazySingleton<AuthService>(AuthService.new);

  // * Network
  locator.registerSingleton<FirebaseClient>(
    await FirebaseClient.initFirebaseClient(),
  );
  locator.registerSingleton<DioClient>(DioClient(Dio())..initDio());

  // * Notifications
  locator.registerSingletonAsync<NotificationService>(
    NotificationService.initNotificationService,
  );

  // * Data sources
  locator
      .registerLazySingleton<ContactFirestoreFormSubmissionsRemoteDataSource>(
    () => ContactFirestoreFormSubmissionsRemoteDataSourceImpl(
      firebaseFirestore: locator<FirebaseClient>().firebaseFirestoreInstance,
    ),
  );
  locator.registerLazySingleton<AboutFirebaseStorageRemoteDataSource>(
    () => AboutFirebaseStorageRemoteDataSourceImpl(
      firebaseStorage: locator<FirebaseClient>().firebaseStorageInstance,
    ),
  );
  locator.registerLazySingleton<BlogFirestoreRemoteDataSource>(
    () => BlogFirestoreRemoteDataSourceImpl(
      firebaseFirestore: locator<FirebaseClient>().firebaseFirestoreInstance,
    ),
  );
  locator.registerLazySingleton<SearchFirestoreRemoteDataSource>(
    () => SearchFirestoreRemoteDataSourceImpl(
      firebaseFirestore: locator<FirebaseClient>().firebaseFirestoreInstance,
    ),
  );
  locator.registerLazySingleton<ProjectsLocalDataSource>(
    LocalDataSourceImpl.new,
  );
  locator.registerLazySingleton<BackofficeFirestoreRemoteDataSource>(
    () => BackofficeFirestoreRemoteDataSourceImpl(
      firebaseFirestore: locator<FirebaseClient>().firebaseFirestoreInstance,
    ),
  );
}

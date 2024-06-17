import 'package:fan2dev/core/core.dart';
import 'package:fan2dev/core/firebase_client/firebase_client.dart';
import 'package:fan2dev/features/backoffice/cubit/cubit.dart';
import 'package:fan2dev/features/backoffice/data/data_sources/backoffice_firestore_remote_data_source.dart';
import 'package:fan2dev/features/backoffice/view/widgets/bo_contact_list_widget.dart';
import 'package:fan2dev/features/backoffice/view/widgets/bo_post_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BackofficeHomePage extends StatelessWidget {
  const BackofficeHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BackofficeCubit(
            backofficeFirestoreRemoteDataSource:
                locator<BackofficeFirestoreRemoteDataSource>(),
          )..init(),
        ),
      ],
      child: const _BackofficeHomePageView(),
    );
  }
}

class _BackofficeHomePageView extends StatelessWidget {
  const _BackofficeHomePageView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              context.go('/');
            },
            heroTag: null,
            child: const Icon(Icons.home),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {
              locator<FirebaseClient>().firebaseAuthInstance.signOut();
              context.go('/');
            },
            backgroundColor: Colors.red,
            heroTag: null,
            child: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hola, ${locator<FirebaseClient>().firebaseAuthInstance.currentUser!.email!.split('@').first} 🚀',
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 20),
              Text(
                'Lista de formularios recibidos',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              const BoContactListWidget(),
              const SizedBox(height: 20),
              Text(
                'Administración de posts',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              const BoPostListWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

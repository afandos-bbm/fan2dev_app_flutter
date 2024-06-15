import 'package:fan2dev/core/core.dart';
import 'package:fan2dev/features/backoffice/cubit/cubit.dart';
import 'package:fan2dev/features/backoffice/data/data_sources/backoffice_firestore_remote_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
          )..getContactForms(),
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
              FirebaseAuth.instance.signOut();
              context.go('/');
            },
            backgroundColor: Colors.red,
            heroTag: null,
            child: const Icon(Icons.logout),
          ),
        ],
      ),
      body: FirebaseAuth.instance.currentUser!.email ==
              'alejandrofan2@gmail.com'
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hola, ${FirebaseAuth.instance.currentUser!.email!.split('@').first} 🚀',
                      style: Theme.of(context).textTheme.headlineLarge,
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Lista de formularios recibidos',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<BackofficeCubit, BackofficeCubitState>(
                      builder: (context, state) {
                        if (state.state == BackofficeCubitStates.loading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (state.state == BackofficeCubitStates.error) {
                          return Center(
                            child: Text(state.error!.errorMessage),
                          );
                        }

                        if (state.contactForms.isEmpty) {
                          return const Center(
                            child: Text('No hay formularios recibidos'),
                          );
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.contactForms.length,
                          itemBuilder: (context, index) {
                            return Card(
                              margin: const EdgeInsets.all(10),
                              elevation: 4,
                              child: ListTile(
                                title: Text(state.contactForms[index].subject),
                                subtitle: Text(state.contactForms[index].email),
                                onTap: () {
                                  showDialog<void>(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(
                                          state.contactForms[index].subject,
                                        ),
                                        content: Text(
                                          state.contactForms[index].message,
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Cerrar'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    context
                                        .read<BackofficeCubit>()
                                        .deleteContactForm(
                                          state.contactForms[index].id!,
                                        );
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Administración de posts',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
            )
          : const Center(
              child: Text('No tienes permisos para acceder a esta página'),
            ),
    );
  }
}

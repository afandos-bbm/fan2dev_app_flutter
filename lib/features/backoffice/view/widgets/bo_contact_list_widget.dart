import 'package:fan2dev/features/backoffice/cubit/backoffice_cubit/backoffice_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BoContactListWidget extends StatelessWidget {
  const BoContactListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BackofficeCubit, BackofficeCubitState>(
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
                    context.read<BackofficeCubit>().deleteContactForm(
                          state.contactForms[index].id!,
                        );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}

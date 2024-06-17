import 'package:fan2dev/core/locator/locator.dart';
import 'package:fan2dev/features/backoffice/cubit/backoffice_cubit/backoffice_cubit.dart';
import 'package:fan2dev/features/blog/domain/entities/blog_post_category.dart';
import 'package:fan2dev/utils/extensions/datetime_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BoPostListWidget extends StatelessWidget {
  const BoPostListWidget({super.key});

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

        if (state.posts.isEmpty) {
          return const Center(
            child: Text('No hay posts'),
          );
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.posts.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.all(10),
              elevation: 4,
              child: ListTile(
                title: Text(state.posts[index].title),
                subtitle: Text(
                  state.posts[index].id,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(
                        state.posts[index].isHidden
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        context.read<BackofficeCubit>().toggleHidePost(
                              state.posts[index].id,
                            );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () async {
                        await context.read<BackofficeCubit>().editPostInternal(
                              state.posts[index],
                            );

                        await showDialog<void>(
                          context: context,
                          builder: (newContext) {
                            return BlocProvider.value(
                              value: context.read<BackofficeCubit>(),
                              child: const _EditPostDialogWidget(),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _EditPostDialogWidget extends StatelessWidget {
  const _EditPostDialogWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BackofficeCubit, BackofficeCubitState>(
      builder: (context, state) {
        return AlertDialog(
          content: Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: TextEditingController(
                    text: state.post!.title,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Título',
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: TextEditingController(
                    text: state.post!.subtitle,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Subtítulo',
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 200,
                  child: TextField(
                    controller: TextEditingController(
                      text: state.post?.content,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Contenido',
                    ),
                    maxLines: null,
                    expands: true,
                    onChanged: (value) {
                      context.read<BackofficeCubit>().editPostInternal(
                            state.post!.copyWith(
                              content: value,
                            ),
                          );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField(
                  value: state.post?.category,
                  onChanged: (value) {
                    context.read<BackofficeCubit>().editPostInternal(
                          state.post!.copyWith(
                            category: value,
                          ),
                        );
                  },
                  decoration: InputDecoration(
                    labelText: 'Categoría',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  items: BlogPostCategory.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(
                            category.name.toUpperCase(),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: const Text('Cancelar'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<BackofficeCubit>()
                            .editPost();
                        context.pop();
                      },
                      child: const Text('Guardar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

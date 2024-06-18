import 'package:fan2dev/core/core.dart';
import 'package:fan2dev/core/firebase_client/firebase_client.dart';
import 'package:fan2dev/features/blog/cubit/blog_cubit/blog_cubit.dart';
import 'package:fan2dev/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPostCommentsFooter extends StatelessWidget {
  BlogPostCommentsFooter({super.key});

  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final user = locator<FirebaseClient>().firebaseAuthInstance.currentUser;

    if (user == null) {
      return const SizedBox();
    }

    return SizedBox(
      height: 50,
      child: Row(
        children: [
          const SizedBox(width: 10),
          CircleAvatar(
            radius: 20,
            backgroundImage:
                locator<FirebaseClient>().firebaseAuthInstance.currentUser !=
                        null
                    ? locator<FirebaseClient>()
                                .firebaseAuthInstance
                                .currentUser!
                                .photoURL !=
                            null
                        ? NetworkImage(
                            locator<FirebaseClient>()
                                    .firebaseAuthInstance
                                    .currentUser!
                                    .photoURL ??
                                '',
                          )
                        : null
                    : null,
            child: locator<FirebaseClient>().firebaseAuthInstance.currentUser ==
                    null
                ? const Icon(Icons.person)
                : locator<FirebaseClient>()
                            .firebaseAuthInstance
                            .currentUser!
                            .photoURL ==
                        null
                    ? const Icon(Icons.person)
                    : null,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: context.l10n.blog_post_comments_add,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    context.read<BlogCubit>().addPostComment(
                          postId: context.read<BlogCubit>().state.post!.id,
                          comment: controller.text,
                        );
                  },
                  icon: const Icon(Icons.send),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}

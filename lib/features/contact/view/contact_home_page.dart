import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fan2dev/core/locator/locator.dart';
import 'package:fan2dev/features/contact/data/data_sources/firestore_form_submissions_remote_data_source.dart';
import 'package:fan2dev/l10n/l10n.dart';
import 'package:fan2dev/utils/const.dart';
import 'package:fan2dev/utils/widgets/footer_f2d_widget.dart';
import 'package:fan2dev/utils/widgets/responsive_widget.dart';
import 'package:flutter/material.dart';

class ContactHomePage extends StatelessWidget {
  ContactHomePage({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white60,
      child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 800,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(
                              !ResponsiveWidget.isDesktop(context) ? 20 : 100),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (!ResponsiveWidget.isDesktop(context))
                                      Image.asset(
                                        kContactEmojiPath,
                                        width: 150,
                                        height: 150,
                                      ),
                                    Text(
                                      context.l10n.contact_title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                      textAlign: TextAlign.start,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      context.l10n.contact_subtitle,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  labelText: context.l10n.contact_name,
                                  prefixIcon: const Icon(Icons.person),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return context
                                        .l10n.contact_error_empty_message;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  labelText: context.l10n.contact_email,
                                  prefixIcon: const Icon(Icons.email),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return context
                                        .l10n.contact_error_empty_message;
                                  }

                                  if (!value.contains('@') &&
                                      !value.contains('.')) {
                                    return context
                                        .l10n.contact_error_invalid_email;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: _messageController,
                                decoration: InputDecoration(
                                  labelText: context.l10n.contact_message,
                                  prefixIcon: const Icon(Icons.message),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return context
                                        .l10n.contact_error_empty_message;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              Align(
                                alignment: Alignment.centerRight,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    final String name = _nameController.text;
                                    final String email = _emailController.text;
                                    final String message =
                                        _messageController.text;

                                    if (!_formKey.currentState!.validate()) {
                                      return;
                                    }

                                    final result = await locator<
                                            FirestoreFormSubmissionsRemoteDataSource>()
                                        .sendContactForm(
                                      name: name,
                                      email: email,
                                      message: message,
                                    );

                                    result.whenOrNull(
                                      success: (_) {
                                        showBottomSheet(
                                            context: context,
                                            builder: (_) {
                                              return Container(
                                                color: Colors.white,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        context.l10n
                                                            .contact_success_title,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headlineMedium,
                                                        textAlign:
                                                            TextAlign.start,
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      Text(
                                                        context.l10n
                                                            .contact_success_subtitle,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium,
                                                        textAlign:
                                                            TextAlign.start,
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(context
                                                              .l10n
                                                              .contact_success_button),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            });
                                      },
                                      failure: (error) {},
                                    );
                                  },
                                  child: Text(context.l10n.contact_send),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

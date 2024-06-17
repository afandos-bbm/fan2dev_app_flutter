import 'package:animated_toast_list/animated_toast_list.dart';
import 'package:fan2dev/core/locator/locator.dart';
import 'package:fan2dev/features/contact/data/data_sources/contact_firestore_form_submissions_remote_data_source.dart';
import 'package:fan2dev/l10n/l10n.dart';
import 'package:fan2dev/utils/utils.dart';
import 'package:fan2dev/utils/widgets/toast_widget.dart';
import 'package:flutter/material.dart';
import 'package:talker/talker.dart';

class ContactHomePage extends StatelessWidget {
  ContactHomePage({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
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
                        !ResponsiveWidget.isDesktop(context) ? 20 : 100,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
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
                                  style: Theme.of(context).textTheme.bodyMedium,
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
                                return context.l10n.contact_error_empty_message;
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
                                return context.l10n.contact_error_empty_message;
                              }

                              if (!value.contains('@') &&
                                  !value.contains('.')) {
                                return context.l10n.contact_error_invalid_email;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 150,
                            child: TextFormField(
                              controller: _messageController,
                              // make new line when enter is pressed
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                labelText: context.l10n.contact_message,
                                prefixIcon: const Icon(Icons.message),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return context
                                      .l10n.contact_error_empty_message;
                                }

                                if (value.length > 1000) {
                                  return context
                                      .l10n.contact_error_message_too_long;
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: () async {
                                FocusScope.of(context).unfocus();

                                final name = _nameController.text;
                                final email = _emailController.text;
                                final message = _messageController.text;

                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }

                                final result = await locator<
                                        ContactFirestoreFormSubmissionsRemoteDataSource>()
                                    .sendContactForm(
                                  name: name,
                                  email: email,
                                  message: message,
                                );

                                result.when(
                                  success: (_) {
                                    _nameController.clear();
                                    _emailController.clear();
                                    _messageController.clear();
                                    context.showToast(
                                      ToastModel(
                                        message:
                                            '${context.l10n.contact_success_title} ${context.l10n.contact_success_subtitle}',
                                        type: ToastType.success,
                                      ),
                                    );
                                  },
                                  failure: (error) {
                                    context.showToast(
                                      ToastModel(
                                        message: error.toString(),
                                        type: ToastType.error,
                                      ),
                                    );
                                    l(
                                      error.toString(),
                                      level: LogLevel.error,
                                      exception: error,
                                      stackTrace: StackTrace.current,
                                      name: 'sendContactForm',
                                    );
                                  },
                                  empty: () {
                                    _nameController.clear();
                                    _emailController.clear();
                                    _messageController.clear();
                                    context.showToast(
                                      ToastModel(
                                        message:
                                            '${context.l10n.contact_success_title} ${context.l10n.contact_success_subtitle}',
                                        type: ToastType.success,
                                      ),
                                    );
                                  },
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
      ),
    );
  }
}

import 'package:fan2dev/l10n/l10n.dart';
import 'package:fan2dev/utils/const.dart';
import 'package:fan2dev/utils/theme/themes.dart';
import 'package:fan2dev/utils/widgets/footer_f2d_widget.dart';
import 'package:flutter/material.dart';

class ContactHomePage extends StatelessWidget {
  const ContactHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white60,
      child: Form(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        kContactEmojiPath,
                        width: 150,
                        height: 150,
                      ),
                      Text(
                        context.l10n.contact_title,
                        style: Theme.of(context).textTheme.headlineMedium,
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
                const SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: context.l10n.contact_name,
                    prefixIcon: const Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: context.l10n.contact_email,
                    prefixIcon: const Icon(Icons.email),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: context.l10n.contact_message,
                    prefixIcon: const Icon(Icons.message),
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(context.l10n.contact_send),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          const FooterF2DWidget(),
          const SizedBox(height: 40),
        ],
      )),
    );
  }
}

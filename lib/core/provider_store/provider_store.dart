import 'package:fan2dev/features/about/cubit/about_cubit/about_cubit.dart';
import 'package:fan2dev/features/language/language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Class whose purpose is to centralize, init and inject common providers.
class BlocProviderStore {
  static Widget init({required Widget child}) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => LanguageCubit()..loadLanguagePreference(),
        ),
        BlocProvider(
          create: (_) => AboutCubit()..loadImages(),
        ),
      ],
      child: child,
    );
  }
}

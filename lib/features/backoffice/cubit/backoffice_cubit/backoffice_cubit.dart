import 'package:equatable/equatable.dart';
import 'package:fan2dev/features/backoffice/data/data.dart';
import 'package:fan2dev/features/blog/domain/domain.dart';
import 'package:fan2dev/features/contact/domain/entities/contact_form/contact_form.dart';
import 'package:fan2dev/utils/errors/error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'backoffice_cubit_state.dart';

class BackofficeCubit extends Cubit<BackofficeCubitState> {
  BackofficeCubit({
    required this.backofficeFirestoreRemoteDataSource,
  }) : super(const BackofficeCubitState());

  final BackofficeFirestoreRemoteDataSource backofficeFirestoreRemoteDataSource;

  Future<void> getContactForms() async {
    emit(state.copyWith(state: BackofficeCubitStates.loading));
    final result = await backofficeFirestoreRemoteDataSource.getContactForms();
    result.when(
      success: (contactForms) {
        emit(
          state.copyWith(
            state: BackofficeCubitStates.loaded,
            contactForms: contactForms,
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            state: BackofficeCubitStates.error,
            error: BusinessAppError.generic(
              errorCode: ErrorCodes.generic,
              errorMessage: error.toString(),
              stackTrace: StackTrace.current,
            ),
          ),
        );
      },
      empty: () {
        emit(
          state.copyWith(
            state: BackofficeCubitStates.loaded,
            contactForms: [],
          ),
        );
      },
    );
  }

  Future<void> deleteContactForm(String id) async {
    emit(state.copyWith(state: BackofficeCubitStates.loading));
    final result =
        await backofficeFirestoreRemoteDataSource.deleteContactForm(id);
    result.when(
      success: (_) {
        emit(
          state.copyWith(
            state: BackofficeCubitStates.loaded,
            contactForms: state.contactForms
                .where((contactForm) => contactForm.id != id)
                .toList(),
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            state: BackofficeCubitStates.error,
            error: BusinessAppError.generic(
              errorCode: ErrorCodes.generic,
              errorMessage: error.toString(),
              stackTrace: StackTrace.current,
            ),
          ),
        );
      },
      empty: () {
        emit(
          state.copyWith(
            state: BackofficeCubitStates.loaded,
            contactForms: state.contactForms
                .where((contactForm) => contactForm.id != id)
                .toList(),
          ),
        );
      },
    );
  }
}

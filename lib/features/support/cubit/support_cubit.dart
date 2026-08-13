import 'package:bookstore/core/networking/api_error_handler.dart';
import 'package:bookstore/features/support/data/support_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'support_state.dart';

class SupportCubit extends Cubit<SupportState> {
  SupportCubit({SupportRepo? repo})
    : _repo = repo ?? SupportRepo(),
      super(const SupportState());
  final SupportRepo _repo;

  void toggleFaq(int index) => emit(
    state.expandedFaqIndex == index
        ? state.copyWith(clearExpandedFaq: true)
        : state.copyWith(expandedFaqIndex: index),
  );

  Future<void> loadFaqs() async {
    if (state.isLoadingFaqs) return;
    emit(state.copyWith(isLoadingFaqs: true, clearError: true));
    try {
      emit(state.copyWith(faqs: await _repo.getFaqs(), isLoadingFaqs: false));
    } catch (error) {
      emit(
        state.copyWith(
          isLoadingFaqs: false,
          error: ApiErrorHandler.getMessage(error),
        ),
      );
    }
  }

  Future<bool> sendMessage({
    required String name,
    required String email,
    required String message,
  }) async {
    if (!_validate(name, email, message) || state.isSubmitting) return false;
    emit(
      state.copyWith(isSubmitting: true, clearError: true, submitted: false),
    );
    try {
      await _repo.sendMessage(
        name: name.trim(),
        email: email.trim(),
        message: message.trim(),
      );
      emit(state.copyWith(isSubmitting: false, submitted: true));
      return true;
    } catch (error) {
      emit(
        state.copyWith(
          isSubmitting: false,
          error: ApiErrorHandler.getMessage(error),
        ),
      );
      return false;
    }
  }

  bool _validate(String name, String email, String message) {
    if (name.trim().isEmpty || email.trim().isEmpty || message.trim().isEmpty) {
      emit(state.copyWith(validationMessage: 'complete_all_fields'));
      return false;
    }
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email.trim())) {
      emit(state.copyWith(validationMessage: 'enter_valid_email'));
      return false;
    }
    emit(state.copyWith(clearValidationMessage: true));
    return true;
  }
}

import 'package:equatable/equatable.dart';
import 'package:bookstore/features/support/data/support_repo.dart';

class SupportState extends Equatable {
  final int? expandedFaqIndex;
  final bool isSubmitting;
  final String? validationMessage;
  final List<FaqItem> faqs;
  final bool isLoadingFaqs;
  final String? error;
  final bool submitted;

  const SupportState({
    this.expandedFaqIndex,
    this.isSubmitting = false,
    this.validationMessage,
    this.faqs = const [],
    this.isLoadingFaqs = false,
    this.error,
    this.submitted = false,
  });

  SupportState copyWith({
    int? expandedFaqIndex,
    bool clearExpandedFaq = false,
    bool? isSubmitting,
    String? validationMessage,
    bool clearValidationMessage = false,
    List<FaqItem>? faqs,
    bool? isLoadingFaqs,
    String? error,
    bool clearError = false,
    bool? submitted,
  }) {
    return SupportState(
      expandedFaqIndex: clearExpandedFaq
          ? null
          : expandedFaqIndex ?? this.expandedFaqIndex,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      validationMessage: clearValidationMessage
          ? null
          : validationMessage ?? this.validationMessage,
      faqs: faqs ?? this.faqs,
      isLoadingFaqs: isLoadingFaqs ?? this.isLoadingFaqs,
      error: clearError ? null : error ?? this.error,
      submitted: submitted ?? this.submitted,
    );
  }

  @override
  List<Object?> get props => [
    expandedFaqIndex,
    isSubmitting,
    validationMessage,
    faqs,
    isLoadingFaqs,
    error,
    submitted,
  ];
}

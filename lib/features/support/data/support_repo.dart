import 'package:bookstore/core/networking/api_constants.dart';
import 'package:bookstore/core/networking/dio_service.dart';

class FaqItem {
  final int id;
  final String question;
  final String answer;
  const FaqItem({
    required this.id,
    required this.question,
    required this.answer,
  });
  factory FaqItem.fromJson(Map<String, dynamic> json) => FaqItem(
    id: json['id'] is int
        ? json['id'] as int
        : int.tryParse('${json['id']}') ?? 0,
    question: json['question']?.toString() ?? '',
    answer: json['answer']?.toString() ?? '',
  );
}

class SupportRepo {
  Future<List<FaqItem>> getFaqs() async {
    final response = await DioService.dio.get(ApiConstants.faqs);
    final data = response.data is Map ? response.data['data'] : null;
    final raw = data is Map ? data['faqs'] : null;
    return (raw is List ? raw : const [])
        .whereType<Map>()
        .map((item) => FaqItem.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }

  Future<void> sendMessage({
    required String name,
    required String email,
    required String message,
  }) async {
    await DioService.dio.post(
      ApiConstants.contactUs,
      data: {
        'name': name,
        'email': email,
        'subject': 'Bookia support request',
        'message': message,
      },
    );
  }
}

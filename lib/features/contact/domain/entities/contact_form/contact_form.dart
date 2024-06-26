import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contact_form.g.dart';

@JsonSerializable()
class ContactForm extends Equatable {
  const ContactForm({
    required this.email,
    required this.subject,
    required this.message,
    required this.createdAt,
    this.id,
    this.viewed = false,
  });

  factory ContactForm.fromJson(Map<String, dynamic> json) =>
      _$ContactFormFromJson(json);

  Map<String, dynamic> toJson() => _$ContactFormToJson(this);

  @JsonKey(includeToJson: false)
  final String? id;
  final String email;
  final String subject;
  final String message;
  final bool viewed;
  final String createdAt;

  @override
  List<Object?> get props => [id, email, subject, message, viewed, createdAt];
}

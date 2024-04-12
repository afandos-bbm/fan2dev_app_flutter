import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum BlogPostCategory {
  @JsonValue('TECHNOLOGY')
  technology,
  @JsonValue('DESIGN')
  design,
  @JsonValue('BUSINESS')
  business,
  @JsonValue('ENTERTAINMENT')
  entertainment,
  @JsonValue('HEALTH')
  health,
  @JsonValue('SCIENCE')
  science,
  @JsonValue('SPORTS')
  sports,
  @JsonValue('EDUCATION')
  education,
  @JsonValue('TRAVEL')
  travel,
  @JsonValue('LIFESTYLE')
  lifestyle,
  @JsonValue('OTHER')
  other,
}

extension BlogPostCategoryX on BlogPostCategory {
  String get name {
    switch (this) {
      case BlogPostCategory.technology:
        return 'Technology';
      case BlogPostCategory.design:
        return 'Design';
      case BlogPostCategory.business:
        return 'Business';
      case BlogPostCategory.entertainment:
        return 'Entertainment';
      case BlogPostCategory.health:
        return 'Health';
      case BlogPostCategory.science:
        return 'Science';
      case BlogPostCategory.sports:
        return 'Sports';
      case BlogPostCategory.education:
        return 'Education';
      case BlogPostCategory.travel:
        return 'Travel';
      case BlogPostCategory.lifestyle:
        return 'Lifestyle';
      case BlogPostCategory.other:
        return 'Other';
    }
  }
}

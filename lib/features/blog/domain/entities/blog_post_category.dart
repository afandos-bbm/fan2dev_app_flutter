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
  @JsonValue('EDUCATION')
  education,
  @JsonValue('OTHER')
  other,
  @JsonValue('ALL')
  all,
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
      case BlogPostCategory.education:
        return 'Education';
      case BlogPostCategory.other:
        return 'Other';
      case BlogPostCategory.all:
        return 'All';
    }
  }

  String get imageUrl {
    switch (this) {
      case BlogPostCategory.technology:
        return 'assets/images/blog/categories/technology.jpg';
      case BlogPostCategory.design:
        return 'assets/images/blog/categories/design.jpg';
      case BlogPostCategory.business:
        return 'assets/images/blog/categories/business.jpg';
      case BlogPostCategory.entertainment:
        return 'assets/images/blog/categories/entertainment.jpg';
      case BlogPostCategory.health:
        return 'assets/images/blog/categories/health.jpg';
      case BlogPostCategory.education:
        return 'assets/images/blog/categories/education.jpg';
      case BlogPostCategory.other:
        return 'assets/images/blog/categories/other.jpg';
      case BlogPostCategory.all:
        return 'assets/images/blog/categories/all.jpg';
    }
  }

  String get value {
    switch (this) {
      case BlogPostCategory.technology:
        return 'TECHNOLOGY';
      case BlogPostCategory.design:
        return 'DESIGN';
      case BlogPostCategory.business:
        return 'BUSINESS';
      case BlogPostCategory.entertainment:
        return 'ENTERTAINMENT';
      case BlogPostCategory.health:
        return 'HEALTH';
      case BlogPostCategory.education:
        return 'EDUCATION';
      case BlogPostCategory.other:
        return 'OTHER';
      case BlogPostCategory.all:
        return 'ALL';
    }
  }
}

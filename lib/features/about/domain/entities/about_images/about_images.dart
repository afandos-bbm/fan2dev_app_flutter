import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'about_images.g.dart';

@JsonSerializable()
class AboutImages extends Equatable {
  const AboutImages({
    this.carrouselImagesUrls = const [],
    this.headerImageUrl,
    this.flutterDashImageUrl,
  });

  factory AboutImages.fromJson(Map<String, dynamic> json) =>
      _$AboutImagesFromJson(json);

  final List<String> carrouselImagesUrls;
  final String? headerImageUrl;
  final String? flutterDashImageUrl;

  Map<String, dynamic> toJson() => _$AboutImagesToJson(this);

  @override
  List<Object?> get props =>
      [carrouselImagesUrls, headerImageUrl, flutterDashImageUrl];
}

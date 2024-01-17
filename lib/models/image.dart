class Image {
  final String imagePath;
  Image({
    required this.imagePath,
  });

  Image.fromJson(Map<String, dynamic> json) : imagePath = json['image_path'];
}

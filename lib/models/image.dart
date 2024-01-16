class ImageP {
  final String imagePath;
  ImageP({
    required this.imagePath,
  });

  ImageP.fromJson(Map<String, dynamic> json) : imagePath = json['image_path'];
}

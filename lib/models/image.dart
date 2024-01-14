class ImageI {
  final String imagePath;

  ImageI(this.imagePath);

  ImageI.fromJson(Map<String, dynamic> json) : imagePath = json['image_path'];
}

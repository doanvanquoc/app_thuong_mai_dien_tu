class ImageI {
  int imageID;
  final String imagePath;
  final int productID;
  ImageI({
    required this.imageID,
    required this.imagePath,
    required this.productID,
  });

  // ImageI.fromJson(Map<String, dynamic> json) : imagePath = json['image_path'];
}

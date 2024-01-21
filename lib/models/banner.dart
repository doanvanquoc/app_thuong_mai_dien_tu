class Banner {
  final int bannerID;
  final String image;
  Banner({required this.bannerID, required this.image});
  Banner.fromJson(Map<String, dynamic> json)
      : bannerID = json['bannerID'],
        image = json['image'];
}

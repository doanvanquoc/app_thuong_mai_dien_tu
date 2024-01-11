class Content {
  String image;
  String title;
  String discription;
  String ckc;

  Content({required this.image, required this.title, required this.discription,required this.ckc});
}

List<Content> contents = [
  Content(
    image: 'assets/images/iphone15_3.png', 
    title: 'Welcome to 👋',
    discription:'Shop bán điện thoại rẻ nhất hành tinh, xịn nhất hệ mặt trời',
    ckc: 'CKC'
  ),
  Content(
    title: 'Chúng tôi cung cấp cho bạn những sản phẩm chất lượng',
    image: 'assets/images/iphone15_3.png',
    discription: '',
    ckc: ''
  ),
  Content(
    title: 'Sự hài lòng của bạn là ưu tiên số một của chúng tôi',
    image: 'assets/images/iphone15_3.png',
    discription: '',
    ckc: ''
  ),
  Content(
    title: 'Chất lượng là niềm tự hào, dịch vụ là cam kết',
    image: 'assets/images/iphone15_3.png',
    discription: '',
    ckc: ''
  ),
];
  
  
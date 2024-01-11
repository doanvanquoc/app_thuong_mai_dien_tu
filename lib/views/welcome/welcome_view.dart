import 'package:app_thuong_mai_dien_tu/resources/widgets/my_button.dart';
import 'package:app_thuong_mai_dien_tu/views/login/login_view.dart';
import 'package:app_thuong_mai_dien_tu/views/welcome/widgets/content.dart';
import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  int currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: contents.length,
        onPageChanged: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        itemBuilder: (_, i) {
          return Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Image(
                  image: AssetImage(contents[i].image),
                  fit: BoxFit.cover,
                  height: 300,
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  contents[i].title,
                  style: const TextStyle(
                    color: Color(0xFF212121),
                    fontSize: 30,
                    fontFamily: 'Sarabun',
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (i == 0)
                  Text(
                    contents[i].ckc,
                    style: const TextStyle(
                      color: Color(0xFF01B763),
                      fontSize: 70,
                      fontFamily: 'Sarabun',
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                if (i == 0)
                  Text(
                    contents[i].discription,
                    style: const TextStyle(
                      color: Color(0xFF424242),
                      fontSize: 20,
                      fontFamily: 'Sarabun',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                const SizedBox(height: 80),
                if (i != 0)
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        contents.length - 1,
                        (index) => buildDot(index + 1, context),
                      ),
                    ),
                  ),
                const SizedBox(height: 20),
                if (i != 0 && i != 3)
                  MyButton(
                    onTap: () {
                      _pageController.animateToPage(
                        i + 1,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    content: 'Tiếp theo',
                  ),
                if (i == 3)
                  MyButton(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()),
                          (route) => route is Login,
                        );
                      },
                      content: 'Đăng nhập'),
              ],
            ),
          );
        },
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xff109C5B),
      ),
    );
  }
}

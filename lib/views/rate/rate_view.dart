import 'package:app_thuong_mai_dien_tu/views/rate/widgets/rate_content.dart';
import 'package:app_thuong_mai_dien_tu/views/rate/widgets/rate_option.dart';
import 'package:flutter/material.dart';

class RatePage extends StatefulWidget {
  const RatePage({super.key});

  @override
  State<RatePage> createState() => _RatePageState();
}

class _RatePageState extends State<RatePage> {
  String checkRate = "";
  List<String> ratelst = [
    'Tất cả',
    '5',
    '4',
    '3',
    '2',
    '1',
  ];
  void checkOption(value) {
    setState(() {
      checkRate = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "4.9(4,749 đánh giá)",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            RateOption(lst: ratelst, onTap: checkOption),
            Expanded(
                child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: (_, index) {
                      return const RateContent();
                    }))
          ],
        ),
      ),
    );
  }
}

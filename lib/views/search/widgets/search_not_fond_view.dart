import 'package:flutter/material.dart';

class SearchNotFound extends StatefulWidget {
  const SearchNotFound({super.key, required this.reslutSearchTextController});
  final String reslutSearchTextController;
  @override
  State<SearchNotFound> createState() => _SearchNotFoundState();
}

class _SearchNotFoundState extends State<SearchNotFound> {
  TextEditingController searchTextController = TextEditingController();

  List searchLst = [
    'Iphone 15',
    'Iphone 13',
    'Iphone 11',
    'Samsung galaxy S23 Ultra'
  ];
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: const Column(
          children: [
            // const SizedBox(height: 60),
            // TextField(
            //   onSubmitted: (value) {
            //     setState(() {
            //       reslutSearchTextController = value;
            //     });
            //   },
            //   controller: searchTextController,
            //   decoration: InputDecoration(
            //     hintText: 'Tìm kiếm...',
            //     hintStyle: const TextStyle(color: Colors.grey),
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(16),
            //       borderSide: BorderSide.none,
            //     ),
            //     fillColor: Colors.grey.shade200,
            //     filled: true,
            //     prefixIcon: IconButton(
            //       onPressed: () {},
            //       icon: const Icon(
            //         Icons.search,
            //         color: Colors.grey,
            //       ),
            //     ),
            //     suffixIcon: IconButton(
            //       onPressed: () {},
            //       icon: const Icon(
            //         Icons.filter_list_sharp,
            //         color: Colors.amber,
            //       ),
            //     ),
            //   ),
            // ),

            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 100),
                  Icon(
                    Icons.find_in_page,
                    size: 200,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Không tìm thấy",
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(height: 12),
                  Text(
                    textAlign: TextAlign.center,
                    "Chúng tôi rất tiếc, từ khóa bạn tìm không thấy kết quả nào. Vui lòng kiểm tra lại hoặc tìm kiếm với từ khóa khác.",
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}

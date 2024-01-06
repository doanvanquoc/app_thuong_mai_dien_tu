import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InfoProductDetail extends StatefulWidget {
  InfoProductDetail({
    super.key,
    required this.description,
    required this.name,
    required this.count,
    required this.IncrQuanlity,
    required this.DecrQuanlity,
  });
  final String name;
  final description;
  int count;
  Function IncrQuanlity;
  Function DecrQuanlity;

  @override
  State<InfoProductDetail> createState() => _InfoProductDetailState();
}

class _InfoProductDetailState extends State<InfoProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2.0,
      bottom: 0,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.name,
                      style: const TextStyle(
                          fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite, size: 28),
                  )
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Container(
                    width: 80,
                    height: 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: const Color.fromARGB(255, 212, 249, 232),
                    ),
                    child: const Center(
                      child: Text(
                        '3,284 đã bán',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFF01B763),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Icon(Icons.star, size: 20),
                  const SizedBox(width: 8),
                  const Text('4.9 (4,749 đánh giá)',
                      style: TextStyle(fontSize: 14))
                ],
              ),
              const Divider(),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Text(
                  "Mô tả",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                widget.description,
                style: const TextStyle(
                  fontSize: 14,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Text(
                    "Số lượng",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    width: 139,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: const Color.fromARGB(255, 248, 248, 248),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            onPressed: () {
                              widget.DecrQuanlity();
                            },
                            icon: const Icon(
                              Icons.remove,
                              color: Color(0xFF01B763),
                            )),
                        Text(
                          '${widget.count} ',
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF01B763)),
                        ),
                        IconButton(
                          onPressed: () {
                            widget.IncrQuanlity();
                          },
                          icon: const Icon(
                            Icons.add,
                            color: Color(0xFF01B763),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider()
            ],
          ),
        ),
      ),
    );
  }
}

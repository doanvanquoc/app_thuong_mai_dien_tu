import 'package:app_thuong_mai_dien_tu/views/rate/rate_view.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InfoProductDetail extends StatefulWidget {
  InfoProductDetail({
    super.key,
    required this.description,
    required this.name,
    required this.rate,
    required this.sold,
    required this.count,
    required this.incrQuanlity,
    required this.decrQuanlity,
  });
  final String name;
  final String description;
  final String rate;
  final String sold;
  int count;
  Function incrQuanlity;
  Function decrQuanlity;

  @override
  State<InfoProductDetail> createState() => _InfoProductDetailState();
}

class _InfoProductDetailState extends State<InfoProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2.4,
      bottom: 62,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
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
                    child: Center(
                      child: Text(
                        widget.sold,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFF01B763),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Icon(Icons.star, size: 20),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const RatePage()));
                    },
                    child: Text(
                      widget.rate,
                      style: const TextStyle(fontSize: 14),
                    ),
                  )
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
              Text(
                widget.description,
                style: const TextStyle(
                  fontSize: 14,
                ),
                textAlign: TextAlign.justify,
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
                              widget.decrQuanlity();
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
                            widget.incrQuanlity();
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
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}

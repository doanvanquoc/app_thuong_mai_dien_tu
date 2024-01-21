import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class Avatar extends StatefulWidget {
  Avatar({Key? key, required this.src, required this.onImageSelected})
      : super(key: key);

  String src;
  final Function(File?) onImageSelected;

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  File? image;

  Future pickImage() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedImage == null) return;

      final imageTemporary = File(pickedImage.path);
      setState(() {
        image = imageTemporary;
      });

      // Invoke the callback to pass the selected image file to the parent widget
      widget.onImageSelected(imageTemporary);
    } on PlatformException catch (e) {
      print('Không thể chọn hình ảnh: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                width: 150,
                height: 150,
                child: ClipRRect(
                  clipBehavior: Clip.hardEdge,
                  borderRadius: BorderRadius.circular(100),
                  child: image == null
                      ? Image(
                          image: NetworkImage(widget.src),
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          image!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.transparent,
                    border: Border.all(
                      color: Colors.green,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.green,
                    border: Border.all(
                      color: Colors.green,
                      width: 2.0,
                    ),
                  ),
                  child: IconButton(
                    onPressed: () => pickImage(),
                    icon: const Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

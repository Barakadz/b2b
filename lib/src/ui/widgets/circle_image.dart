import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CircleProfile extends StatelessWidget {
  const CircleProfile({Key? key, this.image, this.imaged, this.size})
      : super(key: key);

  final XFile? image;
  final bool? imaged;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size! / 2 + 3,
      backgroundColor: Colors.white,
      child: !imaged!
          ? CircleAvatar(
              backgroundColor: Colors.white,
              radius: size! / 2,
              child: Icon(
                Icons.account_circle_rounded,
                size: size,
                color: const Color.fromARGB(109, 106, 55, 153),
              ),
            )
          : CircleAvatar(
              radius: size! / 2,
              backgroundColor: Colors.white,
              child: Container(
                height: size,
                width: size,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: Image.file(File(image!.path)).image,
                      fit: BoxFit.cover,
                    )),
              ),
            ),
    );
  }
}

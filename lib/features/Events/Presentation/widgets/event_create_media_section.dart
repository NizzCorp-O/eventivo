import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MediaSection extends StatelessWidget {
  final XFile mediaUrl;
  final void Function()? onTap;
  final void Function()? onView;
  const MediaSection({
    super.key,
    required this.mediaUrl,
    this.onTap,
    this.onView,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none, // ov
      children: [
        InkWell(
          autofocus: false,
          onTap: onView,
          child: Container(
            width: 100,
            height: 100,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              image: DecorationImage(
                image: FileImage(File(mediaUrl.path)),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          right: 16.5,
          top: 0,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(6),
              child: const Icon(Icons.close, size: 16, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

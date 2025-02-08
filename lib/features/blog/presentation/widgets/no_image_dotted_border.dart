import 'package:blog_app/core/helper_extention/media_query_extention.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class NoImageDottedBorder extends StatelessWidget {
  const NoImageDottedBorder({super.key});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: AppPallete.borderColor,
      dashPattern: [10, 4],
      borderType: BorderType.RRect,
      strokeCap: StrokeCap.round,
      radius: const Radius.circular(10),
      child: SizedBox(
        height: 150,
        width: context.screenWidth,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.folder_open, size: 40),
            SizedBox(height: 15),
            Text(
              'Select your image',
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}

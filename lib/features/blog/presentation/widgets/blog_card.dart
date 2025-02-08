import 'dart:ui';

import 'package:blog_app/core/helper_extention/media_query_extention.dart';
import 'package:blog_app/core/utils/calculate_reading_time.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_topics.dart';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  const BlogCard({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16).copyWith(bottom: 0),
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Blur(
              blur: 5,
              blurColor: Colors.black,
              child: Image.network(
                blog.imageUrl,
                width: context.screenWidth,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlogTopics(
                  scrollPhysics: const NeverScrollableScrollPhysics(),
                  blogTopics: blog.topics,
                ),
                const SizedBox(height: 10),
                Text(
                  blog.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.white, // Ensures visibility
                  ),
                ),
                const Spacer(),
                Text(
                  '${calculateReadingTime(blog.content)} min',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

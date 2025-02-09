import 'package:blog_app/core/helper_extention/media_query_extention.dart';
import 'package:blog_app/core/helper_extention/navigator_extention.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/calculate_reading_time.dart';
import 'package:blog_app/core/utils/formate_date.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:flutter/material.dart';

class BlogViewPage extends StatefulWidget {
  final Blog blog;
  const BlogViewPage({super.key, required this.blog});

  @override
  State<BlogViewPage> createState() => _BlogViewPageState();
}

class _BlogViewPageState extends State<BlogViewPage> {
  final ScrollController _scrollController = ScrollController();
  double appBarTitleOpacity = 0.0;
  double blogTitleOpacity = 1.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    double offset = _scrollController.offset;
    double maxScroll = 100; // Adjust this value for smooth transition

    double newAppBarOpacity = (offset / maxScroll).clamp(0.0, 1.0);
    double newBlogTitleOpacity = (1 - offset / maxScroll).clamp(0.0, 1.0);

    setState(() {
      appBarTitleOpacity = newAppBarOpacity;
      blogTitleOpacity = newBlogTitleOpacity;
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        forceMaterialTransparency: true,
        title: Opacity(
          opacity: appBarTitleOpacity,
          child: Text(
            widget.blog.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      body: Scrollbar(
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Opacity(
                  opacity: blogTitleOpacity,
                  child: Text(
                    widget.blog.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'By ${widget.blog.posterName}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 16),
                ),
                Text(
                  '${formatDate(widget.blog.updatedAt)} · '
                  '${calculateReadingTime(widget.blog.content)} min',
                  style: const TextStyle(color: AppPallete.greyColor),
                ),
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    widget.blog.imageUrl,
                    width: context.screenWidth,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 40),
                Text(widget.blog.content),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

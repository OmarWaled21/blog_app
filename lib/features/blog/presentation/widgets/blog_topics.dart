import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class BlogTopics extends StatelessWidget {
  final List<String>? selectedTopics;
  final Function(String)? onTopicSelected;
  final ScrollPhysics scrollPhysics;
  final List<String>? blogTopics;
  const BlogTopics({
    super.key,
    this.selectedTopics,
    this.onTopicSelected,
    this.scrollPhysics = const AlwaysScrollableScrollPhysics(),
    this.blogTopics,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> topics = blogTopics ??
        [
          'Technology',
          'Business',
          'Programming',
          'Entertainment',
        ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: scrollPhysics,
      child: Row(
        children: topics
            .map(
              (topic) => Padding(
                padding: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                  onTap: () => onTopicSelected?.call(topic),
                  child: Chip(
                    label: Text(topic),
                    color: (selectedTopics ?? []).contains(topic)
                        ? const WidgetStatePropertyAll(AppPallete.gradient1)
                        : null,
                    side: (selectedTopics ?? []).contains(topic)
                        ? null
                        : const BorderSide(
                            color: AppPallete.borderColor,
                          ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

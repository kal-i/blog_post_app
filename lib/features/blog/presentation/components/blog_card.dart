import 'package:blog_posting_app/config/theme/app_color.dart';
import 'package:blog_posting_app/core/utils/calculate_reading_time.dart';
import 'package:blog_posting_app/features/blog/domain/entities/blog.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  const BlogCard({
    super.key,
    required this.blog,
    required this.color,
  });

  final BlogEntity blog;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      margin: const EdgeInsets.all(
        15.0,
      ).copyWith(
        bottom: 5.0,
      ),
      padding: const EdgeInsets.all(
        15.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: color,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: blog.topics
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Chip(
                            label: Text(e),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              Text(
                blog.title,
                style: const TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Text(
            '${calculateReadingTime(content: blog.content)} min',
          ),
        ],
      ),
    );
  }
}

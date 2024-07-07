import 'package:flutter/material.dart';
import 'package:flutter_blog_app/core/theme/app_palette.dart';
import 'package:flutter_blog_app/core/utils/calc_reading_time.dart';
import 'package:flutter_blog_app/features/blog/domain/entities/blog.dart';
import 'package:intl/intl.dart';

class BlogViewerPage extends StatelessWidget {
  static route(Blog blog) {
    return MaterialPageRoute(
      builder: (context) => BlogViewerPage(
        blog: blog,
      ),
    );
  }

  final Blog blog;
  const BlogViewerPage({
    super.key,
    required this.blog,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.title,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 16),
                Text('By ${blog.posterName}'),
                Text(
                  '${DateFormat.yMMMd().format(blog.updatedAt)} - ${calcReadingTime(blog.content)} min',
                  style: const TextStyle(
                    color: AppPalette.greyColor,
                  ),
                ),
                const SizedBox(height: 16),
                ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(blog.imageUrl)),
                const SizedBox(height: 30),
                Text(
                  blog.content,
                  style: const TextStyle(height: 2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

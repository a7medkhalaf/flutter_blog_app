import 'package:flutter/material.dart';
import 'package:flutter_blog_app/features/blog/presentation/pages/add_blog_page.dart';

class BlogPage extends StatelessWidget {
  static route() => MaterialPageRoute(builder: (context) => const BlogPage());
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () {
              Navigator.of(context).push(AddBlogPage.route());
            },
          ),
        ],
      ),
    );
  }
}

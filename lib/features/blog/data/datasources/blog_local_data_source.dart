import 'package:flutter_blog_app/features/blog/data/models/blog_model.dart';
import 'package:hive/hive.dart';

abstract interface class IBlogLocalDataSource {
  void uploadLocalBlogs({required List<BlogModel> blogs});
  List<BlogModel> loadBlogs();
}

class BlogLocalDataSource implements IBlogLocalDataSource {
  final Box box;
  const BlogLocalDataSource(this.box);

  @override
  List<BlogModel> loadBlogs() {
    List<BlogModel> blogs = [];
    for (int i = 0; i < box.length; i++) {
      blogs.add(BlogModel.fromJson(
          Map<String, dynamic>.from(box.get(i) as Map<dynamic, dynamic>)));
    }
    return blogs;
  }

  @override
  void uploadLocalBlogs({required List<BlogModel> blogs}) async {
    await box.clear();
    await box.addAll(blogs.map((e) => e.toJson()));
  }
}

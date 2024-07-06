import 'dart:io';

import 'package:flutter_blog_app/core/error/exceptions.dart';
import 'package:flutter_blog_app/features/blog/data/models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class IBlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blog);
  Future<String> uploadBlogImage(File file, BlogModel blog);
}

class BlogRemoteDataSource implements IBlogRemoteDataSource {
  SupabaseClient supabaseClient;
  BlogRemoteDataSource(this.supabaseClient);

  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final blogData =
          await supabaseClient.from('blogs').insert(blog.toJson()).select();
      return BlogModel.fromJson(blogData.first);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage(File file, BlogModel blog) async {
    try {
      await supabaseClient.storage.from('blog_images').upload(blog.id, file);
      return supabaseClient.storage.from('blog_images').getPublicUrl(blog.id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}

import 'dart:developer';
import 'dart:io';

import 'package:flutter_blog_app/core/error/exceptions.dart';
import 'package:flutter_blog_app/core/error/failure.dart';
import 'package:flutter_blog_app/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:flutter_blog_app/features/blog/data/models/blog_model.dart';
import 'package:flutter_blog_app/features/blog/domain/entities/blog.dart';
import 'package:flutter_blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepository implements IBlogRepository {
  final IBlogRemoteDataSource blogRemoteDataSource;
  BlogRepository(this.blogRemoteDataSource);

  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File file,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async {
    try {
      BlogModel blog = BlogModel(
        id: const Uuid().v1(),
        posterId: posterId,
        title: title,
        content: content,
        imageUrl: '',
        topics: topics,
        updatedAt: DateTime.now(),
      );
      final imageUrl = await blogRemoteDataSource.uploadBlogImage(file, blog);
      blog = blog.copyWith(imageUrl: imageUrl);
      BlogModel updatedBlog = await blogRemoteDataSource.uploadBlog(blog);
      return right(updatedBlog);
    } on ServerException catch (e) {
      log(e.message);
      return left(Failure(e.toString()));
    }
  }
}

import 'dart:developer';
import 'dart:io';

import 'package:flutter_blog_app/core/error/exceptions.dart';
import 'package:flutter_blog_app/core/error/failure.dart';
import 'package:flutter_blog_app/core/network/connection_checker.dart';
import 'package:flutter_blog_app/features/blog/data/datasources/blog_local_data_source.dart';
import 'package:flutter_blog_app/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:flutter_blog_app/features/blog/data/models/blog_model.dart';
import 'package:flutter_blog_app/features/blog/domain/entities/blog.dart';
import 'package:flutter_blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepository implements IBlogRepository {
  final IBlogRemoteDataSource _blogRemoteDataSource;
  final IBlogLocalDataSource _blogLocalDataSource;
  final IConnectionChecker _connectionChecker;
  BlogRepository(
    this._blogRemoteDataSource,
    this._blogLocalDataSource,
    this._connectionChecker,
  );

  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File file,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async {
    try {
      if (!await (_connectionChecker.isConnected)) {
        return left(const Failure('No internet connection!'));
      }
      BlogModel blog = BlogModel(
        id: const Uuid().v1(),
        posterId: posterId,
        title: title,
        content: content,
        imageUrl: '',
        topics: topics,
        updatedAt: DateTime.now(),
      );
      final imageUrl = await _blogRemoteDataSource.uploadBlogImage(file, blog);
      blog = blog.copyWith(imageUrl: imageUrl);
      BlogModel updatedBlog = await _blogRemoteDataSource.uploadBlog(blog);
      return right(updatedBlog);
    } on ServerException catch (e) {
      log(e.message);
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async {
    try {
      final List<BlogModel> blogs;

      if (!await (_connectionChecker.isConnected)) {
        // get local blogs
        blogs = _blogLocalDataSource.loadBlogs();
      } else {
        // get remote blogs
        blogs = await _blogRemoteDataSource.getAllBlogs();
        // cache blogs
        _blogLocalDataSource.uploadLocalBlogs(blogs: blogs);
      }

      return right(blogs);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}

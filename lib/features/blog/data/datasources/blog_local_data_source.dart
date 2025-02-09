import 'package:blog_app/features/blog/data/model/blog_model.dart';
import 'package:hive/hive.dart';

abstract interface class BlogLocalDataSource {
  void uploadLocalBlog(List<BlogModel> blogs);
  List<BlogModel> loadBlogs();
}

class BlogLocalDataSourceImpl implements BlogLocalDataSource {
  final Box box;
  BlogLocalDataSourceImpl(this.box);

  @override
  List<BlogModel> loadBlogs() {
    List<BlogModel> blogs = [];

    for (int i = 0; i < box.length; i++) {
      final rawData = box.get(i.toString());
      if (rawData is Map<dynamic, dynamic>) {
        final Map<String, dynamic> blogData = rawData.cast<String, dynamic>();
        blogs.add(BlogModel.fromJson(blogData));
      } else {
        throw Exception("Invalid data format in Hive box at index $i");
      }
    }

    return blogs;
  }

  @override
  void uploadLocalBlog(List<BlogModel> blogs) {
    box.clear();

    for (int i = 0; i < blogs.length; i++) {
      final Map<String, dynamic> blogJson = blogs[i].toJson();
      box.put(i.toString(), blogJson.cast<String, dynamic>());
    }
  }
}

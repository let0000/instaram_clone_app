import 'package:get/get.dart';
import 'package:instaram_clone/src/repository/post_repository.dart';

import '../models/post.dart';

class HomeController extends GetxController {
  RxList<Post> postList = <Post>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _loadFeedList();
  }

  void _loadFeedList() async {
    var feedList = await PostRepository.loadFeedList();
    postList.addAll(feedList);
  }
}
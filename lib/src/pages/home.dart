import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instaram_clone/src/components/avatar_widget.dart';
import 'package:instaram_clone/src/components/image_data.dart';
import 'package:instaram_clone/src/components/post_widget.dart';
import 'package:instaram_clone/src/controller/home_controller.dart';

class Home extends GetView<HomeController> {
  const Home({Key? key}) : super(key: key);

  Widget _myStory() {
    return Stack(
      children: [
        AvatarWidget(
            type: AvatarType.TYPE2,
            size: 70,
            thumbPath:
                'https://image.fmkorea.com/files/attach/new/20201027/3655109/1517176875/3166657926/247c418a79b196df884de1e5f2d8c4e4.jpeg'),
        Positioned(
            right: 5,
            bottom: 0,
            child: Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                  border: Border.all(color: Colors.white, width: 2)),
              child: const Center(
                child: Text(
                  '+',
                  style:
                      TextStyle(fontSize: 20, color: Colors.white, height: 1.1),
                ),
              ),
            ))
      ],
    );
  }
  
  Widget _storyBoardList() {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: [
          const SizedBox(width: 20),
          _myStory(),
          const SizedBox(width: 5),
          ...List.generate(
              10,
              (index) => AvatarWidget(
                  type: AvatarType.TYPE1,
                  thumbPath:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7nEqRASiiH3T-PaJhG3uy_rwJjpvs1as1vA&usqp=CAU'))
        ]));
  }
  
  Widget _postList() {
    return Obx(() => Column(
      children: List.generate(controller.postList.length, (index) => PostWidget(post: controller.postList[index])).toList(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: ImageData(IconPath.logo, width: 270),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: ImageData(IconPath.directMessage, width: 50),
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          _storyBoardList(),
          _postList()
        ],
      ),
    );
  }
}

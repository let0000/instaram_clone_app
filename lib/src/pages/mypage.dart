import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instaram_clone/src/components/avatar_widget.dart';
import 'package:instaram_clone/src/components/image_data.dart';
import 'package:instaram_clone/src/components/user_card.dart';
import 'package:instaram_clone/src/controller/mypage_controller.dart';

class MyPage extends GetView<MyPageController> {
  const MyPage({Key? key}) : super(key: key);

  Widget _statisticsOne(String title, int value) {
    return Column(
      children: [
        Text(
          value.toString(),
          style: const TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 15, color: Colors.black),
        ),
      ],
    );
  }

  Widget _information() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  AvatarWidget(
                    type: AvatarType.TYPE3,
                    thumbPath: controller.targetUser.value.thumbnail!,
                    size: 80,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: _statisticsOne('post', 15)),
                        Expanded(child: _statisticsOne('followers', 130)),
                        Expanded(child: _statisticsOne('following', 100)),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
               Text(
                controller.targetUser.value.description!,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ));
  }

  Widget _menu() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
      child: Row(
        children: [
          Expanded(
              child: Container(
            padding: const EdgeInsets.symmetric(vertical: 7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              border: Border.all(
                color: const Color(0xffdedede),
              ),
            ),
            child: const Text(
              'Edit Profile',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          )),
          const SizedBox(
            width: 8,
          ),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              border: Border.all(
                color: const Color(0xffdedede),
              ),
              color: const Color(0xffefefef),
            ),
            child: ImageData(IconPath.addFriend),
          ),
        ],
      ),
    );
  }

  Widget _discoverPeople() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Discover People',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black),
              ),
              Text(
                'See All',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Colors.blue),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: List.generate(
                10,
                (index) => UserCard(
                      userId: '직농$index',
                      description: '직농e$index님이 팔로우합니다',
                    )).toList(),
          ),
        ),
      ],
    );
  }

  Widget _tabMenu() {
    return TabBar(
        controller: controller.tabController,
        indicatorColor: Colors.black,
        indicatorWeight: 1,
        tabs: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ImageData(IconPath.gridViewOn),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ImageData(IconPath.myTagImageOff),
          ),
        ]);
  }

  Widget _tabView() {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 30,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            color: Colors.grey,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Obx(() => Text(controller.targetUser.value.nickname!,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black))),
        actions: [
          GestureDetector(
            onTap: () {},
            child: ImageData(
              IconPath.uploadIcon,
              width: 50,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: GestureDetector(
              onTap: () {},
              child: ImageData(
                IconPath.menuIcon,
                width: 50,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _information(),
            _menu(),
            _discoverPeople(),
            const SizedBox(
              height: 20,
            ),
            _tabMenu(),
            _tabView(),
          ],
        ),
      ),
    );
  }
}

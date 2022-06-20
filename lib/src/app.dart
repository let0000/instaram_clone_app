import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instaram_clone/src/components/image_data.dart';
import 'package:instaram_clone/src/controller/bottom_nav_controller.dart';

class App extends GetView<BottomNavController> {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: controller.willPopAction,
        child: Obx(
          () => Scaffold(
            appBar: AppBar(),
            body: IndexedStack(
              index: controller.pageIndex.value,
              children: [
                Container(child: Center(child: Text('HOME')),),
                Container(child: Center(child: Text('SEARCH')),),
                Container(child: Center(child: Text('UPLOAD')),),
                Container(child: Center(child: Text('ACTIVITY')),),
                Container(child: Center(child: Text('MYPAGE')),),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              currentIndex: controller.pageIndex.value,
              elevation: 0,
              onTap: controller.changeBottomNav,
              items: [
                BottomNavigationBarItem(
                  icon: ImageData(IconPath.homeOff),
                  activeIcon: ImageData(IconPath.homeOn),
                  label: 'home',
                ),
                BottomNavigationBarItem(
                  icon: ImageData(IconPath.searchOff),
                  activeIcon: ImageData(IconPath.searchOn),
                  label: 'search',
                ),
                BottomNavigationBarItem(
                  icon: ImageData(IconPath.uploadIcon),
                  label: 'upload',
                ),
                BottomNavigationBarItem(
                  icon: ImageData(IconPath.activeOff),
                  activeIcon: ImageData(IconPath.activeOn),
                  label: 'active',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey),
                  ),
                  label: 'avatar',
                ),
              ],
            ),
          ),
        ),
    );
  }
}

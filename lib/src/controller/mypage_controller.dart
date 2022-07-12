import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instaram_clone/src/controller/auth_controller.dart';
import '../models/instagram_user.dart';

class MyPageController extends GetxController with GetTickerProviderStateMixin{
  late TabController tabController;
  Rx<IUser> targetUser = IUser().obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    _loadData();
  }

  void setTargetUser() {
    var uid = Get.parameters['targetUid'];
    if(uid == null) {
      targetUser(AuthController.to.user.value);
    } else {
      // 상대방 uid 로 user.collection 조회
    }
  }

  void _loadData() {
    setTargetUser();
    // 포스트 리스트 로드
    // 사용자 정보 로드
 }
}
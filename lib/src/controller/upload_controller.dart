import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instaram_clone/src/components/message_popup.dart';
import 'package:instaram_clone/src/controller/auth_controller.dart';
import 'package:instaram_clone/src/repository/post_repository.dart';
import 'package:instaram_clone/src/utils/data_util.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:path/path.dart';
import 'package:image/image.dart' as imageLib;
import 'package:photofilters/filters/preset_filters.dart';
import 'package:photofilters/widgets/photo_filter.dart';

import '../models/post.dart';
import '../pages/upload/upload_description.dart';

class UploadController extends GetxController {
  var albums = <AssetPathEntity>[];
  RxString headertitle = ''.obs;
  RxList<AssetEntity> imageList = <AssetEntity>[].obs;
  TextEditingController textEditingController = TextEditingController();
  Rx<AssetEntity> selectedImage = AssetEntity(
    id: '0',
    typeInt: 0,
    width: 0,
    height: 0,
  ).obs;
  File? filteredImage;
  Post? post;

  @override
  void onInit() {
    super.onInit();
    post = Post.init(AuthController.to.user.value);
    _loadPhotos();
  }

  void _loadPhotos() async {
    var result = await PhotoManager.requestPermissionExtend();
    if (result.isAuth) {
      albums = await PhotoManager.getAssetPathList(
          type: RequestType.image,
          filterOption: FilterOptionGroup(
              imageOption: const FilterOption(
                  sizeConstraint: SizeConstraint(
                minWidth: 100,
                minHeight: 100,
              )),
              orders: [
                const OrderOption(
                  type: OrderOptionType.createDate,
                  asc: false,
                )
              ]));
      _loadData();
    } else {
      // message 권한 요청
    }
  }

  void _loadData() async {
    changeAlbum(albums.first);
  }

  Future<void> _pagingPhotos(AssetPathEntity album) async {
    imageList.clear();
    var photos = await album.getAssetListPaged(page: 0, size: 30);
    imageList.addAll(photos);
    changeSelectedImage(imageList.first);
  }

  changeSelectedImage(AssetEntity image) {
    selectedImage(image);
  }

  void changeAlbum(AssetPathEntity album) async {
    headertitle(album.name);
    await _pagingPhotos(album);
  }

  void gotoImageFilter() async {
    var file = await selectedImage.value.file;
    var fileName = basename(file!.path);
    var image = imageLib.decodeImage(await file.readAsBytes());
    image = imageLib.copyResize(image!, width: 1000);
    var imagefile = await Navigator.push(
      Get.context!,
      MaterialPageRoute(
        builder: (context) => PhotoFilterSelector(
          title: const Text("Photo Filter Example"),
          image: image!,
          filters: presetFiltersList,
          filename: fileName,
          loader: const Center(child: CircularProgressIndicator()),
          fit: BoxFit.contain,
        ),
      ),
    );
    if (imagefile != null && imagefile.containsKey('image_filtered')) {
      filteredImage = imagefile['image_filtered'];
      Get.to(() => const UploadDescription());
    }
  }

  void unfocusKeyBoard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void uploadPost() {
    unfocusKeyBoard();
    print(textEditingController);
    String filename = DataUtil.makeFilePath();
    var task = uploadXFile(
        filteredImage!, '${AuthController.to.user.value.uid}/$filename');
    if (task != null) {
      task.snapshotEvents.listen((event) async {
        if (event.bytesTransferred == event.totalBytes &&
            event.state == TaskState.success) {
          var downloadUrl = await event.ref.getDownloadURL();
          var updatePost = post!.copyWith(
            thumbnail: downloadUrl,
            description: textEditingController.text,
          );
          _submitPost(updatePost);
        }
      });
    }
  }

  UploadTask uploadXFile(File file, String filename) {
    var ref = FirebaseStorage.instance.ref().child('instagram').child(filename);
    //users/(uid)/profile.(확장자)
    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': file.path},
    );
    return ref.putFile(file, metadata);
  }

  void _submitPost(Post postData) async {
    await PostRepository.updatePost(postData);
    showDialog(context: Get.context!, builder: (context) => MessagePopup(
        title: '포스트',
        message: '포스팅이 완료 되었습니다.',
        okCallback: () {
          Get.until((route) => Get.currentRoute == '/');
        }
    ));
  }
}

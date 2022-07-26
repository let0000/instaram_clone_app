import 'package:instaram_clone/src/models/instagram_user.dart';

class Post {
  final String? id;
  final String? thumbnail;
  final String? description;
  final int? likeCount;
  final IUser? userInfo;
  final String? uid;
  final DateTime? createdAt;
  final DateTime? updateAt;
  final DateTime? deleteAt;

  Post({
    this.id,
    this.thumbnail,
    this.description,
    this.likeCount,
    this.userInfo,
    this.uid,
    this.createdAt,
    this.updateAt,
    this.deleteAt,
});

  static Post? init(IUser userInfo) {
    var time = DateTime.now();
    return Post(
      thumbnail: '',
      userInfo: userInfo,
      uid: userInfo.uid,
      description: '',
      createdAt: time,
      updateAt: time,
    );
  }

  factory Post.fromJson(String docId, Map<String, dynamic>json ){
    return Post(
        id : ['id'] == null ? '' : json['id'] as String,
        thumbnail : ['thumbnail'] == null ? '' : json['thumbnail'] as String,
        description : ['description'] == null ? '' : json['description'] as String,
        likeCount : ['likeCount'] == null ? 0 : json['likeCount'] as int,
        userInfo : ['userInfo'] == null ? null : IUser.fromJson(json['userInfo']),
        uid : ['uid'] == null ? '' : json['uid'] as String,
        createdAt : ['createdAt'] == null ? DateTime.now() : json['createdAt'].toDate(),
        updateAt : ['updateAt'] == null ? DateTime.now() : json['updateAt'].toDate(),
        deleteAt : ['deleteAt'] == null ? DateTime.now() : json['deleteAt'].toDate(),
    );
  }

  Post copyWith({
    String? id,
    String? thumbnail,
    String? description,
    int? likeCount,
    IUser? userInfo,
    String? uid,
    DateTime? createdAt,
    DateTime? updateAt,
    DateTime? deleteAt,
  }) {
    return Post(
        id : id ?? this.id,
        thumbnail : thumbnail ?? this.thumbnail,
        description : description ?? this.description,
        likeCount : likeCount ?? this.likeCount,
        userInfo : userInfo ?? this.userInfo,
        uid : uid ?? this.uid,
        createdAt : createdAt ?? this.createdAt,
        updateAt : updateAt ?? this.updateAt,
        deleteAt : deleteAt ?? this.deleteAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'thumbnail': thumbnail,
      'description': description,
      'likeCount': likeCount,
      'userInfo': userInfo!.toMap(),
      'uid': uid,
      'createdAt': createdAt,
      'updateAt': updateAt,
      'deleteAt': deleteAt,
    };
  }
}
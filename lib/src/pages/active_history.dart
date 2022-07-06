import 'package:flutter/material.dart';
import 'package:instaram_clone/src/components/avatar_widget.dart';

class ActiveHistory extends StatelessWidget {
  const ActiveHistory({Key? key}) : super(key: key);

  Widget _activeitemOne() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          AvatarWidget(
              type: AvatarType.TYPE2,
              size: 40,
              thumbPath:
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSs3VilaiafLxQjy_VMacJK2c5883i_3OQilw&usqp=CAU'),
          const SizedBox(
            width: 10,
          ),
          const Expanded(
              child: Text.rich(
            TextSpan(
                text: '직농',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: '님이 회원님의 게시물을 좋아합니다.',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  TextSpan(
                    text: ' 5일 전',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                  ),
                ]),
          ))
        ],
      ),
    );
  }

  Widget _newRecentlyActiveView(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          _activeitemOne(),
          _activeitemOne(),
          _activeitemOne(),
          _activeitemOne(),
          _activeitemOne(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          '활동',
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _newRecentlyActiveView('오늘'),
            _newRecentlyActiveView('이번주'),
            _newRecentlyActiveView('이번달'),
          ],
        ),
      ),
    );
  }
}

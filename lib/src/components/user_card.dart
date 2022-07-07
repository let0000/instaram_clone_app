import 'package:flutter/material.dart';
import 'package:instaram_clone/src/components/avatar_widget.dart';

class UserCard extends StatelessWidget {
  final String userId;
  final String description;

  const UserCard({Key? key, required this.userId, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      width: 150,
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.black12),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 15,
            right: 15,
            top: 0,
            bottom: 0,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                AvatarWidget(
                  type: AvatarType.TYPE2,
                  thumbPath:
                  'https://image.fmkorea.com/files/attach/new/20180505/559683442/554504864/1044137033/6ee9790736e46c2e0a5a1f0d54e7358d.jpg',
                  size: 80,
                ),
                const SizedBox(height: 10,),
                Text(
                  userId,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),
                ElevatedButton(
                    onPressed: () {},
                    child: const Text('follow')
                ),
              ],
            ),
          ),
          Positioned(
            right: 5,
            top: 5,
            child: GestureDetector(
              onTap: () {},
              child: const Icon(
                Icons.close,
                size: 14,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

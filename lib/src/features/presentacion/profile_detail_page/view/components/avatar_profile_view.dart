import 'package:app_delivery/src/colors/colors.dart';
import 'package:app_delivery/src/utils/styles/box_decoration_shadow.dart';
import 'package:flutter/material.dart';

@immutable
class AvatarProfileView extends StatelessWidget {
  final String backgroundimage;
  AvatarProfileView({required this.backgroundimage});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: 142,
          height: 142,
          decoration: getBoxDecorationWithShadow(
              borderRadius: BorderRadius.circular(65)),
          child: CircleAvatar(
            backgroundImage: NetworkImage(backgroundimage),
          ),
        ),
      ],
    );
  }
}


/*Transform.translate(
          offset: const Offset(0, -35),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: rosa,
              borderRadius: BorderRadiusDirectional.circular(20),
            ),
            child: const Icon(
              Icons.camera_alt,
              color: Colors.white,
              size: 20,
            ),
          ),
        ) */
        
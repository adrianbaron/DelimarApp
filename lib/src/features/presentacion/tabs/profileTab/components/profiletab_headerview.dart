import 'package:app_delivery/src/colors/colors.dart';
import 'package:app_delivery/src/features/presentacion/StateProviders/user_state_provider.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Headers/header_text.dart';
import 'package:app_delivery/src/utils/extensions/screem_size.dart';
import 'package:app_delivery/src/utils/helpers/UserPhoto/userPhotoHelpers.dart';
import 'package:flutter/material.dart';

class ProfileTabHeaderView extends StatelessWidget {
  ProfileTabHeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      color: bgGrey,
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage((context).getUserData()?.photo ??
                UserPhotoHelper.defaultUserPhoto),
            radius: 50,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 13.0),
                child: Row(
                  children: [
                    Container(
                      width: getScreenWidth(context: context, multiplier: 0.5),
                      child: Text(
                        (context).getUserData()?.username ??
                            "No encontramos los datos",
                        overflow: TextOverflow.fade,
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                height: 25,
                margin: const EdgeInsets.only(left: 20.0),
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      backgroundColor: rosa,
                      //foregroundColor: Colors.white,
                    ),
                    child: Row(
                      children: [
                        const Image(
                          image: AssetImage('assets/corona.png'),
                          width: 16,
                          height: 16,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 5),
                          child: headerText(
                              texto: "VIP miembro",
                              color: Colors.white,
                              fontSize: 11),
                        )
                      ],
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }
}

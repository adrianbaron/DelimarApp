import 'package:animate_do/animate_do.dart';
import 'package:app_delivery/src/colors/colors.dart';
import 'package:app_delivery/src/features/presentacion/search_page/view/searchView.dart';
import 'package:flutter/material.dart';
import 'package:app_delivery/src/utils/extensions/screem_size.dart';

class SearchTopBar extends StatelessWidget {
  const SearchTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: const Duration(seconds: 1),
      child: Row(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () {
                showSearch(context: context, delegate: SearchPage());
              },
              child: Container(
                width: getScreenWidth(context: context, multiplier: 0.93),
                padding:
                    const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0),
                margin: const EdgeInsets.only(left: 0, top: 20),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromRGBO(234, 236, 239, 1.0)),
                    borderRadius: BorderRadius.circular(20.0)),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      size: 20.0,
                      color: gris,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 5),
                      child: Text(
                        'Buscar',
                        style: TextStyle(color: gris, fontSize: 17.0),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


/* Container(
            width: 45.0,
            height: 45.0,
            margin: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
                color: const Color.fromRGBO(209, 209, 214, 1.0),
                borderRadius: BorderRadius.circular(30)),
            child: IconButton(
              icon: const Icon(
                Icons.filter_list,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, 'filter');
              },
            ),
          ), */
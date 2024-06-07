import 'package:app_delivery/src/colors/colors.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Headers/header_double.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Headers/text_view.dart';
import 'package:flutter/material.dart';

class YourRatingView extends StatelessWidget {
  var lorem = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua";
  
  YourRatingView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DoubleTextView(textHeader: "Your Rating", textAction: ""),
          const SizedBox(height: 16.0),
          RatingsButtons(itemSelected: 5),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: TextView(
                texto: lorem,
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.left),
          ),
          GestureDetector(
            onTap: () {
              // TODO: Add Navigation to Edit Review Page
            },
            child: Container(
              margin: const EdgeInsets.only(top: 16),
              child: const TextView(
                  texto: "+ Edit your review", // Esto cuando ya tenga review
                  fontWeight: FontWeight.w500,
                  fontSize: 15.0,
                  color: Colors.orange),
            ),
          )
        ],
      ),
    );
  }
}

class RatingsButtons extends StatelessWidget {
  final int itemSelected;
  final List<int> items = [1,2,3,4,5];

  RatingsButtons({Key? key, required this.itemSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: getRatingsButtonsList(),
    );
  }

  List<Widget> getRatingsButtonsList() {
    return items.map((item) => RatingButton(ratingNumber: item, isSelected: itemSelected == item, itemSelected: 5)).toList();
  }
}

class RatingButton extends StatelessWidget {
  final int ratingNumber;
  final bool isSelected;

  RatingButton({ Key? key,
                 required this.ratingNumber,
                 required this.isSelected, required int itemSelected }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 60,
          height: 30,
          color: isSelected ? orange : Colors.deepOrangeAccent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextView(
                  texto: '${ratingNumber}',
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 12),
              const Icon(Icons.star,
                   color: Colors.white,
                   size: 14)
            ],
          ),
        ),
      ),
    );
  }
}

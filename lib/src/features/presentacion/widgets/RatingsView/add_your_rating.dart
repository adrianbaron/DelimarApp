import 'package:app_delivery/src/features/presentacion/widgets/Headers/header_double.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Headers/text_view.dart';
import 'package:app_delivery/src/features/presentacion/widgets/RatingsView/your_ratings.dart';
import 'package:flutter/material.dart';

class AddYourRatingView extends StatelessWidget {

  AddYourRatingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const DoubleTextView(textHeader: "Your Rating", textAction: ""),
          const SizedBox(height: 16.0),
          RatingButton(itemSelected: 5, ratingNumber: 5, isSelected: false),
          Container(
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10)
            ),
            height: 180,
            child:  TextField(
              keyboardType: TextInputType.multiline,
              maxLines: 4,
              onChanged: (value) {
                // TODO: Add Logic
              },
              decoration: InputDecoration(
                  hintText: 'What do you think of this place?',
                  border: OutlineInputBorder(borderSide: BorderSide.none)),
            ),
          ),
          GestureDetector(
            onTap: () {
              // TODO: Add Logic
            },
            child: Container(
              margin: const EdgeInsets.only(top: 16),
              child: const TextView(
                  texto: "+Add your review", // Esto cuando ya tenga review
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

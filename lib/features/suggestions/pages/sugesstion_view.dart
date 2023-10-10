import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prithvi/config/di/di.dart';
import 'package:prithvi/core/core.dart';
import 'package:prithvi/models/user_model.dart';

//Reduce your footprint now Ashraf (Name of person logged in)

List<String> suggestionsList = [
  "Try cycling or walking to work instead of the car - This will not only reduce your carbon footprint but also help you to stay healthy",
  "Try vegetarian options more often- They have the same amount of nutrients , are easy to make and taste really good. ",
  "Switch off lights and unplug appliances when not in use - During daytime use natural light and natural breeze instead if aircons. ",
  '''Paperless environment- Please think before printing! Use both sides of paper.
Switch to digital instead of paper! ''',
  "Avoid half loads of laundry- Do full loads of laundry - it’s a win-win and saves time, effort and energy. ",
  "Buy only what you need -avoid waste- Saves the environment and your money too! ",
  "Recycle and donate - It’s a great way of giving a second life to things!"
];

class SuggestionView extends ConsumerWidget {
  const SuggestionView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sharedPrefernces = ref.read(sharedPreferencesServiceProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: InkWell(
          child: Icon(
            Icons.close,
            color: grey,
          ),
          onTap: () => Navigator.pop(context),
        ),
        title: Text(
          "Suggestions",
          style: TextStyle(
            color: grey,
            fontSize: 20,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          //  color: scaffoldBackgroundColor,
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(10),
            right: Radius.circular(10),
          ),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Reduce your footprint now ${UserModel.fromJson(sharedPrefernces.user).name}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: suggestionsList.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        suggestionsList[index],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

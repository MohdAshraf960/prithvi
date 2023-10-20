import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prithvi/config/di/di.dart';
import 'package:prithvi/core/core.dart';
import 'package:prithvi/models/model.dart';

List<Map<String, Object>> suggestionsList = [
  {
    "id": 1,
    "suggestion":
        "Try cycling or walking to work instead of the car - This will not only reduce your carbon footprint but also help you to stay healthy",
    "color": 0xFFFFC656
  },
  {
    "id": 2,
    "suggestion":
        "Try vegetarian options more often- They have the same amount of nutrients , are easy to make and taste really good. ",
    "color": 0xFFFF6E84
  },
  {
    "id": 3,
    "suggestion":
        "Switch off lights and unplug appliances when not in use - During daytime use natural light and natural breeze instead if aircons. ",
    "color": 0xFF8C75FF
  },
  {
    "id": 4,
    "suggestion":
        '''Paperless environment- Please think before printing! Use both sides of paper.
Switch to digital instead of paper! ''',
    "color": 0xFF48C3EB
  },
  {
    "id": 5,
    "suggestion":
        "Avoid half loads of laundry- Do full loads of laundry - it’s a win-win and saves time, effort and energy. ",
    "color": 0xFFFFC656
  },
  {
    "id": 6,
    "suggestion":
        "Buy only what you need -avoid waste- Saves the environment and your money too! ",
    "color": 0xFF8C75FF
  },
  {
    "id": 7,
    "suggestion":
        "Recycle and donate - It’s a great way of giving a second life to things!",
    "color": 0xFF48C3EB
  }
];

List<SuggestionModel> suggestionModels = suggestionsList
    .map((suggestionMap) => SuggestionModel.fromJson(suggestionMap))
    .toList();

class SuggestionView extends ConsumerWidget {
  const SuggestionView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            Consumer(builder: (context, ref, child) {
              final userModelAsyncValue = ref.watch(userProvider);
              return userModelAsyncValue.when(
                data: (user) => Text(
                  "Reduce your footprint now ${user.name}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                error: (e, st) => Center(
                  child: Text(
                    e.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: errorRed,
                    ),
                  ),
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }),
            SizedBox(
              height: 8,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: suggestionsList.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 0,
                    color: Color(suggestionModels[index].color),
                    margin: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        suggestionModels[index].suggestion,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
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

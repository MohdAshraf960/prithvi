import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prithvi/config/config.dart';

import 'package:prithvi/core/core.dart';
import 'package:prithvi/features/suggestions/suggestions.dart';
import 'package:prithvi/services/survey_service.dart';
import 'package:sizer/sizer.dart';

class SurveyView extends ConsumerWidget {
  const SurveyView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<Map<String, dynamic>>(
      stream: SurveyService(
        firestore: FirebaseFirestore.instance,
        secureStorageService: SecureStorageService(),
      ).getSurveyData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          ); // Display a loading indicator while data is loading.
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomButton(
              textfontsize: 16,
              height: 6.h,
              textColor: whiteColor,
              color: primaryGreen,
              text: "Calculate Carbon Footprint".toUpperCase(),
              onTap: () async {
                // tabController.animateTo(0);
              },
              width: double.infinity,
            ),
          ));
        } else {
          final surveyData = snapshot.data!;
          // Access the survey data here and update your UI as needed.
          // For example, you can display values like surveyData['home'], surveyData['travel'], etc.
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "Total Carbon Emission",
                    style: TextStyle(
                      color: grey,
                      fontSize: 32,
                    ),
                  ),
                  Container(
                    width: 250,
                    height: 250,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 15,
                        color: primaryGreen.withOpacity(0.2),
                      ),
                    ),
                    child: Text(
                      "${totalEmission(surveyData).toStringAsFixed(9)}",
                      style: TextStyle(
                        fontSize: 32,
                        color: primaryGreen,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  DataTable(
                    headingRowColor: MaterialStateProperty.all(primaryGreen),
                    //border: TableBorder.all(color: grey2Color),
                    columns: [
                      DataColumn(
                        label: Text(
                          'Category',
                          style: TextStyle(color: white),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Value (tonnes of CO2e)',
                          style: TextStyle(color: white),
                        ),
                      ),
                    ],
                    rows: surveyData.entries.map((entry) {
                      return DataRow(
                        cells: [
                          DataCell(
                            Text(entry.key.toString().toUpperCase()),
                          ),
                          DataCell(
                            Text("${entry.value.toString()}"),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  if (surveyData.isNotEmpty)
                    CustomButton(
                      height: 50,
                      text: "SUGGESTIONS FOR IMPROVEMENT",
                      textColor: white,
                      color: primaryGreen,
                      width: double.infinity,
                      onTap: () {
                        Navigator.of(context).push(
                          new MaterialPageRoute<Null>(
                            builder: (BuildContext context) {
                              return new SuggestionView();
                            },
                            fullscreenDialog: true,
                          ),
                        );
                      },
                      textfontsize: 14,
                    ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  double totalEmission(Map data) {
    double totalValue = 0.0;
    data.forEach((key, value) {
      totalValue += value;
    });

    return totalValue;
  }
}

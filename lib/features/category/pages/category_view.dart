import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prithvi/config/di/di.dart';
import 'package:prithvi/core/core.dart';
import 'package:prithvi/features/questions/questions.dart';

class CategoryView extends ConsumerStatefulWidget {
  static const id = '/category-view';
  const CategoryView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CategoryViewState();
}

class _CategoryViewState extends ConsumerState<CategoryView> {
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(categoryNotifierProvider);

    return DefaultTabController(
      length: provider.categoryList.length,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: scaffoldBackgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: primaryGreen,
          title: Text(
            "Category",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          //  centerTitle: true,
          bottom: TabBar(
            padding: EdgeInsets.symmetric(vertical: 10),
            indicatorColor: white,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: provider.categoryList
                .map(
                  (e) => Tab(
                    icon: Image.network(
                      e.image,
                      width: 24,
                      height: 24,
                    ),
                    text: e.name,
                  ),
                )
                .toList(),
          ),
        ),
        body: TabBarView(
          children: provider.categoryList
              .asMap()
              .map(
                (index, category) => MapEntry(index,
                    QuestionView(categoryType: category.type, index: index)),
              )
              .values
              .toList(),
        ),
      ),
    );
  }
}



            //  Padding(
            //       padding: const EdgeInsets.all(16.0),
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           SizedBox(
            //             height: 100,
            //           ),
            //           Center(
            //             child: Text(
            //               'START WITH A QUICK CARBON FOOTPRINT ESTIMATE',
            //               style: TextStyle(
            //                   fontWeight: FontWeight.bold,
            //                   color: Colors.blue.shade900),
            //             ),
            //           ),
            //           SizedBox(
            //             height: 30,
            //           ),
            //           Text(
            //             '1. Where do you live?',
            //             style: TextStyle(
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: 16,
            //                 color: Colors.blue.shade900),
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.all(16.0),
            //             child: TextField(
            //               decoration: InputDecoration(
            //                   border: OutlineInputBorder(),
            //                   hintText: 'Please enter city or zipcode'),
            //             ),
            //           ),
            //           SizedBox(
            //             height: 20,
            //           ),
            //           Text(
            //             '2. How many people live in your household?',
            //             style: TextStyle(
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: 16,
            //                 color: Colors.blue.shade900),
            //           ),
            //           SfSlider(
            //             value: _value,
            //             min: 10,
            //             max: 100,
            //             interval: 15,
            //             showTicks: true,
            //             showLabels: true,
            //             // enableTooltip: true,
            //             onChanged: (dynamic value) {
            //               setState(
            //                 () {
            //                   _value = value;
            //                 },
            //               );
            //             },
            //           ),
            //           SizedBox(
            //             height: 20,
            //           ),
            //           Text(
            //             '3. What is your gross annual household income?',
            //             style: TextStyle(
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: 16,
            //                 color: Colors.blue.shade900),
            //           ),
            //           SfSlider(
            //             value: _value1,
            //             min: 10,
            //             max: 100,
            //             interval: 15,
            //             showTicks: true,
            //             showLabels: true,
            //             // enableTooltip: true,
            //             onChanged: (dynamic value) {
            //               setState(
            //                 () {
            //                   _value1 = value;
            //                 },
            //               );
            //             },
            //           ),
            //           SizedBox(
            //             height: 40,
            //           ),
            //           Container(
            //             height: 50,
            //             width: 200,
            //             decoration: BoxDecoration(color: Colors.green),
            //             child: Center(
            //               child: Text(
            //                 'REFINE YOUR ESTIMATE',
            //                 style: TextStyle(
            //                     color: Colors.white,
            //                     fontWeight: FontWeight.bold),
            //               ),
            //             ),
            //           )
            //         ],
            //       ),
            //     ),
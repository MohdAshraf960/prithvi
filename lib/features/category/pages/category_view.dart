import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prithvi/config/di/di.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class CategoryView extends ConsumerStatefulWidget {
  static const id = "/category";
  const CategoryView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CategoryViewState();
}

class _CategoryViewState extends ConsumerState<CategoryView> {
  double _value = 25;
  double _value1 = 25;

  final List<Tab> myTabs = <Tab>[
    Tab(
      child: TabContent(
        text: 'Tab 1',
        imageAsset: 'assets/tab1_image.png',
      ),
    ),
    Tab(
      child: TabContent(
        text: 'Tab 2',
        imageAsset: 'assets/tab2_image.png',
      ),
    ),
    // Add more tabs as needed
  ];

  @override
  Widget build(BuildContext context) {
    final categoryList = ref.watch(categoryNotifierProvider).categoryList;
    return DefaultTabController(
      length: categoryList.length,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: categoryList
                .map(
                  (e) => Tab(
                    child: Row(
                      children: [
                        Image.network(
                          e.image,
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(e.name)
                      ],
                    ),
                  ),
                )
                .toList(),
            isScrollable: false,
          ),
        ),
        body: TabBarView(
          children: categoryList
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Center(
                        child: Text(
                          'START WITH A QUICK CARBON FOOTPRINT ESTIMATE',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade900),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        '1. Where do you live?',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.blue.shade900),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Please enter city or zipcode'),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        '2. How many people live in your household?',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.blue.shade900),
                      ),
                      SfSlider(
                        value: _value,
                        min: 10,
                        max: 100,
                        interval: 15,
                        showTicks: true,
                        showLabels: true,
                        // enableTooltip: true,
                        onChanged: (dynamic value) {
                          setState(
                            () {
                              _value = value;
                            },
                          );
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        '3. What is your gross annual household income?',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.blue.shade900),
                      ),
                      SfSlider(
                        value: _value1,
                        min: 10,
                        max: 100,
                        interval: 15,
                        showTicks: true,
                        showLabels: true,
                        // enableTooltip: true,
                        onChanged: (dynamic value) {
                          setState(
                            () {
                              _value1 = value;
                            },
                          );
                        },
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        height: 50,
                        width: 200,
                        decoration: BoxDecoration(color: Colors.green),
                        child: Center(
                          child: Text(
                            'REFINE YOUR ESTIMATE',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class TabContent extends StatelessWidget {
  final String text;
  final String imageAsset;

  TabContent({required this.text, required this.imageAsset});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          imageAsset,
          width: 24.0,
          height: 24.0,
        ),
        SizedBox(height: 4.0),
        Text(text),
      ],
    );
  }
}

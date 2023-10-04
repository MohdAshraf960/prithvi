import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prithvi/config/di/di.dart';
import 'package:prithvi/core/core.dart';
import 'package:prithvi/features/questions/questions.dart';
import 'package:prithvi/features/survey/survey.dart';

class CategoryView extends ConsumerStatefulWidget {
  static const id = '/category-view';
  const CategoryView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CategoryViewState();
}

class _CategoryViewState extends ConsumerState<CategoryView>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController _tabController;

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 0, vsync: this);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final provider = ref.watch(categoryNotifierProvider);
    _tabController = TabController(
      length: provider.categoryList.length,
      vsync: this,
    );

    return PageStorage(
      bucket: bucket,
      child: DefaultTabController(
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
            /* 
         cat3goryList=   [
{
"image":"backend/img1.png",
"text":"first text"
},
{
"image":"backend/img1.png",
"text":"first text"
},


            ]
            
            */
            bottom: TabBar(
              controller: _tabController,
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
            controller: _tabController,
            children: provider.categoryList
                .asMap()
                .map(
                  (index, category) {
                    if (category.type == "result")
                      return MapEntry(
                          index,
                          SurveyView(
                            tabController: _tabController,
                          ));
                    else
                      return MapEntry(
                        index,
                        QuestionView(
                            key: PageStorageKey(category.name),
                            tabController: _tabController,
                            categoryType: category.type,
                            index: index),
                      );
                  },
                )
                .values
                .toList(),
          ),
        ),
      ),
    );
  }
}

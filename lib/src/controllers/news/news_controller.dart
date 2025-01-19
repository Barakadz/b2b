import 'package:business/src/controllers/base_controller.dart';
import 'package:business/src/models/other/news/article.dart';
import 'package:business/src/models/other/news/news_response.dart';
import 'package:business/src/models/other/news/news_category.dart';
import 'package:business/src/models/response/pair.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewsController extends BaseController
    with GetSingleTickerProviderStateMixin {
  int selectedCategory = 0;
  int page = 1, lastPage = 2, total = 0;
  bool isFetching = false, isFinished = false;
  List<NewsCategory> categories = [];
  List<Article> articlesList = [];
  late TabController tabController;

  ScrollController scrollController = ScrollController();
  initScrollerListener() {
    scrollController.addListener((() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        if (!isFetching & !isFinished) {
          isFetching = !isFetching;
          page++;
          update();
          //Update new list
        }
      }
    }));
  }

  @override
  void onInit() {
    getCategories();
    super.onInit();
  }

  initParams() {
    selectedCategory =
        tabController.index; //categories.elementAt(tabController.index).id!;
    page = 0;
    isFetching = false;
    isFinished = false;
    articlesList = [];
    update();
    update(['loader']);
    getNews();
  }

  initTabController() {
    tabController = TabController(length: categories.length, vsync: this);
    tabController.animateTo(0);
    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        initParams();
      }
    });
    initScrollerListener();
  }

  void getCategories() async {
    categories =
        await categoriesStatic.map((e) => NewsCategory.fromJson(e)).toList();
    if (categories.isNotEmpty) {
      initTabController();
      getNews();
    }
    update();
  }

  void getNews() async {
    updateStatus(Pair(Status.loading, Reason.idle));
    await Future.delayed(const Duration(milliseconds: 2000));
    NewsResponse list = await NewsResponse.fromJson(newsStatic);
    articlesList.addAll(list.articles!);
    updateStatus(Pair(Status.success, Reason.idle));
    update(['loader']);
  }

  setSelectedCategory(int val) {
    selectedCategory = val;
  }

  var categoriesStatic = [
    {"id": 1, "category": "Populaires"},
    {"id": 2, "category": "Taux de change"},
    {"id": 3, "category": "News National"},
    {"id": 4, "category": "Diversités"},
    {"id": 5, "category": "International"}
  ];

  var newsStatic = {
    "current_page": 1,
    "last_page": 1,
    "total": 5,
    "articles": [
      {
        "id": 1,
        "title": "some title",
        "description": "some description",
        "medias": [
          {"id": 1000, "url": "urllll", "type": "image"},
          {"id": 1001, "url": "urllll2", "type": "image"}
        ]
      },
      {
        "id": 2,
        "title": "some title",
        "description": "some description",
        "medias": [
          {"id": 1002, "url": "urllll", "type": "audio"}
        ]
      },
      {
        "id": 3,
        "title": "some title",
        "description": "some description",
        "medias": [
          {"id": 1003, "url": "urllll", "type": "video"}
        ]
      },
      {
        "id": 4,
        "title": "some title",
        "description": "some description",
        "medias": [
          {"id": 1004, "url": "urllll", "type": "image"}
        ]
      },
      {
        "id": 5,
        "title": "some title",
        "description": "some description",
        "medias": [
          {"id": 500, "url": "urllll", "type": "icon"}
        ]
      }
    ]
  };
}

import 'package:business/src/controllers/base_controller.dart';
import 'package:business/src/exceptions/api_exceptions.dart';
import 'package:business/src/models/other/faq.dart';
import 'package:business/src/models/other/faq_category.dart';
import 'package:business/src/models/other/faq_list.dart';
import 'package:business/src/models/response/pair.dart';
import 'package:business/src/repositories/faq_repository.dart';
import 'package:business/src/ui/widgets/dialogs/snake_warning.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FaqController extends BaseController
    with GetSingleTickerProviderStateMixin {
  FaqController();

  List<Map<String, dynamic>> jsonCategories = [
    {
      'id': '1',
      'type': 'faq_category',
      'attributes': {'item': 'line', 'title': 'ligne', "order": 1}
    },
    {
      'id': '2',
      'type': 'faq_category',
      'attributes': {'item': 'service', 'title': 'services', "order": 2}
    },
    {
      'id': '3',
      'type': 'faq_category',
      'attributes': {'item': 'internet', 'title': 'internet', "order": 3}
    },
    {
      'id': '4',
      'type': 'faq_category',
      'attributes': {'item': 'contact', 'title': 'numbers', "order": 4}
    }
  ];
  List<FaqCategoryModel> categries = [];
  late TabController tabController;
  List<FaqModel> faqs = [];
  String selectedCategory = 'line';

  @override
  void onInit() {
    categries =
        jsonCategories.map((e) => FaqCategoryModel.fromJson(e)).toList();
    tabController = TabController(length: categries.length, vsync: this);
    tabController.animateTo(0);
    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        initParams();
      }
    });
    initScrollerListener();
    loadFaqs(false);
    super.onInit();
  }

  void fetchData() async {
    try {
      FaqListModel data = await FaqRepository.getFaqs(
          category: selectedCategory, page: page, size: rows);
      faqs.addAll(data.informations!);
      updateStatus(Pair(Status.success, Reason.idle));
      isFetching = false;
      if (data.informations!.length < rows) {
        isFinished = true;
        SnackBarInfo.snackMessage('No more content to load.', Alerts.info);
      }
      update();
    } on DataFormatException catch (e) {
      if (e.toString() == 'INVALID_VALUE') {
        generateError(Pair(Status.error, Reason.unknown));
      }
    } on FetchDataException catch (_) {
      generateError(Pair(Status.error, Reason.unknown));
    } on BadRequestException catch (_) {
      generateError(Pair(Status.error, Reason.unknown));
    }
  }

  generateError(Pair error) {
    if (faqs.isEmpty) {
      updateStatus(error);
      update();
    }
  }

  @override
  void onClose() {
    tabController.removeListener(() {});
    scrollController.removeListener(() {});
    super.onClose();
  }

  //List controllers
  int page = 0, rows = 10;
  bool isFetching = false, isFinished = false;

  initParams() {
    selectedCategory = categries.elementAt(tabController.index).item ?? 'line';
    page = 0;
    isFetching = false;
    isFinished = false;
    faqs = [];
    update();
    loadFaqs(false);
  }

  loadFaqs(bool refresh) {
    updateStatus(Pair(Status.loading, Reason.idle));
    isFetching = true;
    if (!refresh) page++;
    update();
    fetchData();
  }

  ScrollController scrollController = ScrollController();
  initScrollerListener() {
    scrollController.addListener((() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        if (!isFetching & !isFinished) {
          isFetching = !isFetching;
          page++;
          update();
          fetchData();
        }
      }
    }));
  }
}

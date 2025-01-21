import 'package:business/src/controllers/faq_controller.dart';
import 'package:business/src/controllers/navigation_controller.dart';
import 'package:business/src/ui/pages/faq/widgets/faq_list.dart';
import 'package:business/src/ui/pages/navigator/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Offres{
  Map ?question;
  String ?type;
  Map ?response;

Offres({this.question, this.type,this.response});


}




class FaqPage extends StatelessWidget {
 // Offres test =Offres(type: "Ligne",question: {"fr":"Code PIN / PUK oublié?","ar":"","en":""},response: {"fr":"Si vous entrez trois fois un code PIN de maniére erronée, votre carte SIM sera automatiquement bloquée. Dés lors, vous devrez utiliser votre code PUK qui se trouve à l'intérieur de l'emballage d'origine. Veuillez le conserver","ar":"","en":""});
    const FaqPage({super.key});

  IconData _getIcon(String item) {
    switch (item) {
      case 'line':
        return Icons.phone;
      case 'service':
        return Icons.settings;
      case 'internet':
        return Icons.four_g_mobiledata;
      case 'contact':
        return Icons.numbers;
      default:
        return Icons.question_mark;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Get.theme.primaryColor,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            Get.find<NavigationPageCtrl>().getTitle(NavDrawer.faqItem),
            style: Get.theme.primaryTextTheme.bodyMedium
                ?.copyWith(fontSize: 25, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.vertical(
          //       bottom: Radius.elliptical(Get.width, 90.0)),
          // ),
        ),
      ),
      drawer: NavDrawer(),
      body: PopScope(
        canPop: false,
        onPopInvoked: (val) =>
            Get.find<NavigationPageCtrl>().setSelectedTab(NavDrawer.homeItem),
        child: GetBuilder<FaqController>(
          init: FaqController(),
          builder: (ctrl) => Scaffold(
            appBar: AppBar(
              shadowColor: Colors.white,
              surfaceTintColor: Colors.white,
              title: TabBar(
                tabs: ctrl.categries
                    .map((e) => Tab(
                          text: e.title!.tr,
                          icon: Icon(_getIcon(e.item!)),
                        ))
                    .toList(),
                controller: ctrl.tabController,
                indicatorSize: TabBarIndicatorSize.label,
                labelPadding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.hovered))
                      return Colors.white;
                    if (states.contains(MaterialState.pressed))
                      return Colors.white;
                    return null;
                  },
                ),
              ),
            ),
            body:  FaqList(),
          ),
        ),
      ),
    );
  }
}

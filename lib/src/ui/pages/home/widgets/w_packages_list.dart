import 'package:business/src/controllers/globale/auth_controller.dart';
import 'package:business/src/models/dbss/package.dart';
import 'package:business/src/ui/pages/home/widgets/w_package_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePackagesList extends StatefulWidget {
  const HomePackagesList({super.key});

  @override
  State<HomePackagesList> createState() => _HomePackagesListState();
}

class _HomePackagesListState extends State<HomePackagesList> {
  List<Widget> l = [];
  List<Package>? packages;
  double draggedDistance = 0, x1 = 0, x2 = 0;
  bool cond = false;

  final AuthController _authController = Get.find();

  @override
  void initState() {
    super.initState();
    packages = _authController.connectedProducts;
  }

  updateList(DraggableDetails detail) {
    if ((x2 - x1).abs() > Get.width * 0.50) {
      Package o = packages!.first;
      packages!.removeRange(0, 1);
      packages!.add(o);
      setState(() {});
    }
  }

  dragStarted() {
    cond = true;
  }

  dragUpdated(int i, DragUpdateDetails detail) {
    if (cond) {
      x1 = detail.globalPosition.dx;
      cond = false;
    } else {
      x2 = detail.globalPosition.dx;
    }
  }

  List<Widget> list() {
    List<Widget> l = [];
    if (packages!.isNotEmpty) {
      for (var i = packages!.length - 1; i >= 0; i--) {
        if (packages![i].show! && packages![i].balances!.isNotEmpty) {
          l.add(Draggable(
            feedback: Container(
              width: Get.width,
              child: HomePackageCard(
                package: packages![i],
                order: i,
                shadow: true,
              ),
            ),
            childWhenDragging: Container(),
            axis: Axis.horizontal,
            onDragStarted: (() => dragStarted()),
            onDragUpdate: (detail) => dragUpdated(i, detail),
            onDragEnd: (detail) => updateList(detail),
            child:
                HomePackageCard(package: packages![i], order: i, shadow: false),
          ));
        }
      }
    }
    setState(() {});
    return l;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      child: Stack(
        children: list(),
      ),
    );
  }
}

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:business/src/models/dbss/package.dart';
import 'package:business/src/ui/pages/offers/widgets/bundle_widget.dart';
import 'package:get/get.dart';

class OfferItem extends StatelessWidget {
  final Package? package;

  const OfferItem(this.package, {super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen size
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;
    final isMediumScreen = screenSize.width >= 600 && screenSize.width < 900;

    // Calculate responsive padding and sizes
    final horizontalPadding = screenSize.width * 0.03;
    final cardWidth = isSmallScreen 
        ? screenSize.width * 0.94
        : isMediumScreen 
            ? screenSize.width * 0.8 
            : screenSize.width * 0.7;
    final titleWidth = cardWidth * 0.6;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: SizedBox(
            width: cardWidth,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 5, 
                horizontal: horizontalPadding
              ),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 5,
                      right: 5,
                      top: isSmallScreen ? 12 : 15,
                      bottom: isSmallScreen ? 8 : 10
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 15.0,
                            color: Colors.black26,
                            blurStyle: BlurStyle.normal
                          ),
                        ],
                      ),
                      child: Card(
                        color: Get.theme.cardColor,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                top: isSmallScreen ? 25 : 30,
                                left: isSmallScreen ? 8 : 10,
                                right: isSmallScreen ? 4 : 5
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: getBundleWidgets(context),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: isSmallScreen ? 15 : 20,
                                vertical: isSmallScreen ? 8 : 10
                              ),
                              child: Flex(
                                direction: isSmallScreen 
                                    ? Axis.vertical 
                                    : Axis.horizontal,
                                mainAxisAlignment: isSmallScreen
                                    ? MainAxisAlignment.center
                                    : MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  _buildDurationText(context),
                                  if (!isSmallScreen) const Spacer(),
                                  _buildPriceText(context),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    width: titleWidth,
                    child: Container(
                      height: isSmallScreen ? 30 : 34,
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            Get.theme.primaryColor.withOpacity(0.8),
                            Get.theme.primaryColor.withOpacity(0.7),
                            Get.theme.primaryColor.withOpacity(0.5),
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: isSmallScreen ? 4 : 5,
                          horizontal: isSmallScreen ? 8 : 10
                        ),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            package?.name?.getValue() ?? "",
                            style: Get.theme.primaryTextTheme.displayLarge,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDurationText(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 3.0 : 5.0
              ),
              child: Icon(
                FontAwesomeIcons.stopwatch,
                size: isSmallScreen ? 16 : 18,
                color: Get.theme.primaryTextTheme.displaySmall?.color
              ),
            ),
          ),
          TextSpan(
            text: package?.formatValidity(),
            style: Get.theme.primaryTextTheme.displayMedium,
          )
        ]
      ),
    );
  }

  Widget _buildPriceText(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 8.0 : 10.0
              ),
              child: Icon(
                FontAwesomeIcons.moneyBill1Wave,
                size: isSmallScreen ? 16 : 18,
                color: Get.theme.primaryTextTheme.displaySmall?.color
              ),
            ),
          ),
          TextSpan(
            text: package?.formatPrice(),
            style: Get.theme.primaryTextTheme.displayMedium,
          ),
        ]
      )
    );
  }

  List<Widget> getBundleWidgets(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;
    
    List<Widget> widgets = [];
    var count = min(package?.bundles?.length ?? 0, 3);
    
    for (int i = 0; i < count; i++) {
      bool isCenter = count == 1 || (i == 1 && count > 2);
      
      widgets.add(BundleWidget(
        bundle: package?.bundles?[i],
        height: screenSize.width * (isSmallScreen ? 0.22 : 0.25),
        width: screenSize.width * (
          isSmallScreen 
            ? (isCenter ? 0.19 : 0.16)
            : (isCenter ? 0.22 : 0.19)
        ),
        alignment: (isCenter 
          ? MainAxisAlignment.start 
          : MainAxisAlignment.end
        ),
      ));
    }

    return widgets;
  }
}
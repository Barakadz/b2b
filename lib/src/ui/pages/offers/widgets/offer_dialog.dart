import 'package:flutter/material.dart';
import 'package:business/src/ui/widgets/dialogs/dialog_footer.dart';
import 'package:business/src/models/dbss/package.dart';
import 'package:get/get.dart';

class OfferDialog extends StatefulWidget {
  final Package? package;
  final DialogInterface? listener;

  const OfferDialog({
    super.key,
    this.package,
    this.listener,
  });

  @override
  State<OfferDialog> createState() => OfferDialogState();
}

class OfferDialogState extends State<OfferDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Get.theme.dialogTheme.backgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: _getBundleWidgets(context),
        ),
      ),
    );
  }

  List<Widget> _getBundleWidgets(BuildContext context) {
    return [
      // Header with package name and gift icon
      Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 35, 20, 25),
            decoration: BoxDecoration(
              color: Get.theme.primaryColor.withOpacity(0.1),
              border: Border(
                bottom: BorderSide(
                  color: Get.theme.dividerColor.withOpacity(0.1),
                  width: 1,
                ),
              ),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.card_giftcard,
                  size: 40,
                  color: Get.theme.primaryColor,
                ),
                const SizedBox(height: 3),
                Text(
                  widget.package?.name?.getValue() ?? "",
                  style: Get.theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Icon(
              Icons.stars,
              color: Get.theme.primaryColor.withOpacity(0.3),
              size: 24,
            ),
          ),
        ],
      ),

      // Bundles section
      ...List.generate(
        widget.package?.bundles?.length ?? 0,
        (index) => _buildBundleItem(index),
      ),

      // Price and validity section
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 20,vertical:10),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Get.theme.primaryColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Get.theme.primaryColor.withOpacity(0.1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.access_time,
              color: Get.theme.primaryColor,
              size: 24,
            ),
            const SizedBox(width: 10),
            Column(
              children: [
                Text(
                  "Pour ${widget.package?.formatPrice()}",
                  style: Get.theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Get.theme.primaryColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "/${widget.package?.formatValidity()}",
                  style: Get.theme.textTheme.bodyMedium?.copyWith(
                    color: Get.theme.hintColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      // Action buttons
      if (widget.package?.illegible == true)
        
       DialogFooter(
        parent: widget.key,
        listener: widget.listener,
        positive: widget.package?.illegible == true ? 'actionActivate'.tr : null,
      ),
    ];
  }

  Widget _buildBundleItem(int index) {
    final bundle = widget.package?.bundles?[index];
    if (bundle == null) return const SizedBox.shrink();

    IconData getBundleIcon() {
      if (bundle.unlimited == true) {
        return Icons.all_inclusive;
      }
      // You can customize these icons based on your bundle types
      switch (index) {
        case 0:
          return Icons.rocket_launch;
        case 1:
          return Icons.speed;
        default:
          return Icons.featured_play_list;
      }
    }

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 15, 20, 0),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: index == 0 
              ? Get.theme.primaryColor.withOpacity(0.3)
              : Get.theme.dividerColor.withOpacity(0.2),
        ),
        color: index == 0 
            ? Get.theme.primaryColor.withOpacity(0.05)
            : Colors.transparent,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            getBundleIcon(),
            color: index == 0 ? Get.theme.primaryColor : Get.theme.hintColor,
            size: 24,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bundle.unlimited == false
                      ? bundle.getQuota() ?? ""
                      : bundle.description?.getValue() ?? "",
                  style: (index == 0
                          ? Get.theme.textTheme.headlineMedium
                          : Get.theme.textTheme.headlineSmall)
                      ?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: index == 0 
                        ? Get.theme.primaryColor
                        : null,
                  ),
                ),
                if (bundle.unlimited != true) ...[
                  const SizedBox(height: 8),
                  Text(
                    "${bundle.description?.getValue()}",
                    style: (index == 0
                            ? Get.theme.textTheme.labelMedium
                            : Get.theme.textTheme.labelSmall)
                        ?.copyWith(
                      color: Get.theme.hintColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:business/src/helpers/text_helper.dart';
import 'package:business/src/helpers/alert_helper.dart';
import 'package:business/src/models/response/pair.dart';
import 'package:business/src/controllers/otp/otp_controller.dart';
import 'package:business/src/ui/pages/base_page.dart';
import 'package:business/src/ui/widgets/keyboard_widget.dart';
import 'package:business/src/ui/widgets/countdown_widget.dart';

class OtpPage extends StatefulWidget {
  static String routeName = '/otp';

  final String title;
  const OtpPage({super.key, required this.title});

  @override
  BasePageState<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends BasePageState<OtpPage>
    implements KeyboardInterface {
  GlobalKey<KeyboardWidgetState> otpKeyboard = GlobalKey();
  GlobalKey<CountdownWidgetState> otpCountdown = GlobalKey();

  final OtpController _otpController = Get.find();

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        otpCountdown.currentState!.startTimer();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //DIO for https
    return Scaffold(
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Image.asset(
                  fit: BoxFit.contain,
                  "assets/images/logo.png",
                  width: Get.width * 0.25,
                  height: Get.width * 0.25,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Text(
                  'descVerifyNumber'.tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 21, fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'descInsertPin'.tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                width: Get.width * 0.55,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueGrey),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(7),
                    child: GetBuilder<OtpController>(
                        id: "pin",
                        builder: (ctrl) {
                          return Text(
                            TextHelper.format(ctrl.pin),
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 22),
                          );
                        }),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: CountdownWidget(key: otpCountdown),
              ),
              KeyboardWidget(
                key: otpKeyboard,
                listener: this,
              ),
              GetBuilder<OtpController>(
                  id: "loader",
                  builder: (ctrl) {
                    onStatusChanged(ctrl.result);
                    return const SizedBox();
                  }),
            ]),
      ),
    );
  }

  @override
  void onKeyPressed(int type, int key) {
    _otpController.manageKeyPress(key);
  }

  @override
  onStatusChanged(Pair result) {
    Future.delayed(Duration.zero, () async {
      if (result.reason == Reason.notFound) {
        //Stop loader
        onStopLoading();

        //Display error
        AlertHelper.showMyDialog(
            context, 'errTitle'.tr, 'errDescIncorrectPin'.tr);
      } else {
        super.onStatusChanged(result);
      }
    });
  }

  @override
  void onStartLoading() {
    otpKeyboard.currentState!.isLoading(true);
  }

  @override
  void onStopLoading() {
    otpKeyboard.currentState!.isLoading(false);
  }
}

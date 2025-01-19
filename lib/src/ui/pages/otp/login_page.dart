import 'package:business/src/controllers/otp/otp_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '/src/ui/pages/base_page.dart';
import '/src/ui/widgets/keyboard_widget.dart';
import '/src/helpers/text_helper.dart';
import '/src/helpers/alert_helper.dart';
import '/src/models/response/pair.dart';
import '/src/controllers/otp/login_controller.dart';

class LoginPage extends StatefulWidget {
  static String routeName = '/login';

  final String title;
  const LoginPage({super.key, required this.title});

  @override
  BasePageState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BasePageState<LoginPage>
    implements KeyboardInterface {
  GlobalKey<KeyboardWidgetState> loginKeyBoard = GlobalKey();

  @override
  void initState() {
    Get.put(OtpController());
    _loginController = Get.put(LoginController());
    super.initState();
  }

  late LoginController _loginController;

  @override
  Widget build(BuildContext context) {
    //DIO for https
    return Scaffold(
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Image.asset(
                  fit: BoxFit.contain,
                  "assets/images/ic_logo.png",
                  width: Get.width * 0.25,
                  height: Get.width * 0.25,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Text(
                  'descInsertNumber'.tr,
                  textAlign: TextAlign.center,
                  style: Get.textTheme.headlineSmall,
                ),
              ),
              SizedBox(
                width: Get.width * 0.55,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueGrey),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(7),
                      child: GetBuilder<LoginController>(
                          id: "phoneNumber",
                          builder: (ctrl) {
                            return Text(
                              textAlign: TextAlign.center,
                              TextHelper.format(ctrl.phoneNumber),
                              style: const TextStyle(fontSize: 22),
                            );
                          })),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GetBuilder<LoginController>(
                    id: "condition1",
                    builder: (ctrl) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Checkbox(
                              value: ctrl.condition1,
                              onChanged: (value) {
                                ctrl.updateCondition(value!, 1);
                              }),
                          Text(
                            '${'term1'.tr} ',
                            style: Get.textTheme.bodyMedium!
                                .copyWith(fontSize: 13),
                          ),
                          Expanded(
                            child: Text(
                              '${'termsAndConditions'.tr} ',
                              style: Get.textTheme.labelMedium!
                                  .copyWith(fontSize: 13),
                            ),
                          ),
                        ],
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: GetBuilder<LoginController>(
                    id: "condition2",
                    builder: (ctrl) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Checkbox(
                              value: ctrl.condition2,
                              onChanged: (value) {
                                ctrl.updateCondition(value!, 2);
                              }),
                          Expanded(
                            child: Text(
                              '${'term2'.tr} ',
                              style: Get.textTheme.bodyMedium!
                                  .copyWith(fontSize: 13),
                            ),
                          ),
                        ],
                      );
                    }),
              ),
              KeyboardWidget(key: loginKeyBoard, listener: this),
              GetBuilder<LoginController>(
                  id: "canSend",
                  builder: (ctrl) {
                    Future.delayed(Duration.zero, () async {
                      loginKeyBoard.currentState!.canSend(ctrl.canSend);
                    });
                    return const SizedBox();
                  }),
              GetBuilder<LoginController>(
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
    _loginController.manageKeyPress(key);
  }

  @override
  onStatusChanged(Pair result) {
    Future.delayed(Duration.zero, () async {
      if (result.reason == Reason.notFound) {
        //Stop loader
        onStopLoading();

        //Display error
        AlertHelper.showMyDialog(
            context, 'errTitle'.tr, 'errDescIncorrectMsisdn'.tr);
      } else {
        super.onStatusChanged(result);
      }
    });
  }

  @override
  void onStartLoading() {
    loginKeyBoard.currentState!.isLoading(true);
  }

  @override
  void onStopLoading() {
    loginKeyBoard.currentState!.isLoading(false);
  }
}

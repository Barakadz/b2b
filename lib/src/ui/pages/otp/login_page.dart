import 'package:business/src/assets/colors.dart';
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
                Hero(
                    tag: 'logo',
                    child: Image.asset(
                      "assets/images/logo.png",
                      width: Get.width * 0.25,
                      height: Get.width * 0.25,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 30),
        
                  // Title with enhanced typography
                  Text(
                    'descInsertNumber'.tr,
                    textAlign: TextAlign.center,
                    style: Get.textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),
        
              SizedBox(
                width: Get.width * 0.55,
                child:   Container(
                    width: Get.width * 0.85,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      border: Border.all(color: CustomColors.secondaryColor, width: 1.5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: GetBuilder<LoginController>(
                        id: "phoneNumber",
                        builder: (ctrl) {
                          return Text(
                            TextHelper.format(ctrl.phoneNumber),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue.shade800,
                            ),
                          );
                        },
                      ),
                    ),
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

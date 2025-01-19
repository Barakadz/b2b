import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:business/src/models/response/pair.dart';
import 'package:business/src/helpers/alert_helper.dart';

abstract class BasePageState<T> extends State {
  onStatusChanged(Pair result) {
    Future.delayed(Duration.zero, () async {
      if (result.status == Status.starting) {
        //Start loader
        onStartLoading();
      } else {
        //Stop loader
        onStopLoading();

        //Check status & reason
        if (result.status == Status.error) {
          if (result.reason == Reason.noBalance) {
            AlertHelper.showMyDialog(
                context, 'errTitle'.tr, 'errDescNoBalance'.tr);
          } else if (result.reason == Reason.accountBlocked) {
            AlertHelper.showMyDialog(
                context, 'errTitle'.tr, 'errDescBlockedAccount'.tr);
          } else if (result.reason == Reason.wrongPin) {
            AlertHelper.showMyDialog(
                context, 'errTitle'.tr, 'errDescIncorrectPin'.tr);
          } else if (result.reason == Reason.maxReached) {
            AlertHelper.showMyDialog(
                context, 'errTitle'.tr, 'errDescMaxReached'.tr);
          } else if (result.reason == Reason.notIllegible) {
            AlertHelper.showMyDialog(
                context, 'errTitle'.tr, 'errDescIllegibility'.tr);
          } else if (result.reason == Reason.notAuthorized) {
            AlertHelper.showMyDialog(
                context, 'errTitle'.tr, 'errDescIllegibility'.tr);
          } else if (result.reason == Reason.network) {
            AlertHelper.showMyDialog(
                context, 'errTitle'.tr, 'errDescNetwork'.tr);
          } else if (result.reason == Reason.notExist) {
            AlertHelper.showMyDialog(
                context, 'errTitle'.tr, 'errDescUnknown'.tr);
          } else if (result.reason == Reason.unknown) {
            AlertHelper.showMyDialog(
                context, 'errTitle'.tr, 'errDescUnknown'.tr);
          }
        }
      }
    });
  }

  void onStartLoading() {}

  void onStopLoading() {}
}

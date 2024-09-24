import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:market/constant/const_string.dart';
import 'package:market/modelClass/positionModelClass.dart';
import 'package:market/screens/mainTab/orderTab/orderController.dart';
import 'package:market/screens/mainTab/positionTab/positionController.dart';
import 'package:market/screens/mainTab/tradeTab/tradeController.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

import '../../main.dart';
import '../../modelClass/myTradeListModelClass.dart';
import '../../modelClass/profileInfoModelClass.dart';

class SocketIOService {
  var SERVER_URL = "wss://socket-io.bazaar2.in"; //test url

  IO.Socket? socketForTrade;

  SocketIOService init() {
    log('Connecting to socket service');
    try {
      // socket = IO.io(SERVER_URL, <String, dynamic>{
      //   'transports': ['websocket'],
      //   'autoConnect': true,
      // });
      socketForTrade = IO.io(
        SERVER_URL,
        OptionBuilder().setTransports(["websocket"]).setAuth({
          'token': 'json-web-token',
        }).build(),
      );
      socketForTrade?.onConnecting((data) {
        print(data);
      });
      socketForTrade?.connect();
      socketForTrade?.onConnect((_) {
        log('connected to websocket');

        socketForTrade?.emit('subscribe', userData!.role == UserRollList.admin ? userData!.parentUser : userData!.userName!);
      });

      socketForTrade?.on("trade", (data) {
        print(data);
        try {
          if (data["userData"] != null) {
            print(data["userData"]);
            var obj = ProfileInfoData.fromJson(data["userData"]);
            if (obj.profitLoss != null && obj.brokerageTotal != null && obj.credit != null && obj.marginBalance != null && obj.tradeMarginBalance != null) {
              userData!.profitLoss = obj.profitLoss;
              userData!.brokerageTotal = obj.brokerageTotal;
              userData!.credit = obj.credit;
              userData!.marginBalance = obj.marginBalance;
              userData!.tradeMarginBalance = obj.tradeMarginBalance;
              bool isPositionAvailable = Get.isRegistered<positionController>();
              if (isPositionAvailable) {
                Get.find<positionController>().update();
              }
            }
          }

          var obj = TradeData.fromJson(data["trade"]);

          if (obj.status == "executed") {
            var vcObj = Get.find<tradeController>();

            vcObj.arrTrade.removeWhere((element) => element.tradeId == obj.tradeId);
            vcObj.arrTrade.insert(0, obj);
            vcObj.totalSuccessRecord += 1;
            vcObj.addSymbolInSocket(obj.symbolName!);
            vcObj.update();
          } else if (obj.status == "deleted") {
            bool isSuccessTradeAvailable = Get.isRegistered<tradeController>();
            if (isSuccessTradeAvailable) {
              var vcObj = Get.find<tradeController>();
              var index = vcObj.arrTrade.indexWhere((element) => element.tradeId == obj.tradeId);
              if (index != -1) {
                vcObj.arrTrade.removeAt(index);

                vcObj.update();
              }
            }
          } else {
            var vcObj = Get.find<orderController>();

            vcObj.arrTrade.removeWhere((element) => element.tradeId == obj.tradeId);
            if (obj.tradeId != null) {
              vcObj.arrTrade.insert(0, obj);
              vcObj.totalPendingRecord += 1;
              vcObj.addSymbolInSocket(obj.symbolName!);
              vcObj.update();
            }
          }

          bool isPositionAvailable = Get.isRegistered<positionController>();
          if (data["position"]["data"] != null) {
            var obj = positionListData.fromJson(data["position"]["data"]);

            if (isPositionAvailable) {
              var vcObj = Get.find<positionController>();
              var index = vcObj.arrPositionScriptList.indexWhere((element) => obj.symbolId == element.symbolId);
              if (index != -1) {
                if (data["position"]["positionStatus"] != null && data["position"]["positionStatus"] == 1) {
                  vcObj.arrPositionScriptList.removeAt(index);
                } else {
                  vcObj.arrPositionScriptList[index] = positionListData.fromJson(data["position"]["data"]);
                  vcObj.update();
                }
              } else {
                vcObj.arrPositionScriptList.insert(0, positionListData.fromJson(data["position"]["data"]));
                vcObj.arrPrePositionScriptList.insert(0, positionListData.fromJson(data["position"]["data"]));
                var arrTemp = [];
                for (var element in vcObj.arrPositionScriptList) {
                  if (!arrSymbolNames.contains(element.symbolName)) {
                    arrTemp.insert(0, element.symbolName);
                    arrSymbolNames.insert(0, element.symbolName!);
                  }
                }

                if ((arrSymbolNames.isNotEmpty)) {
                  var txt = {"symbols": arrSymbolNames};
                  socket.connectScript(jsonEncode(txt));
                }
              }
            }
          } else {
            var obj = data["position"]["symbolId"] as String;
            if (isPositionAvailable) {
              var vcObj = Get.find<positionController>();
              var index = vcObj.arrPositionScriptList.indexWhere((element) => obj == element.symbolId);
              if (index != -1) {
                vcObj.arrPositionScriptList.removeAt(index);
                vcObj.update();
              }
            }
          }
        } catch (e) {}

        try {
          // log("SOCKET NEW EVENT");
        } catch (e) {
          log(e.toString());
        }
      });

      socketForTrade?.onDisconnect((_) async {
        log('Socket disconnect');
        try {
          final result = await InternetAddress.lookup('google.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            print('connected');
          }
        } on SocketException catch (e) {
          print("Ex---------------------");
          print(e);
        }
      });
      socketForTrade?.onConnectError((data) => log(data.toString()));
    } catch (e) {
      print(e);
    }

    return this;
  }
}

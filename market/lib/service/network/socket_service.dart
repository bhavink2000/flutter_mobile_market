import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:market/constant/utilities.dart';
import 'package:market/main.dart';
import 'package:market/modelClass/getScriptFromSocket.dart';
import 'package:market/screens/mainTab/homeTab/homeController.dart';
import 'package:market/screens/mainTab/orderTab/orderController.dart';
import 'package:market/screens/mainTab/positionTab/positionController.dart';
import 'package:market/screens/mainTab/settingTab/ClientAccountReportScreen/clientAccountReportController.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:market/screens/mainTab/settingTab/openPositionScreen/openPositionController.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../screens/mainTab/settingTab/ProfitAndLossScreen/profitAndLossController.dart';
import '../../screens/mainTab/settingTab/SymbolWisePositionReportScreen/symbolWisePositionReportController.dart';
import '../../screens/mainTab/settingTab/UserListScreen/userListDetailsScreen/userDetailsController.dart';
import '../../screens/mainTab/settingTab/UserWisePositionScreen/userWisePositionScreenController.dart';
import '../../screens/mainTab/settingTab/clientP&LScreen/ClientPLScreenController.dart';
import '../../screens/mainTab/tradeTab/tradeController.dart';
import 'package:web_socket_channel/io.dart';

var bouncer = Debouncer(milliseconds: 2000);

class SocketService {
  WebSocketChannel? channel;

  connectSocket({String? symbols}) async {
    Future.delayed(Duration(seconds: 1), () async {
      try {
        isThemeChange = false;
        if (channel != null) {
          return;
        }

        // channel = IOWebSocketChannel.connect('ws://16.16.188.77:7722/data',
        //     headers: {"Authorization": "Bearer ${userToken}"}, pingInterval: Duration(seconds: 5));
        channel = IOWebSocketChannel.connect('ws://socket-2110916353.eu-north-1.elb.amazonaws.com:7722/data', headers: {"Authorization": "Bearer ${userToken}"}, pingInterval: Duration(seconds: 5));

        await channel?.ready;
        if (symbols != null) {
          connectScript(symbols);
        }
        channel?.stream.listen(
          (dynamic event) {
            bool isHomeVcAvailable = Get.isRegistered<HomeController>();
            bool isTradeVcAvailable = Get.isRegistered<tradeController>();
            bool isOrderAvailable = Get.isRegistered<orderController>();
            bool isPositionVcAvailable = Get.isRegistered<positionController>();
            bool isPlVcAvailable = Get.isRegistered<ProfitAndLossController>();
            bool isOpenPositionVcAvailable = Get.isRegistered<OpenPositionController>();
            bool isUserWisePositionVcAvailable = Get.isRegistered<UserWiseScreenController>();
            bool ism2mProfitLossAvailable = Get.isRegistered<ClientPLController>();
            // bool isUserDetailListVCAvailable = Get.isRegistered<UserListDetailsController>();
            bool isUserDetailAvailable = Get.isRegistered<UserDetailsController>();
            bool isSymbolWisePositionAvailable = Get.isRegistered<SymbolWisePositionReportController>();
            bool isAccountSummaryNewAvailable = Get.isRegistered<ClientAccountReportController>();
            if (isHomeVcAvailable) {
              var homeVC = Get.find<HomeController>();
              homeVC.listenScriptFromScoket(GetScriptFromSocket.fromJson(jsonDecode(event)));
            } else {
              // channel?.sink.close(status.goingAway);
            }
            if (isPlVcAvailable) {
              var homeVC = Get.find<ProfitAndLossController>();

              homeVC.listenUserWiseProfitLossScriptFromSocket(GetScriptFromSocket.fromJson(jsonDecode(event)));
            }
            if (isAccountSummaryNewAvailable) {
              var homeVC = Get.find<ClientAccountReportController>();

              homeVC.listenClientAccountScriptFromSocket(GetScriptFromSocket.fromJson(jsonDecode(event)));
            }
            if (isSymbolWisePositionAvailable) {
              var homeVC = Get.find<SymbolWisePositionReportController>();

              homeVC.listenSymbolWisePositionScriptFromSocket(GetScriptFromSocket.fromJson(jsonDecode(event)));
            }
            if (isUserDetailAvailable) {
              var listVC = Get.find<UserDetailsController>();

              listVC.listenTradeScriptFromScoket(GetScriptFromSocket.fromJson(jsonDecode(event)));
              listVC.listenPositionScriptFromScoket(GetScriptFromSocket.fromJson(jsonDecode(event)));
            }
            if (isTradeVcAvailable) {
              var tradeVC = Get.find<tradeController>();
              tradeVC.listenTradeScriptFromScoket(GetScriptFromSocket.fromJson(jsonDecode(event)));
            }
            if (isOrderAvailable) {
              var tradeVC = Get.find<orderController>();
              tradeVC.listenTradeScriptFromScoket(GetScriptFromSocket.fromJson(jsonDecode(event)));
            }

            if (isPositionVcAvailable) {
              var positionVC = Get.find<positionController>();
              positionVC.listenPositionScriptFromScoket(GetScriptFromSocket.fromJson(jsonDecode(event)));
            }
            if (isOpenPositionVcAvailable) {
              var openPositionVC = Get.find<OpenPositionController>();
              openPositionVC.listenPositionScriptFromScoket(GetScriptFromSocket.fromJson(jsonDecode(event)));
            }

            if (isUserWisePositionVcAvailable) {
              var userWisePositionVC = Get.find<UserWiseScreenController>();
              userWisePositionVC.listenUserWisePositionScriptFromScoket(GetScriptFromSocket.fromJson(jsonDecode(event)));
            } else {}
            if (ism2mProfitLossAvailable) {
              var m2mVC = Get.find<ClientPLController>();
              m2mVC.listenM2MProfitLossScriptFromScoket(GetScriptFromSocket.fromJson(jsonDecode(event)));
            }
          },
          onDone: () {
            print("here");
            Future.delayed(Duration(seconds: 1), () async {
              if (isLogoutRunning == false && isThemeChange == false) {
                print("here 2");
                await socket.channel?.sink.close(status.normalClosure);
                bouncer.run(() async {
                  await socket.connectSocket();
                  var txt = {"symbols": arrSymbolNames};
                  if (arrSymbolNames.isNotEmpty) {
                    socket.connectScript(jsonEncode(txt));
                  }
                });
              }
            });
          },
          onError: (error) {
            print("ping errror");
            print(error);
          },
        );
      } catch (e) {
        print(e);
      }
    });
  }

  connectScript(String symbols) async {
    log(symbols.toString());
    try {
      if (isThemeChange && socket.channel == null) {
        await socket.connectSocket(symbols: symbols);
      }
      await channel?.ready;
      log("For adding");
      channel?.sink.add(symbols);
    } catch (e) {
      // await socket.connectSocket();
      // socket.connectScript(symbols);
      print("socketDisconnected123");
      print(e);
    }
  }
}

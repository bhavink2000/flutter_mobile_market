import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:market/navigation/routename.dart';
import 'package:market/screens/mainTab/homeTab/VideoPlayerScreen/videoPlayerController.dart';
import 'package:market/screens/mainTab/homeTab/filterScreen/filterExchangeWrapper.dart';
import 'package:market/screens/mainTab/homeTab/homeController.dart';
import 'package:market/screens/mainTab/homeTab/homeInfoWrapper.dart';
import 'package:market/screens/mainTab/homeTab/notificationScreen/notificationListController.dart';
import 'package:market/screens/mainTab/homeTab/VideoPlayerScreen/videoPlayerWrapper.dart';
import 'package:market/screens/mainTab/positionTab/positionController.dart';
import 'package:market/screens/mainTab/positionTab/positionInfoWrapper.dart';
import 'package:market/screens/mainTab/settingTab/BulkTradeScreen/bulkTradeController.dart';
import 'package:market/screens/mainTab/settingTab/ClientAccountReportScreen/clientAccountReportController.dart';
import 'package:market/screens/mainTab/settingTab/ClientAccountReportScreen/clientAccountReportWrapper.dart';
import 'package:market/screens/mainTab/settingTab/GenerateBillScreen/generateBillPdfViewScreen.dart/generateBillPdfViewController.dart';
import 'package:market/screens/mainTab/settingTab/GenerateBillScreen/generateBillPdfViewScreen.dart/generateBillPdfViewWrapper.dart';
import 'package:market/screens/mainTab/settingTab/GenerateBillScreen/htmlViewerWrapper.dart';
import 'package:market/screens/mainTab/settingTab/ProfitAndLossScreen/profitAndLossController.dart';
import 'package:market/screens/mainTab/settingTab/ProfitAndLossScreen/profitAndLossWrapper.dart';
import 'package:market/screens/mainTab/settingTab/ProfitAndLossScreen/userProfitLossWrapper.dart';
import 'package:market/screens/mainTab/settingTab/SymbolWisePositionReportScreen/symbolWisePositionReportController.dart';
import 'package:market/screens/mainTab/settingTab/SymbolWisePositionReportScreen/symbolWisePositionReportWrapper.dart';
import 'package:market/screens/mainTab/settingTab/TradeLogScreen/tradeLogController.dart';
import 'package:market/screens/mainTab/settingTab/TradeLogScreen/tradeLogWrapper.dart';
import 'package:market/screens/mainTab/settingTab/UserListScreen/userListDetailsScreen/CreditGiveScreen/creditGiveController.dart';
import 'package:market/screens/mainTab/settingTab/UserListScreen/userListDetailsScreen/CreditGiveScreen/creditGiveWrapper.dart';
import 'package:market/screens/mainTab/settingTab/UserListScreen/userListDetailsScreen/GroupQuantitySettingScreen/quantitySettingController.dart';
import 'package:market/screens/mainTab/settingTab/UserListScreen/userListDetailsScreen/GroupQuantitySettingScreen/quantitySettingWrapper.dart';
import 'package:market/screens/mainTab/settingTab/UserListScreen/userListDetailsScreen/BrkSettingScreen/brkSettingController.dart';
import 'package:market/screens/mainTab/settingTab/UserListScreen/userListDetailsScreen/BrkSettingScreen/brkSettingWrapper.dart';
import 'package:market/screens/mainTab/settingTab/UserListScreen/userListDetailsScreen/TradeMarginScreen/tradeMarginController.dart';
import 'package:market/screens/mainTab/settingTab/UserListScreen/userListDetailsScreen/TradeMarginScreen/tradeMarginWrapper.dart';
import 'package:market/screens/mainTab/settingTab/UserListScreen/userListDetailsScreen/userDetailsController.dart';
import 'package:market/screens/mainTab/settingTab/UserListScreen/userListDetailsScreen/userDetailsWrapper.dart';
import 'package:market/screens/mainTab/settingTab/UserScriptPositionTrackScreen/userScriptPositionTrackController.dart';
import 'package:market/screens/mainTab/settingTab/UserScriptPositionTrackScreen/userScriptPostionTrackWrapper.dart';
import 'package:market/screens/mainTab/settingTab/accountSummaryScreen/accountSummaryListController.dart';
import 'package:market/screens/mainTab/settingTab/accountSummaryScreen/accountSummaryListWrapper.dart';
import 'package:market/screens/mainTab/settingTab/historyOfCreditScreen/historyOfCreditWrapper.dart';
import 'package:market/screens/mainTab/settingTab/openPositionScreen/openPositionController.dart';
import 'package:market/screens/mainTab/settingTab/openPositionScreen/openPositionWrapper.dart';
import 'package:market/screens/mainTab/settingTab/rejectionLogScreen/rejectionLogController.dart';
import 'package:market/screens/mainTab/settingTab/rejectionLogScreen/rejectionLogWrapper.dart';
import 'package:market/screens/mainTab/settingTab/scriptMasterScreen/scriptMasterController.dart';
import 'package:market/screens/mainTab/settingTab/scriptMasterScreen/scriptMasterWrapper.dart';
import 'package:market/screens/mainTab/tradeTab/tradeController.dart';
import 'package:market/screens/mainTab/tradeTab/tradeInfoWrapper.dart';

import '../screens/Authentication/SignInScreen/signInController.dart';
import '../screens/Authentication/SignInScreen/signInWrapper.dart';
import '../screens/mainTab/homeTab/filterScreen/filterScriptController.dart';
import '../screens/mainTab/homeTab/filterScreen/filterScriptWrapper.dart';

import '../screens/mainTab/homeTab/notificationScreen/notificationListWrapper.dart';

import '../screens/mainTab/settingTab/BulkTradeScreen/bulkTradeWrapper.dart';
import '../screens/mainTab/settingTab/CreateNewUserScreen/settingCreateNewUserController.dart';
import '../screens/mainTab/settingTab/CreateNewUserScreen/settingCreateNewUserWrapper.dart';
import '../screens/mainTab/settingTab/GenerateBillScreen/generateBillController.dart';
import '../screens/mainTab/settingTab/GenerateBillScreen/generateBillWrapper.dart';
import '../screens/mainTab/settingTab/IntradayHistoryScreen/IntradayHistoryScreenController.dart';
import '../screens/mainTab/settingTab/IntradayHistoryScreen/intradayHistoryScreenWrapper.dart';
import '../screens/mainTab/settingTab/LoginHistoryScreen/loginHistoryScreenController.dart';
import '../screens/mainTab/settingTab/LoginHistoryScreen/loginHistoryScreenWrapper.dart';
import '../screens/mainTab/settingTab/MarketTimingScreen/MarketTimingScreenController.dart';
import '../screens/mainTab/settingTab/NotificationScreen/notificationScreenController.dart';
import '../screens/mainTab/settingTab/NotificationScreen/notificationScreenWrapper.dart';
import '../screens/mainTab/settingTab/P&LScreen/PLScreenController.dart';
import '../screens/mainTab/settingTab/P&LScreen/PLScreenWrapper.dart';
import '../screens/mainTab/settingTab/ScriptQuantityScreen/ScriptQuantityScreenController.dart';
import '../screens/mainTab/settingTab/ScriptQuantityScreen/ScriptQuantityScreenWrapper.dart';
import '../screens/mainTab/settingTab/SearchUserListScreen/SearchUserListScreenController.dart';
import '../screens/mainTab/settingTab/SetQuantityValueScreen/SetQuantityValueScreenController.dart';
import '../screens/mainTab/settingTab/SettingMessageScreen/SettingMessageScreenController.dart';
import '../screens/mainTab/settingTab/SettlementReportScreen/SettlementReportScreenController.dart';
import '../screens/mainTab/settingTab/SettlementReportScreen/settlementReportScreenWrapper.dart';
import '../screens/mainTab/settingTab/UserListScreen/UserListDetailsScreen/AddOrderScreen/UserListDetailsAddOrderController.dart';
import '../screens/mainTab/settingTab/UserListScreen/UserListDetailsScreen/AddOrderScreen/userListDetailsAddOrderWrapper.dart';
import '../screens/mainTab/settingTab/UserListScreen/UserListDetailsScreen/ChangePasswordScreen/userListDetailChangePasswordController.dart';
import '../screens/mainTab/settingTab/UserListScreen/UserListDetailsScreen/ChangePasswordScreen/userListDetailChangePasswordWrapper.dart';
import '../screens/mainTab/settingTab/UserListScreen/UserListDetailsScreen/GroupQuantitySettingScreen/groupQuantitySettingController.dart';
import '../screens/mainTab/settingTab/UserListScreen/UserListDetailsScreen/GroupQuantitySettingScreen/groupQuantitySettingScreen.dart';
import '../screens/mainTab/settingTab/UserListScreen/UserListDetailsScreen/IntraDaySquareoffScreen/userListDetailIntraDayController.dart';
import '../screens/mainTab/settingTab/UserListScreen/UserListDetailsScreen/IntraDaySquareoffScreen/userListDetailIntradayWrapper.dart';
import '../screens/mainTab/settingTab/UserListScreen/UserListDetailsScreen/SharingDetailScreen/sharingDetailController.dart';
import '../screens/mainTab/settingTab/UserListScreen/UserListDetailsScreen/SharingDetailScreen/sharingDetailWrapper.dart';

// import '../screens/mainTab/settingTab/UserListScreen/UserListDetailsScreen/UserListDetailsController.dart';
import '../screens/mainTab/settingTab/UserListScreen/settingUserListController.dart';
import '../screens/mainTab/settingTab/UserListScreen/settingUserListWrapper.dart';
// import '../screens/mainTab/settingTab/UserListScreen/userListDetailsScreen/userlistDetailsWrapper.dart';
import '../screens/mainTab/settingTab/UserWisePositionScreen/userWisePositionScreenController.dart';
import '../screens/mainTab/settingTab/UserWisePositionScreen/userWisePositionScreenWrapper.dart';
import '../screens/mainTab/settingTab/WeeklyAdminScreen/WeeklyAdminController.dart';
import '../screens/mainTab/settingTab/clientP&LScreen/ClientPLScreenController.dart';
import '../screens/mainTab/settingTab/clientP&LScreen/clientPLScreenWrapper.dart';
import '../screens/mainTab/settingTab/historyOfCreditScreen/historyOfCreditController.dart';
import '../screens/mainTab/settingTab/marketTimingScreen/marketTimingScreenWrapper.dart';
import '../screens/mainTab/settingTab/profileScreen/SettingProfileScreenController.dart';
import '../screens/mainTab/settingTab/profileScreen/settingProfileScreenWrapper.dart';
import '../screens/mainTab/settingTab/searchUserListScreen/searchUserListScreenWrapper.dart';
import '../screens/mainTab/settingTab/setQuantityValueScreen/setQuantityValueScreenWrapper.dart';
import '../screens/mainTab/settingTab/settingMessageScreen/settingMessageScreenWrapper.dart';
import '../screens/mainTab/settingTab/weeklyAdminScreen/weeklyAdminWrapper.dart';
import '../screens/mainTab/tabScreen/MainTab.dart';
import '../screens/mainTab/tabScreen/MainTabController.dart';

class Pages {
  static List<GetPage> pages() {
    return [
      GetPage(name: RouterName.signInScreen, page: () => SignInScreen(), binding: SignInControllerBinding()),
      GetPage(name: RouterName.mainTab, page: () => MainTab(), binding: MainTabBinding()),
      GetPage(name: RouterName.filterscreen, page: () => const FilterScriptScreen(), binding: FilterScriptControllerBinding()),
      GetPage(name: RouterName.SettingCreateNewUserScreen, page: () => const SettingCreateNewUserScreen(), binding: SettingCreateNewUserControllerBinding()),
      GetPage(name: RouterName.SettingUserListScreen, page: () => const SettingUserListScreen(), binding: SettingUserListControllerBinding()),
      GetPage(name: RouterName.SearchUserListScreen, page: () => const SearchUserListScreen(), binding: SearchUserListControllerBinding()),
      GetPage(name: RouterName.UserListDetailsScreen, page: () => const UserDetailsScreen(), binding: UserDetailsControllerBinding()),
      GetPage(name: RouterName.UserListDetailsAddOrderScreen, page: () => const UserListDetailsAddOrderScreen(), binding: UserListDetailsAddOrderControllerBinding()),
      GetPage(name: RouterName.UserListChangePasswordScreen, page: () => const UserListChangePasswordScreen(), binding: UserListChangePasswordControllerBinding()),
      GetPage(name: RouterName.UserListIntradayScreen, page: () => const UserListIntradayScreen(), binding: UserListIntradayControllerBinding()),
      GetPage(name: RouterName.SharingDetailsScreen, page: () => const SharingDetailsScreen(), binding: SharingDetailsControllerBinding()),
      GetPage(name: RouterName.brkSettingScreen, page: () => const BrkSettingScreen(), binding: BrkSettingControllerBinding()),
      GetPage(name: RouterName.GroupQuantityScreen, page: () => const GroupQuantityScreen(), binding: GroupQuantityControllerBinding()),
      GetPage(name: RouterName.AccountSummaryScreen, page: () => const AccountSummaryListScreen(), binding: AccountSummaryListControllerBinding()),
      GetPage(name: RouterName.htmlViewerScreen, page: () => HtmlViewerScreen(), binding: GenerateBillControllerBinding()),
      GetPage(name: RouterName.GenerateBillScreen, page: () => GenerateBillScreen(), binding: GenerateBillControllerBinding()),
      GetPage(name: RouterName.WeeklyAdminScreen, page: () => const WeeklyAdminScreen(), binding: WeeklyAdminControllerBinding()),
      GetPage(name: RouterName.IntradayHistoryScreen, page: () => const IntradayHistoryScreen(), binding: IntradayHistoryControllerBinding()),
      GetPage(name: RouterName.PLScreen, page: () => const PLScreen(), binding: PLControllerBinding()),
      GetPage(name: RouterName.ClientPLScreen, page: () => const ClientPLScreen(), binding: ClientPLControllerBinding()),
      GetPage(name: RouterName.SettlementReportScreen, page: () => const SettlementReportScreen(), binding: SettlementReportControllerBinding()),
      GetPage(name: RouterName.UserWiseScreen, page: () => const UserWiseScreen(), binding: UserWiseScreenControllerBinding()),
      GetPage(name: RouterName.ScriptQuantityScreen, page: () => const ScriptQuantityScreen(), binding: ScriptQuantityControllerBinding()),
      GetPage(name: RouterName.SetQuantityValueScreen, page: () => const SetQuantityValueScreen(), binding: SetQuantityValueControllerBinding()),
      GetPage(name: RouterName.SettingMessageScreen, page: () => const SettingMessageScreen(), binding: SettingMessageControllerBinding()),
      GetPage(name: RouterName.MarketTimingScreen, page: () => const MarketTimingScreen(), binding: MarketTimingControllerBinding()),
      GetPage(name: RouterName.SettingProfileScreen, page: () => const SettingProfileScreen(), binding: SettingProfileControllerBinding()),
      GetPage(name: RouterName.SettingNotificationScreen, page: () => const SettingNotificationScreen(), binding: SettingNotificationControllerBinding()),
      GetPage(name: RouterName.SettingLoginHistoryScreen, page: () => const SettingLoginHistoryScreen(), binding: SettingLoginHistoryControllerBinding()),
      GetPage(name: RouterName.GenerateBillPdfViewScreen, page: () => const GenerateBillPdfViewScreen(), binding: GenerateBillPdfViewControllerBinding()),
      GetPage(name: RouterName.notificationScreen, page: () => const NotificaitonListScreen(), binding: notificationListControllerBinding()),
      GetPage(name: RouterName.quantitySettingScreen, page: () => const QuantitySettingScreen(), binding: QuantitySettingControllerBinding()),
      GetPage(name: RouterName.rejectionLogScreen, page: () => const RejectionLogScreen(), binding: RejectionLogControllerBinding()),
      GetPage(name: RouterName.openPositionScreen, page: () => const OpenPositionScreen(), binding: OpenPositionControllerBinding()),
      GetPage(name: RouterName.homeInfoScreen, page: () => const HomeInfoScreen(), binding: HomeControllerBinding()),
      GetPage(name: RouterName.positionInfoScreen, page: () => const PositionInfoScreen(), binding: positionControllerBinding()),
      GetPage(name: RouterName.filterExchangeScreen, page: () => const FilterExchangeScreen(), binding: FilterScriptControllerBinding()),
      GetPage(name: RouterName.tradeMarginScreen, page: () => const TradeMarginScreen(), binding: TradeMarginControllerBinding()),
      GetPage(name: RouterName.scriptMasterScreen, page: () => const ScriptMasterScreen(), binding: ScriptMasterControllerBinding()),
      GetPage(name: RouterName.tradeLogsScreen, page: () => const TradeLogScreen(), binding: TradeLogControllerBinding()),
      GetPage(name: RouterName.tradeInfoScreen, page: () => const TradeInfoScreen(), binding: tradeControllerBinding()),
      GetPage(name: RouterName.symbolWisePositionReportScreen, page: () => const SymbolWisePositionReportScreen(), binding: SymbolWisePositionReportControllerBinding()),
      GetPage(name: RouterName.userScriptPositionTracking, page: () => const UserScriptPositionTrackScreen(), binding: UserScriptPositionTrackControllerBinding()),
      GetPage(name: RouterName.profitAndLossScreen, page: () => const ProfitAndLossScreen(), binding: ProfitAndLossControllerBinding()),
      GetPage(name: RouterName.historyOfCreditScreen, page: () => HistoryOfCreditScreen(), binding: HistoryOfCreditControllerBinding()),
      GetPage(name: RouterName.accountReportScreen, page: () => ClientAccountReportScreen(), binding: ClientAccountReportControllerBinding()),
      GetPage(name: RouterName.bulkTradeScreen, page: () => BulkTradeScreen(), binding: BulkTradeControllerBinding()),
      GetPage(name: RouterName.videoPlayerscreen, page: () => VideoPlayerScreen(), binding: videoPlayerControllerBinding()),
      GetPage(name: RouterName.creditGiveScreen, page: () => CreditGiveScreen(), binding: CreditGiveControllerBinding()),
      GetPage(name: RouterName.userProfitLossScreen, page: () => UserProfitAndLossScreen()),
    ];
  }
}

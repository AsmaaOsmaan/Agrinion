import 'package:agriunion/App/GlobalWidgets/bottom_sheet_helper.dart';
import 'package:agriunion/App/Utilities/app_route.dart';
import 'package:agriunion/App/Utilities/cache_helper.dart';
import 'package:agriunion/App/Utilities/size_config.dart';
import 'package:agriunion/App/constants/keys.dart';
import 'package:agriunion/Features/Offers/Domain/Entities/conversation_entity.dart';
import 'package:agriunion/Features/Offers/Domain/Entities/offers_entity.dart';
import 'package:agriunion/Features/Offers/Domain/Entities/sales_returns_entity.dart';
import 'package:agriunion/Features/Offers/Domain/ServiceLayer/offers_service_layer.dart';
import 'package:agriunion/Features/Offers/Domain/ServiceLayer/sales_returns_service_layer.dart';
import 'package:agriunion/Features/Reports/Domian/Entities/invoice.dart';
import 'package:agriunion/Features/Reports/Domian/Service/invoices_bl.dart';
import 'package:agriunion/Features/Reports/Presentation/Screens/invoice_summary.dart';
import 'package:agriunion/Features/Reports/Presentation/Widgets/order_details_sheet.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../App/GlobalWidgets/loading_dialog.dart';
import '../../Domain/Entities/grouped_conversation.dart';

class OffersVL extends ChangeNotifier {
  final IOffersService _offersService;
  final IInvoicesBL _invoicesBL;
  final ISalesReturnsBL _salesReturnsBL;

  OffersVL(this._offersService, this._invoicesBL, this._salesReturnsBL);
  List<Offer> offers = [];
  bool isLoading = false;
  List<String> paymentMethods = ["Cache", "Credit", "debit"];
  int paymentMethodIndex = 0;
  setPaymentMethod(int index) {
    paymentMethodIndex = index;
    notifyListeners();
  }

  String selectedPaymentMethod = "Cache";
  Conversation? conversation;
  List<Conversation> pending = [];
  List<Conversation> accepted = [];
  List<Conversation> rejected = [];
  List<Conversation> unExportedconversations = [];
  List<GroupedConversation> groupedConversations = [];
  getConversationOffers(int convId) async {
    isLoading = true;
    conversation = await _offersService.showConversation(convId);
    offers = conversation!.offers!;
    isLoading = false;
    notifyListeners();
  }

  Offer? addingOffer;
  addOffer(int convId) async {
    addingOffer = await _offersService.addOffer(addingOffer!, convId);
    notifyListeners();
  }

  manageAddingOffer(BuildContext context, int adId) async {
    String? validateOffer = addingOffer?.valdiateQuantity();

    if (validateOffer != null) {
      LoadingDialog.showSimpleToast(validateOffer);
    } else {
      await addOffer(adId);
      if (addingOffer?.errors == null) {
        offers.add(addingOffer!);
      } else {
        LoadingDialog.showSimpleToast(addingOffer?.errors?.creator);
      }
    }

    notifyListeners();
  }

  Future<void> acceptOffer(Offer offer) async {
    await _offersService.acceptOffer(offer);
    changeConvStatus("approved");
    notifyListeners();
  }

  Future<void> rejectOffer(Offer offer) async {
    await _offersService.rejectOffer(offer);
    changeConvStatus("rejected");
    notifyListeners();
  }

  void changeConvStatus(String status) {
    conversation?.status = status;
  }

  getAcceptedConversations(int orderId) async {
    isLoading = true;
    accepted = await _offersService.getAcceptedConversations(orderId);
    getUnExporteConversation();
    isLoading = false;
    notifyListeners();
  }

  getPendingConversations(int orderId) async {
    isLoading = true;
    pending = await _offersService.getPeningConversations(orderId);
    isLoading = false;
    notifyListeners();
  }

  getRejectedConversations(int orderId) async {
    isLoading = true;
    rejected = await _offersService.getRejectedConversations(orderId);
    isLoading = false;
    notifyListeners();
  }

  getAcceptedGroupedConversations(int orderId) async {
    groupedConversations.clear();
    isLoading = true;
    groupedConversations =
        await _offersService.getAcceptedGroupConversations(orderId);
    isLoading = false;
    notifyListeners();
  }

  getPendingGroupedConversations(int orderId) async {
    groupedConversations.clear();
    isLoading = true;
    groupedConversations =
        await _offersService.getPeningGroupConversations(orderId);
    isLoading = false;
    notifyListeners();
  }

  getRejectedGroupedConversations(int orderId) async {
    groupedConversations.clear();
    isLoading = true;
    groupedConversations =
        await _offersService.getRejectedGroupConversations(orderId);
    isLoading = false;
    notifyListeners();
  }

  bool checkIfSeller(int id) {
    var check = conversation?.sellerGroup?.firstWhere(
          (element) => element == id,
          orElse: () => -1,
        ) !=
        -1;
    return check;
  }

  bool checkIfBuyer(int id) {
    return conversation?.buyerGroup?.firstWhere(
          (element) => element == id,
          orElse: () => -1,
        ) !=
        -1;
  }

  bool isLastOfferSenderSeller() {
    return checkIfSeller(offers.last.creatorId!);
  }

  bool isCurrentUserSeller() {
    return checkIfSeller(CachHelper.getData(key: kId));
  }

  // if the current user is seller and he is wasn't the last offer sender
  // if the conversation still pending
  // if the user was the buyer and he is the last offer sender
  showOfferBox() {
    return (isCurrentUserSeller() && !isLastOfferSenderSeller()) ||
        conversation?.status != "pending" ||
        (!isCurrentUserSeller() && isLastOfferSenderSeller());
  }

  bool isOfferSenderSeller(int index) {
    return checkIfSeller(offers[index].creatorId!);
  }

  bool showForSender(int index) {
    return (isCurrentUserSeller() && !isOfferSenderSeller(index)) ||
        (!isCurrentUserSeller() && isOfferSenderSeller(index));
  }

  InvoicesModel? summaryInvoice;
  Future<void> showExportedInvoice(int invoiceId, BuildContext context) async {
    LoadingDialog.showLoadingDialog();
    summaryInvoice = await _invoicesBL.showExportedInvoice(invoiceId);
    AppRoute().navigate(
        context: context,
        route: InvoiceSummary(
          invoicesModel: summaryInvoice!,
        ),
        withReplace: true);
    EasyLoading.dismiss();
  }

  Future<void> showExportedInvoicePdf(int invoiceId) async {
    LoadingDialog.showLoadingDialog();
    await _invoicesBL.showExportedInvoicePdf(invoiceId);
    EasyLoading.dismiss();
  }

  void getUnExporteConversation() {
    unExportedconversations =
        accepted.where((element) => element.invoiceId == null).toList();
  }

  InvoicesModel? invoice;
// create
  Future<void> exportInvoices(
      String? date, String discount, BuildContext context) async {
    LoadingDialog.showLoadingDialog();
    if (date != 'null') {
      InvoicesModel model = InvoicesModel(
          conversationsIds: exportedConversationsIds,
          supplyDate: date,
          discount: discount,
          taxable: taxValue,
          paymentMethodIndex: paymentMethodIndex);
      invoice = await _invoicesBL.exportInvoice(
          model, unExportedconversations.first.orderId!);
      Navigator.pop(context);
      AppRoute().navigate(
          context: context,
          route: InvoiceSummary(
            invoicesModel: invoice!,
          ),
          withReplace: true);
      notifyListeners();
    }
    selectAll(false);
    exportedConversationsIds.clear();
    getAcceptedConversations(unExportedconversations.first.orderId!);
    EasyLoading.dismiss();
  }

  Future<void> showExportedSalesReturnInvoice(int invoiceId) async {
    LoadingDialog.showLoadingDialog();
    await _invoicesBL.showExportedSalesReturnInvoice(invoiceId);
    EasyLoading.dismiss();
  }

  InvoicesModel? invoicesModel;
  Future<void> exportSalesReturnInvoices(int salesReturnId, int index) async {
    LoadingDialog.showLoadingDialog();
    invoicesModel = await _invoicesBL.exportSalesReturnInvoice(salesReturnId);
    salesReturns[index].invoiceGenerated = true;
    salesReturns[index].invoiceId = invoicesModel!.invoiceId!;
    showExportedSalesReturnInvoice(invoicesModel!.invoiceId!);
    notifyListeners();
  }

  List<int> exportedConversationsIds = [];
  changeSelectionStatus(bool value, int index) {
    unExportedconversations[index].selectedForInvoices = value;
  }

  void manageExportInvoice(BuildContext context) {
    exportedConversationsIds.isEmpty
        ? LoadingDialog.showSimpleToast(tr(LocaleKeys.please_select_products))
        : BottomSheetHelper(
            context: context,
            content: const OrderDetailsSheet(),
          ).openSizedSheet(height: SizeConfig.screenHeight! * .65);
  }

  addToExport(bool value, int index) {
    changeSelectionStatus(value, index);
    checkExistence(unExportedconversations[index].id!);
    isAllChecked();
    notifyListeners();
  }

  bool taxValue = false;
  changeTaxValue(bool val) {
    taxValue = val;
    notifyListeners();
  }

  void checkExistence(int id) {
    exportedConversationsIds.contains(id)
        ? exportedConversationsIds.remove(id)
        : exportedConversationsIds.add(id);
  }

  bool isAllSelected = false;
  void selectAll(bool value) {
    isAllSelected = value;
    for (var element in unExportedconversations) {
      element.selectedForInvoices = value;
      checkExistence(element.id!);
    }
    notifyListeners();
  }

  void isAllChecked() {
    isAllSelected = unExportedconversations
        .where((element) => element.selectedForInvoices == false)
        .isEmpty;
  }

  createSalesReturn(SalesReturn salesReturnModel, BuildContext context,
      int conversationId, int index) async {
   try {
      LoadingDialog.showLoadingDialog();
      await _salesReturnsBL.createSalesReturn(salesReturnModel);
      accepted[index].salesReturnsCount =
          accepted[index].salesReturnsCount! + 1;
      Navigator.pop(context);
      EasyLoading.dismiss();
      LoadingDialog.showSimpleToast(
          tr(LocaleKeys.sales_return_successfully_created));
      notifyListeners();
    } catch (e) {
      LoadingDialog.showSimpleToast("something error");
      EasyLoading.dismiss();
    }
  }

  bool loading = false;
  List<SalesReturn> salesReturns = [];
  List<InvoicesModel> invoices = [];

  Future<void> getSalesReturns(int conversationId) async {
    loading = true;
    salesReturns = await _salesReturnsBL.getSalesReturns(conversationId);
    loading = false;
    notifyListeners();
  }

  Future<void> getInvoices() async {
    loading = true;
    invoices.clear();
    invoices = await _invoicesBL.getInvoices();
    loading = false;
    notifyListeners();
  }

  Future<void> getMyInvoices() async {
    loading = true;
    invoices.clear();
    invoices = await _invoicesBL.getMyInvoices();
    loading = false;
    notifyListeners();
  }

}

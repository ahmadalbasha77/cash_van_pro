import '../core/my_shared_preferences.dart';

class ApiUrl {
  // String get ip => '192.168.1.30:80';
  String get ip => mySharedPreferences.ip;

  // String baseUrl = "http://$ip";

  static String login = "/api/Employees/Login";

  static String getCustomers =
      "/api/Customer/SelectAllCustomerByRouteDateAndEmployeeID";
  static String addCustomer = "/api/Customer/Save";

  static String getCategory = "/api/Category/SelectCategory";
  static String getItem = "/api/Items/SelectItems";
  static String getItemByCategoryId = "/api/Items/SelectItemsByCategoryID";
  static String getItemsByCategoryIDAndName =
      "/api/Items/SelectItemsByCategoryIDAndName";

  static String addCashVoucher = "/api/CashVoucher/Save";
  static String addChequesVoucher = "/api/Cheques/Save";
  static String getBank = "/api/Bank/SelectAllBank";

  static String addEditQuotation = "/api/Transaction/QuotationTransaction";
  static String getQuotation = "/api/Transaction/SelectAllQuotationTransaction";
  static String getQuotationInfo =
      "/api/Transaction/SelectAllQuotationTransactionById";

  static String addSalesInvoice = "/api/Transaction/SalesTransaction";
  static String addRefundInvoice = "/api/Transaction/RefundTransaction";
  static String addSalesAndRefund =
      "/api/Transaction/SalesAndReturnTransaction";

  static String salesInvoiceReport = "/api/Reports/SalesInvoiceReport";
  static String refundInvoiceReport = "/api/Reports/RefundSalesInvoiceReport";

  static String cashVoucherReport = "/api/Reports/CashCollectingReport";
  static String chequeVoucherReport = "/api/Reports/ChequesCollectingReport";

  static String accountStatementReport = "/api/Reports/SelectAccountStatment";
}

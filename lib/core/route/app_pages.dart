import 'package:cash_van_app/core/route/routes.dart';
import 'package:cash_van_app/view/ui/auth/ip_screen.dart';
import 'package:cash_van_app/view/ui/auth/login_screen.dart';
import 'package:cash_van_app/view/ui/home/add_customer_screen.dart';
import 'package:cash_van_app/view/ui/home/customers_screen.dart';
import 'package:cash_van_app/view/ui/home/settings_screen.dart';
import 'package:cash_van_app/view/ui/report/report_screen.dart';
import 'package:cash_van_app/view/ui/report/sales%20report/daily_sales_report_screen.dart';
import 'package:cash_van_app/view/ui/voucher/cheque_voucher_screen.dart';
import 'package:get/get.dart';

import '../../view/ui/home/transaction_history_screen.dart';
import '../../view/ui/invoice/add_invoice_screen.dart';
import '../../view/ui/invoice/add_sales_refund_invoice.dart';
import '../../view/ui/invoice/item_sales_refund_screen.dart';
import '../../view/ui/invoice/item_screen.dart';
import '../../view/ui/report/pdf_preview_screen.dart';
import '../../view/ui/report/refund report/invoice_refund_report_screen.dart';
import '../../view/ui/report/refund report/item_refund_report_screen.dart';
import '../../view/ui/report/refund report/total_refund_report_screen.dart';
import '../../view/ui/report/sales report/invoice_sales_report_screen.dart';
import '../../view/ui/report/sales report/item_sales_report_screen.dart';
import '../../view/ui/report/sales report/total_sales_report_screen.dart';
import '../../view/ui/report/stock report/stock_balance_screen.dart';
import '../../view/ui/report/voucher report/cash_voucher_report_screen.dart';
import '../../view/ui/report/voucher report/cheque_voucher_report_screen.dart';
import '../../view/ui/splash_screen.dart';
import '../middleware.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.initial,
      page: () => const SplashScreen(),
      middlewares: [AuthMiddleware()],
    ),

    //Auth
    GetPage(name: Routes.ip, page: () => IpScreen(), arguments: Get.arguments),
    GetPage(
      name: Routes.login,
      page: () => LoginScreen(),
    ),

    //Home
    GetPage(
      name: Routes.customer,
      page: () => CustomersScreen(),
    ),
    GetPage(
      name: Routes.addCustomer,
      page: () => AddCustomerScreen(),
    ),
    GetPage(
      name: Routes.settings,
      page: () => SettingsScreen(),
    ),
    GetPage(
      name: Routes.history,
      page: () => const TransactionHistoryScreen(),
    ),

    //Voucher
    GetPage(
      name: Routes.addCheque,
      page: () => ChequeVoucherScreen(customer: Get.arguments),
    ),

    //Invoice
    GetPage(
      name: Routes.item,
      page: () => ItemScreen(
        categoryId: Get.arguments['id'],
      ),
    ),
    GetPage(
      name: Routes.itemSF,
      page: () => ItemSalesRefundScreen(
        isSales: Get.arguments['isSales'],
        categoryId: Get.arguments['id'],
      ),
    ),
    GetPage(
      name: Routes.addInvoice,
      page: () => AddInvoiceScreen(
        isSales: Get.arguments['isSales'],
        type: Get.arguments['type'],
        customersData: Get.arguments['customersData'],
      ),
    ),
    GetPage(
      name: Routes.addInvoiceSF,
      page: () => AddSalesRefundInvoice(
        customersData: Get.arguments,
      ),
    ),

    //Report
    GetPage(
      name: Routes.report,
      page: () => ReportScreen(),
    ),

    GetPage(
      name: Routes.invoiceSalesReport,
      page: () => InvoiceSalesReportScreen(),
    ),
    GetPage(
      name: Routes.dailySalesReport,
      page: () => const DailySalesReportScreen(),
    ),
    GetPage(
      name: Routes.itemSalesReport,
      page: () => const ItemSalesReportScreen(),
    ),
    GetPage(
      name: Routes.totalSalesReport,
      page: () => const TotalSalesReportScreen(),
    ),

    GetPage(
      name: Routes.invoiceRefundReport,
      page: () => InvoiceRefundReportScreen(),
    ),
    GetPage(
      name: Routes.itemRefundReport,
      page: () => const ItemRefundReportScreen(),
    ),
    GetPage(
      name: Routes.totalRefundReport,
      page: () => const TotalRefundReportScreen(),
    ),

    GetPage(
      name: Routes.cashVoucherReport,
      page: () => CashVoucherReportScreen(),
    ),
    GetPage(
      name: Routes.chequeVoucherReport,
      page: () => ChequeVoucherReportScreen(),
    ),

    GetPage(
      name: Routes.stockBalance,
      page: () => const StockBalanceScreen(),
    ),

    GetPage(
      name: Routes.pdfPreview,
      page: () => PdfPreviewScreen(
        data: Get.arguments['data'],
        headers: Get.arguments['headers'],
      ),
    ),
  ];
}

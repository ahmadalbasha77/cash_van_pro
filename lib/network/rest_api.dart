import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cash_van_app/model/bank_model.dart';
import 'package:cash_van_app/model/invoice/category_model.dart';
import 'package:cash_van_app/model/invoice/item_model.dart';
import 'package:cash_van_app/model/report/sales/sales_invoice_report_model.dart';
import 'package:cash_van_app/model/report/voucher/cach_voucher_report_model.dart';
import 'package:http/http.dart' as http;
import '../core/my_shared_preferences.dart';
import '../model/api_response.dart';
import '../model/auth/login_model.dart';
import '../model/customers/customers_model.dart';
import '../model/invoice/invoice_model.dart';
import '../model/report/voucher/cheque_voucher_report_model.dart';
import 'api_url.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class RestApi {
  final ApiUrl apiUrl = ApiUrl();

  Future<bool> isConnectedToInternet() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.mobile) ||
          connectivityResult.contains(ConnectivityResult.wifi)) {
        final response = await HttpClient()
            .getUrl(Uri.parse('https://www.google.com/generate_204'))
            .then((request) => request.close());
        return response.statusCode == 204;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<ApiResponse<List<LoginModel>>> login(Map<String, dynamic> body) async {
    if (!await isConnectedToInternet()) {
      return ApiResponse(
          error:
          'No internet connection. Please check your network and try again.');
    } else {
      try {
        String url = 'http://${apiUrl.ip}${ApiUrl.login}';
        Uri uri = Uri.parse(url);

        http.Response response = await http.post(
          uri,
          body: body,
        );

        log('*********************************************');
        log('Login  :  $uri');
        log('status Code :  ${response.statusCode}');
        log('response body :  ${response.body}');
        log('*********************************************');

        if (response.statusCode == 200) {
          final List<dynamic> jsonList = jsonDecode(response.body);
          List<LoginModel> loginList =
          jsonList.map((json) => LoginModel.fromJson(json)).toList();
          return ApiResponse(data: loginList);
        } else {
          return ApiResponse(error: 'Server error occurred. Please try again.');
        }
      } catch (e) {
        log('Error during login: $e');
        return ApiResponse(error: 'An error occurred: $e');
      }
    }
  }

  Future<List<CustomersModel>> getCustomers() async {
    try {
      String url =
          'http://${apiUrl.ip}${ApiUrl.getCustomers}?employeeId=${mySharedPreferences.getUserData()!.id}';

      Uri uri = Uri.parse(url);

      http.Response response = await http.get(
        uri,
      );
      log('*********************************************');
      log('Customers  :  $uri');
      log('status Code :  ${response.statusCode}');
      log('response body :  ${response.body}');
      log('*********************************************');

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => CustomersModel.fromJson(json)).toList();
      } else {
        log('Error: Unexpected status code ${response.statusCode}');
        throw Exception('Failed to log in: ${response.body}');
      }
    } catch (e) {
      log('$e');
      return [];
    }
  }

  Future<bool> addCustomer(var body) async {
    log('$body');
    try {
      String url = 'http://${apiUrl.ip}${ApiUrl.addCustomer}';
      Uri uri = Uri.parse(url);

      http.Response response = await http.post(
        uri,
        body: body,
      );

      log('*********************************************');
      log('addCustomer  :  $uri');
      log('status Code :  ${response.statusCode}');
      log('response body :  ${response.body}');
      log('*********************************************');

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log('Error during login: $e');
      return false;
    }
  }

  Future<List<CategoryModel>> getCategory() async {
    try {
      String url = 'http://${apiUrl.ip}${ApiUrl.getCategory}';

      Uri uri = Uri.parse(url);

      http.Response response = await http.get(
        uri,
      );
      log('*********************************************');
      log('Category  :  $uri');
      log('status Code :  ${response.statusCode}');
      log('response body :  ${response.body}');
      log('*********************************************');

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => CategoryModel.fromJson(json)).toList();
      } else {
        log('Error: Unexpected status code ${response.statusCode}');
        throw Exception('Failed to log in: ${response.body}');
      }
    } catch (e) {
      log('$e');
      return [];
    }
  }

  Future<List<ItemModel>> getItem() async {
    try {
      String url = 'http://${apiUrl.ip}${ApiUrl.getItem}';

      Uri uri = Uri.parse(url);

      http.Response response = await http.get(
        uri,
      );
      log('*********************************************');
      log('Item  :  $uri');
      log('status Code :  ${response.statusCode}');
      log('response body :  ${response.body}');
      log('*********************************************');

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => ItemModel.fromJson(json)).toList();
      } else {
        log('Error: Unexpected status code ${response.statusCode}');
        throw Exception('Failed to log in: ${response.body}');
      }
    } catch (e) {
      log('$e');
      return [];
    }
  }

  Future<List<ItemModel>> getItemByCategoryId(
      {required int categoryId, String search = ''}) async {
    try {
      String url;
      if (search.isEmpty) {
        url =
            'http://${apiUrl.ip}${ApiUrl.getItemByCategoryId}?categoryId=$categoryId';
      } else {
        url =
            'http://${apiUrl.ip}${ApiUrl.getItemsByCategoryIDAndName}?categoryId=$categoryId&ItemName=$search';
      }

      Uri uri = Uri.parse(url);

      http.Response response = await http.get(
        uri,
      );
      log('*********************************************');
      log('get Item By CategoryId  :  $uri');
      log('status Code :  ${response.statusCode}');
      log('response body :  ${response.body}');
      log('*********************************************');

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => ItemModel.fromJson(json)).toList();
      } else {
        log('Error: Unexpected status code ${response.statusCode}');
        throw Exception('Failed to log in: ${response.body}');
      }
    } catch (e) {
      log('$e');
      return [];
    }
  }

  //-----------------Voucher---------------------------------
  Future<bool> addCashVoucher(var body) async {
    log('$body');
    try {
      String url = 'http://${apiUrl.ip}${ApiUrl.addCashVoucher}';
      Uri uri = Uri.parse(url);

      http.Response response = await http.post(
        uri,
        body: body,
      );

      log('*********************************************');
      log('addCashVoucher  :  $uri');
      log('status Code :  ${response.statusCode}');
      log('response body :  ${response.body}');
      log('*********************************************');

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log('Error during login: $e');
      return false;
    }
  }

  Future<bool> addChequesVoucher(var body) async {
    log('$body');
    try {
      String url = 'http://${apiUrl.ip}${ApiUrl.addChequesVoucher}';
      Uri uri = Uri.parse(url);

      http.Response response = await http.post(
        uri,
        body: body,
      );

      log('*********************************************');
      log('addCustomer  :  $uri');
      log('status Code :  ${response.statusCode}');
      log('response body :  ${response.body}');
      log('*********************************************');

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log('Error during login: $e');
      return false;
    }
  }

  Future<List<BankModel>> getBank() async {
    try {
      String url = 'http://${apiUrl.ip}${ApiUrl.getBank}';

      Uri uri = Uri.parse(url);

      http.Response response = await http.get(
        uri,
      );
      log('*********************************************');
      log('Category  :  $uri');
      log('status Code :  ${response.statusCode}');
      log('response body :  ${response.body}');
      log('*********************************************');

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => BankModel.fromJson(json)).toList();
      } else {
        log('Error: Unexpected status code ${response.statusCode}');
        throw Exception('Failed to log in: ${response.body}');
      }
    } catch (e) {
      log('$e');
      return [];
    }
  }

//-----------------Voucher---------------------------------
  //-----------------Invoice-----------------------------------------
  Future<bool> addQuotation(var body) async {
    log('$body');
    try {
      String url = 'http://${apiUrl.ip}${ApiUrl.addQuotation}';
      Uri uri = Uri.parse(url);

      http.Response response = await http.post(
        uri,
        body: body,
      );

      log('*********************************************');
      log('add Quotation  :  $uri');
      log('status Code :  ${response.statusCode}');
      log('response body :  ${response.body}');
      log('*********************************************');

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log('Error during login: $e');
      return false;
    }
  }

  Future<InvoiceModel> addSalesInvoice(var body) async {
    log('$body');
    try {
      String url = 'http://${apiUrl.ip}${ApiUrl.addSalesInvoice}';
      Uri uri = Uri.parse(url);

      http.Response response = await http.post(
        uri,
        body: body,
      );

      log('*********************************************');
      log('add Sales Invoice  :  $uri');
      log('status Code :  ${response.statusCode}');
      log('response body :  ${response.body}');
      log('*********************************************');

      if (response.statusCode == 200) {
        return InvoiceModel.fromJson(jsonDecode(response.body));
      } else {
        return InvoiceModel.fromJson({});
      }
    } catch (e) {
      log('Error during login: $e');
      return InvoiceModel.fromJson({});
    }
  }

  Future<InvoiceModel> addRefundInvoice(var body) async {
    log('$body');
    try {
      String url = 'http://${apiUrl.ip}${ApiUrl.addRefundInvoice}';
      Uri uri = Uri.parse(url);

      http.Response response = await http.post(
        uri,
        body: body,
      );

      log('*********************************************');
      log('add Refund Invoice  :  $uri');
      log('status Code :  ${response.statusCode}');
      log('response body :  ${response.body}');
      log('*********************************************');

      if (response.statusCode == 200) {
        return InvoiceModel.fromJson(jsonDecode(response.body));
      } else {
        return InvoiceModel.fromJson({});
      }
    } catch (e) {
      log('Error during login: $e');
      return InvoiceModel.fromJson({});
    }
  }

  Future<InvoiceModel> addSalesAndRefund(var body) async {
    log('$body');
    try {
      String url = 'http://${apiUrl.ip}${ApiUrl.addSalesAndRefund}';
      Uri uri = Uri.parse(url);

      http.Response response = await http.post(
        uri,
        body: body,
      );

      log('*********************************************');
      log('add Sales And Refund  :  $uri');
      log('status Code :  ${response.statusCode}');
      log('response body :  ${response.body}');
      log('*********************************************');

      if (response.statusCode == 200) {
        return InvoiceModel.fromJson(jsonDecode(response.body));
      } else {
        return InvoiceModel.fromJson({});
      }
    } catch (e) {
      log('Error during login: $e');
      return InvoiceModel.fromJson({});
    }
  }

//-----------------Invoice---------------------------------

//-----------------Report---------------------------------

  Future<List<SalesInvoiceReportModel>> getSalesInvoiceReport(
      {required String date1,
      required String date2,
      required String customerId}) async {
    try {
      String url =
          'http://${apiUrl.ip}${ApiUrl.salesInvoiceReport}?date1=$date1&date2=$date2&customerId=$customerId&salesManId=${mySharedPreferences.getUserData()!.id}&branchId=${mySharedPreferences.getUserData()!.branchId}&storeId=${mySharedPreferences.getUserData()!.storeId}';

      Uri uri = Uri.parse(url);

      http.Response response = await http.get(
        uri,
      );
      log('*********************************************');
      log('get Sales Invoice Report  :  $uri');
      log('status Code :  ${response.statusCode}');
      log('response body :  ${response.body}');
      log('*********************************************');

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList
            .map((json) => SalesInvoiceReportModel.fromJson(json))
            .toList();
      } else {
        log('Error: Unexpected status code ${response.statusCode}');
        throw Exception('Failed to log in: ${response.body}');
      }
    } catch (e) {
      log('$e');
      return [];
    }
  }

  Future<List<SalesInvoiceReportModel>> getRefundInvoiceReport(
      {required String date1,
      required String date2,
      required String customerId}) async {
    try {
      String url =
          'http://${apiUrl.ip}${ApiUrl.refundInvoiceReport}?date1=$date1&date2=$date2&customerId=$customerId&salesManId=${mySharedPreferences.getUserData()!.id}&branchId=${mySharedPreferences.getUserData()!.branchId}&storeId=${mySharedPreferences.getUserData()!.storeId}';

      Uri uri = Uri.parse(url);

      http.Response response = await http.get(
        uri,
      );
      log('*********************************************');
      log('get Refund Invoice Report  :  $uri');
      log('status Code :  ${response.statusCode}');
      log('response body :  ${response.body}');
      log('*********************************************');

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList
            .map((json) => SalesInvoiceReportModel.fromJson(json))
            .toList();
      } else {
        log('Error: Unexpected status code ${response.statusCode}');
        throw Exception('Failed to log in: ${response.body}');
      }
    } catch (e) {
      log('$e');
      return [];
    }
  }

  Future<List<CashVoucherReportModel>> getCashVoucherReport(
      {required String date1,
      required String date2,
      required String customerId}) async {
    try {
      String url =
          'http://${apiUrl.ip}${ApiUrl.cashVoucherReport}?date1=$date1&date2=$date2&customerId=$customerId&salesManId=${mySharedPreferences.getUserData()!.id}&branchId=${mySharedPreferences.getUserData()!.branchId}';

      Uri uri = Uri.parse(url);

      http.Response response = await http.get(
        uri,
      );
      log('*********************************************');
      log('get Cash Voucher Report  :  $uri');
      log('status Code :  ${response.statusCode}');
      log('response body :  ${response.body}');
      log('*********************************************');

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList
            .map((json) => CashVoucherReportModel.fromJson(json))
            .toList();
      } else {
        log('Error: Unexpected status code ${response.statusCode}');
        throw Exception('Failed to log in: ${response.body}');
      }
    } catch (e) {
      log('$e');
      return [];
    }
  }

  Future<List<ChequeVoucherReportModel>> getChequeVoucherReport(
      {required String date1,
      required String date2,
      required String customerId}) async {
    try {
      String url =
          'http://${apiUrl.ip}${ApiUrl.chequeVoucherReport}?date1=$date1&date2=$date2&customerId=$customerId&salesManId=${mySharedPreferences.getUserData()!.id}&branchId=${mySharedPreferences.getUserData()!.branchId}';

      Uri uri = Uri.parse(url);

      http.Response response = await http.get(
        uri,
      );
      log('*********************************************');
      log('get Cheque Voucher Report  :  $uri');
      log('status Code :  ${response.statusCode}');
      log('response body :  ${response.body}');
      log('*********************************************');

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList
            .map((json) => ChequeVoucherReportModel.fromJson(json))
            .toList();
      } else {
        log('Error: Unexpected status code ${response.statusCode}');
        throw Exception('Failed to log in: ${response.body}');
      }
    } catch (e) {
      log('$e');
      return [];
    }
  }

//-----------------Report---------------------------------
}

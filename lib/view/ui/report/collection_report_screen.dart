import 'package:cash_van_app/controller/customers/customers_controller.dart';
import 'package:cash_van_app/core/app_color.dart';
import 'package:cash_van_app/core/utils.dart';
import 'package:cash_van_app/view/widget/auth/custom_text_filed.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CollectionReportScreen extends StatefulWidget {
  const CollectionReportScreen({super.key});

  @override
  State<CollectionReportScreen> createState() => _CollectionReportScreenState();
}

class _CollectionReportScreenState extends State<CollectionReportScreen> {
  DateTime? fromDate;
  DateTime? toDate;
  String? selectedClient;

  final controller = Get.find<CustomersController>();

  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Collection Report'.tr),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFiledWidget(
                readOnly: true,
                suffixIcon: const Icon(Icons.calendar_today),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: toDateController.text.isNotEmpty
                        ? DateFormat('yyyy-MM-dd').parse(toDateController.text)
                        : DateTime(2101),
                  );

                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    setState(() {
                      fromDateController.text = formattedDate;
                    });
                  } else {}
                },
                controller: fromDateController,
                label: 'From Date',
                hint: fromDate != null
                    ? '${fromDate!.year}-${fromDate!.month}-${fromDate!.day}'
                    : 'Select a date'),
            const SizedBox(height: 16),
            CustomTextFiledWidget(
                readOnly: true,
                suffixIcon: const Icon(Icons.calendar_today),
                onTap: () async {
                  if (fromDateController.text.isEmpty) {
                    Utils.showFlutterToast('Enter the from date first'.tr);
                  } else {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: fromDateController.text.isNotEmpty
                          ? DateFormat('yyyy-MM-dd')
                              .parse(fromDateController.text)
                          : DateTime(2000),
                      lastDate: DateTime(2101),
                    );

                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      setState(() {
                        toDateController.text = formattedDate;
                      });
                    } else {}
                  }
                },
                controller: toDateController,
                label: 'To Date',
                hint: toDate != null
                    ? '${toDate!.year}-${toDate!.month}-${toDate!.day}'
                    : 'Select a date'),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Client'.tr,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              value: selectedClient,
              items: controller.customersList
                  .map((client) => DropdownMenuItem(
                      value: client.id.toString(), child: Text(client.aName)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedClient = value;
                });
              },
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ButtonStyle(
                    padding: const WidgetStatePropertyAll(
                        EdgeInsets.symmetric(vertical: 15)),
                    backgroundColor:
                        WidgetStatePropertyAll(AppColor.primaryColor)),
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                label: const Text(
                  'Show',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

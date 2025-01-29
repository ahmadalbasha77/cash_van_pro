import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/customers/customers_controller.dart';

class CustomerDropdownWidget extends StatefulWidget {
  final Function(String?) onChanged;

  const CustomerDropdownWidget({super.key, required this.onChanged});

  @override
  State<CustomerDropdownWidget> createState() => _CustomerDropdownWidgetState();
}

class _CustomerDropdownWidgetState extends State<CustomerDropdownWidget> {
  final controller = Get.find<CustomersController>();

  String? selectedClient;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Customer Name'.tr,
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
        selectedClient = value;
        widget.onChanged(value);
      },
    );
  }
}

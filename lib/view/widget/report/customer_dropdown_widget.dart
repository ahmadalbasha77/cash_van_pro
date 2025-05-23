import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../../../controller/customers/customers_controller.dart';

class CustomerDropdownWidget extends StatelessWidget {
  final Function(String?) onChanged;
  final String? label;

  const CustomerDropdownWidget(
      {super.key, required this.onChanged, this.label});

  @override
  Widget build(BuildContext context) {
    String? selectedClient;

    final controller = Get.find<CustomersController>();

    return DropdownSearch<String>(
      asyncItems: (String filter) async {
        return controller.customersList
            .where((client) =>
                client.aName.toLowerCase().contains(filter.toLowerCase()))
            .map((client) => client.aName)
            .toList();
      },
      selectedItem: selectedClient,
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          labelText: label ?? 'Customer Name'.tr,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      popupProps: PopupProps.menu(
        showSearchBox: true,
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            labelText: label ?? 'Search Customer'.tr,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      onChanged: (value) {
        selectedClient = controller.customersList
            .firstWhereOrNull((client) => client.aName == value)
            ?.id
            .toString();
        onChanged(selectedClient);
      },
    );
  }
}

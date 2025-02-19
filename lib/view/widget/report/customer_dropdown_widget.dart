import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../../../controller/customers/customers_controller.dart';

class CustomerDropdownWidget extends StatefulWidget {
  final Function(String?) onChanged;

  const CustomerDropdownWidget({super.key, required this.onChanged});

  @override
  State<CustomerDropdownWidget> createState() => _CustomerDropdownWidgetState();
}

class _CustomerDropdownWidgetState extends State<CustomerDropdownWidget> {
  final controller = CustomersController.to;

  String? selectedClient;

  @override
  Widget build(BuildContext context) {
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
          labelText: 'Customer Name'.tr,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      popupProps: PopupProps.menu(
        showSearchBox: true,
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            labelText: 'Search Customer'.tr,
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
        widget.onChanged(selectedClient);
      },
    );
  }
}

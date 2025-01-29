import 'package:cash_van_app/view/widget/report/to_date_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_color.dart';
import 'from_date_widget.dart';

class FilterReportWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  final TextEditingController fromDateController;
  final TextEditingController toDateController;
  final List<Widget> widgets;
  final void Function() onTap;
  final Widget reportWidget;

  const FilterReportWidget(
      {super.key,
      required this.formKey,
      required this.fromDateController,
      required this.toDateController,
      required this.widgets,
      required this.onTap,
      required this.reportWidget});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Form(
          key: formKey,
          child: Row(
            children: [
              FromDateWidget(
                  fromDateController: fromDateController,
                  toDateController: toDateController),
              const SizedBox(width: 15),
              const Icon(
                Icons.sync_alt,
                color: Colors.black54,
                size: 20,
              ),
              const SizedBox(width: 15),
              ToDateWidget(
                  fromDateController: fromDateController,
                  toDateController: toDateController),
            ],
          ),
        ),
        Column(children: widgets),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            style: ButtonStyle(
                padding: const WidgetStatePropertyAll(
                    EdgeInsets.symmetric(vertical: 15)),
                backgroundColor: WidgetStatePropertyAll(AppColor.primaryColor)),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                onTap();
              }
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            label: Text(
              'Show'.tr,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        reportWidget
      ],
    );
  }
}

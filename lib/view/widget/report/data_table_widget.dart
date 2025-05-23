import 'package:cash_van_app/core/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DataTableWidget extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> data;
  final List<String> headers;
  final List<Widget>? actions;

  const DataTableWidget({
    super.key,
    required this.title,
    required this.data,
    required this.headers,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: AppTextStyles.bold16),
              Row(
                children: actions ?? [],
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          PaginatedDataTable(
            // header: Text(title, style: AppTextStyles.bold14),
            columns: headers
                .map(
                  (header) => DataColumn(
                    label: Text(
                      header.tr,
                      style: AppTextStyles.bold14,
                    ),
                  ),
                )
                .toList(),
            source: _DataSource(data, headers),
            rowsPerPage: 10,
            columnSpacing: MediaQuery.of(context).size.width * 0.085,
          ),
        ],
      ),
    );
  }
}

class _DataSource extends DataTableSource {
  final List<Map<String, dynamic>> data;
  final List<String> headers;

  _DataSource(this.data, this.headers);

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;

    final row = data[index];
    return DataRow(
      cells: headers.map((header) {
        final cellValue = row[header];
        final displayValue = cellValue is bool
            ? cellValue == true
                ? 'Yes'
                : 'No'
            : cellValue != null
                ? (cellValue.toString().length > 30
                    ? '${cellValue.toString().substring(0, 27)}...'
                    : cellValue.toString())
                : '-';

        return DataCell(
          SizedBox(
            child: Text(
              displayValue,
              style: AppTextStyles.regular14,
              overflow: TextOverflow.ellipsis,
              // softWrap: true,
              maxLines: 2,
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}

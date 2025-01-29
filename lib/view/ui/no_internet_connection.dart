import 'package:cash_van_app/controller/internet_connection_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoInternetConnection extends StatelessWidget {
  const NoInternetConnection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = InternetConnectionController.to;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Icon(
                Icons.wifi_off_sharp,
                size: 200,
                color: Colors.grey,
              ),
            ),
            const Center(
              child: Text(
                'No Internet Connection',
                style: TextStyle(fontSize: 30),
              ),
            ),
            GetBuilder<InternetConnectionController>(
                builder: (logic) => controller.isLoading == true
                    ? const Center(child: CircularProgressIndicator())
                    : IconButton(
                        onPressed: () {
                          controller.checkInternetConnection();
                        },
                        icon: const Icon(
                          Icons.refresh,
                          size: 30,
                        )))
          ],
        ),
      ),
    );
  }
}

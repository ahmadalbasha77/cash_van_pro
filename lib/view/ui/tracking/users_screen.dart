import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import '../../../core/app_color.dart';
import '../../../model/tracking/map_model.dart';
import 'map_screen.dart';

class DeliveryListScreen extends StatelessWidget {
  DeliveryListScreen({super.key});

  final List<DeliveryAgent> agents = [
    DeliveryAgent(name: 'أحمد الزعبي', phone: '0791234567', lat: 31.963158, lng: 35.930359),
    DeliveryAgent(name: 'محمد العلي', phone: '0797654321', lat: 31.968158, lng: 35.935359),
    DeliveryAgent(name: 'سارة النجار', phone: '0799988776', lat: 31.961100, lng: 35.927700),
    DeliveryAgent(name: 'خالد الحياري', phone: '0788887744', lat: 31.970500, lng: 35.920300),
    DeliveryAgent(name: 'نور المصري', phone: '0796655443', lat: 31.965900, lng: 35.933100),
    DeliveryAgent(name: 'علي السواعير', phone: '0785566443', lat: 31.959800, lng: 35.931500),
    DeliveryAgent(name: 'أمينة الخطيب', phone: '0773344556', lat: 31.962300, lng: 35.928400),
    DeliveryAgent(name: 'يزن المومني', phone: '0791112233', lat: 31.967700, lng: 35.936600),
    DeliveryAgent(name: 'رهف الزريقات', phone: '0781237894', lat: 31.964000, lng: 35.937800),
    DeliveryAgent(name: 'سامر أبو رياش', phone: '0794477889', lat: 31.966600, lng: 35.926900),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('قائمة المندوبين'),
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: agents.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final agent = agents[index];

          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // معلومات المندوب الأساسية
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColor.primaryColor.withOpacity(0.1),
                      child: Icon(Icons.person, color: AppColor.primaryColor),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            agent.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            agent.phone,
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        final url = Uri.parse('tel:${agent.phone}');
                        launchUrl(url);
                      },
                      icon: const Icon(Icons.phone, color: Colors.green),
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: () {
                    Get.to(() => DeliveryMapScreen(agent: agent));
                  },
                  icon: const Icon(Icons.location_on_outlined),
                  label: const Text('موقع المندوب'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primaryColor.withOpacity(0.08),
                    foregroundColor: AppColor.primaryColor,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

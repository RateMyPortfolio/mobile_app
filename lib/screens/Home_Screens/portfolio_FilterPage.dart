import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/homescreen_controller.dart';

class FilterPage extends StatelessWidget {
  final HomeScreenController controller = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Portfolio Size Section
              ExpansionTile(
                title: Text('Portfolio Size'),
                children: [
                  Obx(() => RadioListTile<String>(
                    title: Text('<1,000'),
                    value: '<1,000',
                    groupValue: controller.selectedPortfolioSize.value,
                    onChanged: (value) {
                      controller.updatePortfolioSize(value!);
                    },
                  )),
                  Obx(() => RadioListTile<String>(
                    title: Text('<10,000'),
                    value: '<10,000',
                    groupValue: controller.selectedPortfolioSize.value,
                    onChanged: (value) {
                      controller.updatePortfolioSize(value!);
                    },
                  )),
                  Obx(() => RadioListTile<String>(
                    title: Text('<1,00,000'),
                    value: '<1,00,000',
                    groupValue: controller.selectedPortfolioSize.value,
                    onChanged: (value) {
                      controller.updatePortfolioSize(value!);
                    },
                  )),
                  // Add more options similarly...
                ],
              ),
              SizedBox(height: 10),

              // Portfolio Returns Section
              ExpansionTile(
                title: Text('Portfolio Returns'),
                children: [
                  Obx(() => RadioListTile<String>(
                    title: Text('>5%'),
                    value: '>5%',
                    groupValue: controller.selectedPortfolioReturn.value,
                    onChanged: (value) {
                      controller.updatePortfolioReturn(value!);
                    },
                  )),
                  Obx(() => RadioListTile<String>(
                    title: Text('>10%'),
                    value: '>10%',
                    groupValue: controller.selectedPortfolioReturn.value,
                    onChanged: (value) {
                      controller.updatePortfolioReturn(value!);
                    },
                  )),
                  Obx(() => RadioListTile<String>(
                    title: Text('>15%'),
                    value: '>15%',
                    groupValue: controller.selectedPortfolioReturn.value,
                    onChanged: (value) {
                      controller.updatePortfolioReturn(value!);
                    },
                  )),
                  // Add more options similarly...
                ],
              ),

              // More sections can be added here (User Ranking, Monetization, etc.)

              SizedBox(height: 20),

              // Apply Button
              ElevatedButton(
                onPressed: () {
                  // Handle apply action here
                  Get.snackbar('Filters Applied', 'Your filters have been applied!');
                },
                child: Text('Apply Now'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50), // Full-width button
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

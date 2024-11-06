import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rate_my_portfolio/resources/my_colors.dart';
import 'package:rate_my_portfolio/utils/my_global.dart';
import '../../controllers/homescreen_controller.dart';
import '../../utils/widgets/my_button.dart';

class PortFolioFilterPage extends StatefulWidget {
  @override
  State<PortFolioFilterPage> createState() => _PortFolioFilterPageState();
}

class _PortFolioFilterPageState extends State<PortFolioFilterPage> {
  final HomeScreenController getXController = Get.put(HomeScreenController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getXController.getFilterData();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: Back(),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filter',
              style: TextStyle(
                color: MyColor.primaryDarkColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              getXController.clearFilters();
            },
            child: Text(
              'Clear Filters',
              style: TextStyle(
                color: MyColor.primaryDarkColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        return (getXController.portfolioSizeList.value == null || getXController.portfolioReturnsList.value == null)
            ? Center()
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    children: [
                      _buildFilterCard(
                        title: 'Portfolio Size',
                        options: getXController.portfolioSizeList.value!.portfolioSize,
                        groupValue: getXController.selectedPortfolioSize.value,
                        onChanged: (value) {
                          getXController.selectedPortfolioSize.value = value!;
                        },
                      ),
                      SizedBox(height: 6),
                      _buildFilterCard(
                        title: 'Portfolio Returns (%)',
                        options: getXController.portfolioReturnsList.value!.portfolioReturns!,
                        groupValue: getXController.selectedPortfolioReturn.value,
                        onChanged: (value) {
                          getXController.selectedPortfolioReturn.value = value!;
                        },
                      ),
                      SizedBox(height: 6),
                      ElevatedButton(
                        onPressed: () {
                          getXController.portfolioListingData();
                        },
                        child: Text('Apply Now'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: Theme.of(context).primaryColor,
                          padding: EdgeInsets.symmetric(horizontal: Get.height * 0.14, vertical: 12),
                          textStyle: TextStyle(fontSize: 16),
                          elevation: 3.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(color: MyColor.GetStartedBorderGreyColor, width: 1.0)
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              );
      }),
    );
  }

  Widget _buildFilterCard({
    required String title,
    required List<int>? options,
    required String? groupValue,
    required Function(String?) onChanged,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.0,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ExpansionTile(
        initiallyExpanded: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: MyColor.primaryDarkColor,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        children: [
          Divider(color: MyColor.whiteGreyColor, thickness: 1.0,),
          for (int option in options!)
            RadioListTile<String>(
              dense: true,
              visualDensity: VisualDensity.compact,
              title: Text(
                _formatOptionText(option, title),
                style: TextStyle(
                  fontSize: 15,
                  color: groupValue == option.toString() ? MyColor.primaryColor : MyColor.matricsgreyColor,
                ),
              ),
              value: option.toString(),
              groupValue: groupValue,
              activeColor: MyColor.primaryColor,
              onChanged: onChanged,
            ),
        ],
      ),
    );
  }

  String _formatOptionText(int option, String title) {

    if (title == 'Portfolio Size') {
      return '<$option';
    } else if (title == 'Portfolio Returns (%)') {
      return '>$option%';
    }
    return option.toString();
  }

}

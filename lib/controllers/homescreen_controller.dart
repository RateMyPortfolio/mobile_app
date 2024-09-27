import 'package:get/get.dart';
import 'package:rate_my_portfolio/models/responce/post_GetProfile_responce.dart';

import '../models/request/post_getprofile_request.dart';
import '../network/repositary.dart';
import '../utils/local_database/key_constants.dart';
import '../utils/local_database/shdf.dart';
import '../utils/widgets/snackbar.dart';

class HomeScreenController extends GetxController {
  var portfolios = <Portfolio>[].obs;

  //filterpage data
  var selectedPortfolioSize = '<1,000'.obs;
  var selectedPortfolioReturn = '>15%'.obs;

  Totalholding? totalHoldings;

  List<Holdings> holdingsList = [];

  void updatePortfolioSize(String value) {
    selectedPortfolioSize.value = value;
  }
  void updatePortfolioReturn(String value) {
    selectedPortfolioReturn.value = value;
  }

  @override
  void onInit() {
    super.onInit();
    // Fetch the portfolio data
    fetchPortfolioData();
  }

  void fetchPortfolioData() {
    portfolios.value = [
      Portfolio(username: '@ankit', profileName: 'Reliance Capital', performanceMetricsLeft: '1,00,000', performanceMetricsRight: 'Test 2', boughtStocks: ['In Rosys', 'HDFC'], soldStocks: ['Colgate', 'HUL'], isPremium: true),
      Portfolio(username: '@zuber', profileName: 'Reliance Capital', performanceMetricsLeft: '10,000', performanceMetricsRight: 'Test 2', boughtStocks: ['In Rosys', 'HDFC'], soldStocks: ['Colgate', 'HUL'], isPremium: false),
      Portfolio(username: '@ajaysingh', profileName: 'Reliance Capital', performanceMetricsLeft: 'Test 1', performanceMetricsRight: 'Test 2', boughtStocks: ['In Rosys', 'HDFC'], soldStocks: ['Colgate', 'HUL'], isPremium: true),
    ];
  }


  Future<void> getPortfolioProfileViewData() async {
    totalHoldings = null;
    holdingsList = [];
    int? userId = await SHDFClass.readIntValue(KeyConstants.userId, 0);

    GetProfileRequest getProfileRequest = GetProfileRequest(
      userId: userId.toString(),
    );

    final response = await Repository.hitPostGetProfileApi(getProfileRequest);

    if (response != null && response.status == 200) {

      if(response.payload != null && response.payload!.data != null) {
        totalHoldings = response.payload!.data!.totalholding;
        holdingsList = response.payload!.data!.holdings!;
      }
    } else {
      DisplaySnackbar().errorSnackBar(
        title: "Failed",
        msg: response?.msg ?? "An error occurred",
      );
    }
  }
}

class Portfolio {
  final String username;
  final String profileName;
  final String performanceMetricsLeft;
  final String performanceMetricsRight;
  final List<String> boughtStocks;
  final List<String> soldStocks;
  final bool isPremium;

  Portfolio({
    required this.username,
    required this.profileName,
    required this.performanceMetricsLeft,
    required this.performanceMetricsRight,
    required this.boughtStocks,
    required this.soldStocks,
    required this.isPremium,
  });
}

import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  var portfolios = <Portfolio>[].obs;

  //filterpage data
  var selectedPortfolioSize = '<1,000'.obs;
  var selectedPortfolioReturn = '>15%'.obs;
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

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../models/request/portfolio_detailPage_request.dart';
import '../models/request/portfolio_likeDeslikeComment_request.dart';
import '../models/request/portfolio_listingCommunityReview_request.dart';
import '../models/request/post_PortfolioListing_request.dart';
import '../models/request/post_getprofile_request.dart';
import '../models/responce/portfolio_detailPage_responce.dart';
import '../models/responce/post_FilterData_responce.dart';
import '../models/responce/post_GetProfile_responce.dart';
import '../models/responce/post_PortfolioListing_responce.dart';
import '../network/repositary.dart';
import '../screens/Home_Screens/Listing_page.dart';
import '../utils/local_database/key_constants.dart';
import '../utils/local_database/shdf.dart';
import '../utils/widgets/snackbar.dart';
import 'login_controller.dart';

class HomeScreenController extends GetxController {
  var portfolios = <PortfolioListingpayload>[].obs;
  //filter page
  var portfolioSizeList = Rxn<filterPayload>();
  var portfolioReturnsList = Rxn<filterPayload>();
  var selectedPortfolioSize = ''.obs;
  var selectedPortfolioReturn = ''.obs;
  Totalholding? totalportfDetailHoldings;
  String description = "";

  List<String> performanceMatrix = [];
  List<CommunityReviews> communityReview = [];
  List<Replies> resplieslist = [];

  void updatePortfolioSize(String size) {
    selectedPortfolioSize.value = size;
  }

  void updatePortfolioReturn(String returnValue) {
    selectedPortfolioReturn.value = returnValue;
  }

  void clearFilters() {
    selectedPortfolioSize.value = '';
    selectedPortfolioReturn.value = '';
  }

  //current user profilepage holdings
  Totalholding? totalHoldings;
  List<Holdings> holdingsList = [];
  Payload? userUpdatedata;
  //portfolio Listing detail page
  final listinngDetailsAddReview = TextEditingController();
  final repliesCommenttext = TextEditingController();
  // portfolioDetailTotalholding? totalportfDetailHoldings;
  List<Holdings> holdingsportfDetailList = [];
  var isPerformanceExpanded = false.obs;
  var isHoldingsExpanded = false.obs;
  var isCommunityExpanded = false.obs;
  String userName = "";
  String profileImg = "";
  int userId = 0;

  //select price plan page
  var selectedPlan = ''.obs;

  void selectPlan(String plan) {
    selectedPlan.value = plan;
    print("Selected Plan: $plan");
  }

  @override
  void onInit() {
    super.onInit();
    getUserData();
    portfolioListingData();
  }

  getUserData() async {
    userName = await SHDFClass.readStringValue(KeyConstants.userName, "") ?? "";
    profileImg = await SHDFClass.readStringValue(KeyConstants.profileImg, "") ?? "";
    userId = await SHDFClass.readIntValue(KeyConstants.userId, 0) ?? 0;
  }

  Future<void> getPortfolioProfileViewData() async {
    totalHoldings = null;
    holdingsList = [];

    int? userId = await SHDFClass.readIntValue(KeyConstants.userId, 0);

    GetProfileRequest getProfileRequest = GetProfileRequest(
      userId: userId.toString(),
    );
    final response = await Repository.hitPostGetProfileApi(getProfileRequest, Get.context!);

    if (response != null && response.status == 200) {
      if (response.payload != null) {
        description = response.payload!.description ??'';
        userUpdatedata = response.payload!;

        if (response.payload!.data != null) {
          totalHoldings = response.payload!.data!.totalholding;
          holdingsList = response.payload!.data!.holdings!;
        }
      }
    } else {
      DisplaySnackbar().errorSnackBar(
        title: "Failed",
        msg: response?.msg ?? "An error occurred",
      );
    }
  }

  Future<void> portfolioListingData() async {
    int? userId = await SHDFClass.readIntValue(KeyConstants.userId, 0);

    PortfolioListingRequest portfolioListingRequest = PortfolioListingRequest(
      userId: userId.toString(),
      portfolioSize: selectedPortfolioSize.value,
      portfolioReturns: selectedPortfolioReturn.value,
    );

    final response = await Repository.hitPortfolioListingApi(portfolioListingRequest, Get.context!);
    if (response != null && response.status == 200) {
      portfolios.value = response.payload ?? [];
      print("data:-" + response.toJson().toString());
      Get.to(() => PortfolioListingPage());
    } else {
      DisplaySnackbar().errorSnackBar(
        title: "Failed",
        msg: response?.msg ?? "An error occurred",
      );
    }
  }

  Future<void> portfolioDetailPageData(int portfolioId, BuildContext context) async {
    int? userId = await SHDFClass.readIntValue(KeyConstants.userId, 0);

    PortfolioDetailpageRequest portfolioDetailpageRequest = PortfolioDetailpageRequest(
      portfolioId: portfolioId,
      userId: userId,
    );
    final response = await Repository.hitPortfolioDetailsApi(portfolioDetailpageRequest, context);
    if (response != null && response.status == 200) {
      print("detail page data:-" + response.toJson().toString());

      if (response.payload != null && response.payload!.portfolioHolding!.data != null) {
        totalportfDetailHoldings = response.payload!.portfolioHolding!.data!.totalholding;
        holdingsportfDetailList = response.payload!.portfolioHolding!.data!.holdings!;
        performanceMatrix = response.payload!.performaceMetrics!;
        communityReview = response.payload!.communityReviews!;
      }
    } else {
      DisplaySnackbar().errorSnackBar(
        title: "Failed",
        msg: response?.msg ?? "An error occurred",
      );
    }
  }

  Future<void> portfolioListingAddCommunityReview(
    bool isReply,
    int portfolioId,
    int? commentId,
  ) async {
    int? userId = await SHDFClass.readIntValue(KeyConstants.userId, 0);

    portfolioCommunityReviewRequest portfolioReviewRequest = portfolioCommunityReviewRequest(
      portfolioId: portfolioId,
      userId: userId,
      replyCommentId: commentId,
      reviewText: isReply ? repliesCommenttext.text.trim() : listinngDetailsAddReview.text.trim(),
    );
    final response = await Repository.hitPortfolioListingCommunityReviewApi(portfolioReviewRequest, isReply, Get.context!);
    if (response != null && response.status == 200) {
      print("detail page data:-" + response.toJson().toString());
      DisplaySnackbar().successSnackBar(
        title: "Success",
        msg: "Review submitted successfully",
      );
      listinngDetailsAddReview.clear();
      repliesCommenttext.clear();
    } else {
      listinngDetailsAddReview.clear();
      repliesCommenttext.clear();
      DisplaySnackbar().errorSnackBar(
        title: "Failed",
        msg: response?.msg ?? "An error occurred",
      );
    }
  }

  Future<void> portfolioListingLikeDislikeComment(int reviewId, bool? isLikedbyme) async {
    int? userId = await SHDFClass.readIntValue(KeyConstants.userId, 0);

    LikeDeslikeComment_request likeDeslikeComment_request = LikeDeslikeComment_request(
      userId: userId,
      isLike: isLikedbyme,
      replyId: null,
      reviewId: reviewId,
    );

    final response = await Repository.hitListingLikeDislikeCommentApi(likeDeslikeComment_request, Get.context!);
    if (response != null && response.status == 200) {
      print("Like Deslike page data:-" + response.toJson().toString());
    } else {
      DisplaySnackbar().errorSnackBar(
        title: "Failed",
        msg: response?.msg ?? "An error occurred",
      );
    }
  }

  Future<void> getFilterData() async {
    final response = await Repository.hitFilterDataApi();

    if (response != null && response.status == 200) {
      print("data:- ${response.toJson().toString()}");
      portfolioSizeList.value = response.payload;
      portfolioReturnsList.value = response.payload;
    } else {
      DisplaySnackbar().errorSnackBar(
        title: "Failed",
        msg: response?.msg ?? "An error occurred",
      );
    }
  }
}

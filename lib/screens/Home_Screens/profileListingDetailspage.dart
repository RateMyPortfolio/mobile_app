import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rate_my_portfolio/models/responce/post_GetProfile_responce.dart';
import 'package:rate_my_portfolio/models/responce/post_PortfolioListing_responce.dart';
import 'package:rate_my_portfolio/resources/my_colors.dart';
import 'package:rate_my_portfolio/utils/my_global.dart';
import '../../controllers/homescreen_controller.dart';
import '../../models/responce/portfolio_detailPage_responce.dart';
import '../../resources/my_assets.dart';
import '../../utils/widgets/my_button.dart';

class portfolioProfileDetail extends StatefulWidget {
  PortfolioListingpayload portfolio;
  portfolioProfileDetail(this.portfolio);

  @override
  State<portfolioProfileDetail> createState() => _State();
}

class _State extends State<portfolioProfileDetail> {
  final HomeScreenController getXcontroller = Get.put(HomeScreenController());
  List<Holdings> holdingsportfDetailList = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fetchData();
    });

    super.initState();
  }

  Future<void> fetchData() async {
    getXcontroller.totalportfDetailHoldings = null;
    getXcontroller.holdingsportfDetailList = [];
    getXcontroller.performanceMatrix = [];
    getXcontroller.communityReview = [];
    setState(() {});
    await getXcontroller.portfolioDetailPageData(widget.portfolio.portfolioId!, context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.primaryLightColor,
      appBar: AppBar(
        leading: Back(),
        leadingWidth: Get.width * 0.1,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: MyColor.matricsgreyColor,
              backgroundImage: widget.portfolio.profileImg!.isNotEmpty ? NetworkImage(widget.portfolio.profileImg!) : null,
              child: widget.portfolio.profileImg!.isEmpty ? Image(image: portfolioprofileLogo) : null,
            ),
            SizedBox(width: 10),
            Text(
              widget.portfolio.username!,
              style: TextStyle(
                color: MyColor.primaryDarkColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: MyColor.whiteGreyColor, width: 1),
                ),
                child: ExpansionTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    // side: BorderSide(color: MyColor.whiteGreyColor, width: 1),
                  ),
                  title: Text(
                    "Performance Metrics",
                    style: TextStyle(color: MyColor.primaryDarkColor, fontWeight: FontWeight.bold),
                  ),
                  onExpansionChanged: (bool expanded) {
                    getXcontroller.isPerformanceExpanded.value = expanded;
                  },
                  initiallyExpanded: true,
                  children: [
                    Divider(
                      color: MyColor.whiteGreyColor,
                      thickness: 1.0,
                    ),
                    Container(
                      width: Get.width,
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      child: Container(
                        width: Get.width,
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        child: getXcontroller.performanceMatrix.isEmpty
                            ? Text(
                          "No data available",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: MyColor.matricsgreyColor,
                          ),
                        )
                            : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: getXcontroller.performanceMatrix.map((item) {
                            return Text(
                              item,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: MyColor.matricsgreyColor,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: MyColor.whiteGreyColor, width: 1),
                ),
                child: ExpansionTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    // side: BorderSide(color: MyColor.whiteGreyColor, width: 1),
                  ),
                  title: Text(
                    "Holding",
                    style: TextStyle(
                      color: MyColor.primaryDarkColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  initiallyExpanded: false,
                  children: [
                    Divider(
                      color: MyColor.whiteGreyColor,
                      thickness: 1.0,
                    ),
                    getXcontroller.holdingsportfDetailList.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: getXcontroller.holdingsportfDetailList.length,
                            itemBuilder: (context, index) {
                              return Card(
                                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                color: Color(0xffffffff),
                                elevation: 0,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: Get.width * 0.25,
                                        child: Text(
                                          getXcontroller.holdingsportfDetailList[index].tradingsymbol!,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11,
                                            color: MyColor.primaryColor,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.blueGrey.shade50,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Avg. value : ',
                                                      style: TextStyle(
                                                        fontSize: 11,
                                                        fontWeight: FontWeight.bold,
                                                        color: MyColor.darkGreyColor,
                                                      ),
                                                    ),
                                                    Text(
                                                      getXcontroller.holdingsportfDetailList[index].averageprice!,
                                                      style: TextStyle(
                                                        fontSize: 11,
                                                        color: MyColor.textGreyColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 4),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Unrealized : ',
                                                      style: TextStyle(
                                                        fontSize: 11,
                                                        fontWeight: FontWeight.bold,
                                                        color: MyColor.darkGreyColor,
                                                      ),
                                                    ),
                                                    Text(
                                                      "${((double.tryParse(getXcontroller.holdingsportfDetailList[index].ltp!) ?? 0) < (double.tryParse(getXcontroller.holdingsportfDetailList[index].averageprice!) ?? 0)) ? "-" : "+"}${getXcontroller.holdingsportfDetailList[index].pnlpercentage!}%",
                                                      style: TextStyle(
                                                        fontSize: 11,
                                                        color: ((double.tryParse(getXcontroller.holdingsportfDetailList[index].ltp!) ?? 0) < (double.tryParse(getXcontroller.holdingsportfDetailList[index].averageprice!) ?? 0)) ? Colors.red.shade800 : MyColor.PortfolioPercentagecolor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: Get.width * 0.25,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              'Realized Going',
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 7.0),
                                              child: Text(
                                                "₹ ${((double.tryParse(getXcontroller.holdingsportfDetailList[index].realisedquantity!) ?? 0) * (double.tryParse(getXcontroller.holdingsportfDetailList[index].ltp!) ?? 0)).toString()}",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: MyColor.primaryColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        : Center(
                            child: Text(
                              'No Portfolio Found!',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: MyColor.whiteDarkGreyColor,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: MyColor.whiteGreyColor, width: 1),
                ),
                child: ExpansionTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  title: Text(
                    "Community Reviews",
                    style: TextStyle(
                      color: MyColor.primaryDarkColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  initiallyExpanded: true,
                  children: [
                    Divider(
                      color: MyColor.whiteGreyColor,
                      thickness: 1.0,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: SizedBox(
                                  // height: 35,
                                  child: TextFormField(
                                    controller: getXcontroller.listinngDetailsAddReview,
                                    style: TextStyle(
                                      color: MyColor.darkGreyColor,
                                    ),
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                                      hintText: "Write your review",
                                      hintStyle: TextStyle(color: MyColor.HintColor, fontSize: 14),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(color: MyColor.whiteGreyColor),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              MaterialButton(
                                color: MyColor.primaryDarkColor,
                                visualDensity: VisualDensity.compact,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                onPressed: () async {
                                  FocusManager.instance.primaryFocus!.unfocus();
                                  if (getXcontroller.listinngDetailsAddReview.text.isEmpty) {
                                    Fluttertoast.showToast(msg: "Please enter your review");
                                  } else {
                                    await getXcontroller.portfolioListingAddCommunityReview(false,widget.portfolio.portfolioId!,null);
                                    Future.delayed(Duration(milliseconds: 300), () {
                                      fetchData();
                                    });
                                  }
                                },
                                child: Text(
                                  'Add',
                                  style: TextStyle(color: Colors.white, fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          getXcontroller.communityReview.isNotEmpty
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: getXcontroller.communityReview.length,
                                  itemBuilder: (context, index) {
                                    final review = getXcontroller.communityReview[index];
                                    return buildCommunityReview(
                                      review,
                                    );
                                  },
                                )
                              : Center(
                                  child: Text(
                                    'No Reviews Found!',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: MyColor.matricsgreyColor,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime dateTime) {
    String datePart = DateFormat('MMMM dd, yyyy').format(dateTime);
    String timePart = DateFormat('HH:mm').format(dateTime);
    return "$datePart / $timePart IST";
  }

  Widget buildCommunityReview(CommunityReviews review) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Card(
      elevation: 0,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 5,
          vertical: screenWidth * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: MyColor.matricsgreyColor,
                  backgroundImage: review.profileImg != null && review.profileImg!.isNotEmpty ? NetworkImage(review.profileImg!) : null,
                  child: review.profileImg == null || review.profileImg!.isEmpty ? Image(image: portfolioprofileLogo) : null,
                ),
                SizedBox(width: screenWidth * 0.03),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${_formatDate(DateTime.parse(review.created_dt!).toLocal())}",
                            style: TextStyle(fontSize: screenWidth * 0.025, color: MyColor.matricsgreyColor),
                          ),
                          SizedBox(width: screenWidth * 0.03),
                          Text(
                            getTimeAgo(DateTime.parse(review.created_dt!).toLocal()),
                            style: TextStyle(fontSize: screenWidth * 0.025, color: MyColor.matricsgreyColor),
                          ),
                        ],
                      ),
                      SizedBox(height: screenWidth * 0.01),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(review.username.toString() + " : ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth * 0.04,
                                color: MyColor.primaryDarkColor,
                              )),
                          Flexible(
                            child: Text.rich(
                              _highlightAtWords(review.review!),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: screenWidth * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      Icon(
                        Icons.share_sharp,
                        color: MyColor.matricsgreyColor,
                        size: 18,
                      ),
                      // Image(image: CommunityReviewShare, width: screenWidth * 0.05, height: screenWidth * 0.04),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _showReviews(review);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.comment_sharp,
                        color: MyColor.matricsgreyColor,
                        size: 18,
                      ),
                      // Image(image: CommunityReviewComment, width: screenWidth * 0.05, height: screenWidth * 0.04),
                      SizedBox(width: screenWidth * 0.02),
                      Text(review.replies!.length.toString(), style: TextStyle(color: MyColor.matricsgreyColor, fontSize: screenWidth * 0.03)),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    review.isLikedbyme = !review.isLikedbyme!;
                    setState(() {});
                    // getXcontroller.portfolioListingLikeDislikeComment(review.reviewId!, review.isLikedbyme);
                    if (review.isLikedbyme!) {
                      review.likes = (review.likes ?? 0) + 1;
                    } else {
                      review.likes = (review.likes ?? 1) - 1;
                    }
                    setState(() {});
                    getXcontroller.portfolioListingLikeDislikeComment(review.reviewId!, review.isLikedbyme);
                  },
                  child: Row(
                    children: [
                      Icon(
                        review.isLikedbyme! ? Icons.favorite : Icons.favorite_border,
                        color: review.isLikedbyme! ? Colors.red : MyColor.matricsgreyColor,
                        size: 18,
                      ),
                      // Image(image: CommunityReviewEyes, width: screenWidth * 0.05, height: screenWidth * 0.04),
                      SizedBox(width: screenWidth * 0.02),
                      Text("${review.likes}", style: TextStyle(color: MyColor.matricsgreyColor, fontSize: screenWidth * 0.03)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildReplyReview(CommunityReviews review, StateSetter set) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
        side: BorderSide(color: MyColor.whiteGreyColor, width: 1),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: screenWidth * 0.04,),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (!review.replies!.map((e) => e.userId).toList().contains(getXcontroller.userId))
              ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: getXcontroller.repliesCommenttext,
                      style: TextStyle(
                        color: MyColor.darkGreyColor,
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                        hintText: "Add a reply...",
                        hintStyle: TextStyle(color: MyColor.HintColor, fontSize: 14),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: MyColor.whiteGreyColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  MaterialButton(
                    color: MyColor.primaryDarkColor,
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    onPressed: () async {
                      FocusManager.instance.primaryFocus!.unfocus();
                      if (getXcontroller.repliesCommenttext.text.isEmpty) {
                        Fluttertoast.showToast(msg: "Please enter your reply");
                      } else {
                        getXcontroller.portfolioListingAddCommunityReview(true,widget.portfolio.portfolioId!,review.reviewId);
                        review.replies!.add(Replies(
                            replyId: 0,
                            userId: getXcontroller.userId,
                            comment: getXcontroller.repliesCommenttext.text,
                            created_dt: DateTime.now().toString(),
                            isLikedbyme: false,
                            likes: 0,
                            profileImg: getXcontroller.profileImg,
                            username: getXcontroller.userName
                        ));
                        set(() {});
                      }
                    },
                    child: Text(
                      'Add',
                      style: TextStyle(color: MyColor.white, fontSize: 14),
                    ),
                  ),
                ],
              )
              : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("You already submitted your reply",style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          color: MyColor.matricsgreyColor,
                        )),
                ],
              ),
              Divider(height: 5,color: Colors.grey.shade300,),
              SizedBox(height: screenWidth * 0.02),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: MyColor.matricsgreyColor,
                    backgroundImage: review.profileImg != null && review.profileImg!.isNotEmpty ? NetworkImage(review.profileImg!) : null,
                    child: review.profileImg == null || review.profileImg!.isEmpty ? Image(image: portfolioprofileLogo, width: 20, color: MyColor.matricsgreyColor) : null,
                  ),
                  SizedBox(width: screenWidth * 0.04),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _formatDate(DateTime.parse(review.created_dt!).toLocal()),
                            style: TextStyle(
                              fontSize: screenWidth * 0.03,
                              color: MyColor.matricsgreyColor,
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.03),
                          Text(
                            getTimeAgo(DateTime.parse(review.created_dt!).toLocal()),
                            style: TextStyle(
                              fontSize: screenWidth * 0.03,
                              color: MyColor.matricsgreyColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenWidth * 0.01),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${review.username} : ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.04,
                              color: MyColor.primaryDarkColor,
                            ),
                          ),
                          Container(
                            width: Get.width * 0.62,
                            child: Text.rich(
                              _highlightAtWords(review.review!),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              if (review.replies != null && review.replies!.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(top: screenWidth * 0.02),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Replies :",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.030,
                          color: MyColor.primaryDarkColor,
                        ),
                      ),
                    ],
                  ),
                ),
              if (review.replies != null && review.replies!.isNotEmpty)
              Container(
                constraints: BoxConstraints(
                  maxHeight: Get.height * 0.55
                ),
                padding: const EdgeInsets.only(left: 20.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  reverse: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: review.replies!.length,
                  itemBuilder: (context, index) {
                    Replies reply = review.replies![index];
                    return Card(
                      elevation: 1,
                      margin: EdgeInsets.symmetric(vertical: 4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: MyColor.matricsgreyColor,
                              backgroundImage: reply.profileImg != null && reply.profileImg!.isNotEmpty ? NetworkImage(reply.profileImg!) : null,
                              child: reply.profileImg == null || reply.profileImg!.isEmpty ? Image(image: portfolioprofileLogo, width: 20, color: MyColor.matricsgreyColor) : null,
                            ),
                            SizedBox(width: screenWidth * 0.03),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  reply.username!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenWidth * 0.03,
                                    color: MyColor.primaryDarkColor,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Container(
                                  width: Get.width * 0.71,
                                  child: Text(
                                    reply.comment!,
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.032,
                                      color: MyColor.darkGreyColor,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  getTimeAgo(DateTime.parse(reply.created_dt!).toLocal()),
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.027,
                                    color: MyColor.matricsgreyColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: screenWidth * 0.02),
            ],
          ),
        ),
      ),
    );
  }

  String getTimeAgo(DateTime dateTime) {
    DateTime now = DateTime.now().toLocal();
    Duration diff = now.difference(dateTime.toLocal());

    if (diff.inSeconds < 60) {
      return "${diff.inSeconds} seconds ago";
    } else if (diff.inMinutes < 60) {
      return "${diff.inMinutes} minutes ago";
    } else if (diff.inHours < 24) {
      return "${diff.inHours} hours ago";
    } else if (diff.inDays < 30) {
      return "${diff.inDays} days ago";
    } else if (diff.inDays < 365) {
      int months = (diff.inDays / 30).floor();
      return "$months months ago";
    } else {
      int years = (diff.inDays / 365).floor();
      return "$years years ago";
    }
  }

  TextSpan _highlightAtWords(String text) {
    List<String> words = text.split(' ');
    List<TextSpan> spans = [];

    for (var word in words) {
      if (word.startsWith('@')) {
        spans.add(
          TextSpan(
            text: '$word ',
            style: TextStyle(
              fontSize: Get.width * 0.04,
              fontWeight: FontWeight.bold,
              color: MyColor.primaryDarkColor,
            ),
          ),
        );
      } else {
        spans.add(
          TextSpan(
            text: '$word ',
            style: TextStyle(
              fontSize: Get.width * 0.04,
              color: MyColor.matricsgreyColor,
            ),
          ),
        );
      }
    }

    return TextSpan(
      children: spans,
      style: TextStyle(fontSize: 18, color: Colors.black),
    );
  }

  _showReviews(CommunityReviews review) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        showDragHandle: false,
        elevation: 0,
        scrollControlDisabledMaxHeightRatio: 20,
        constraints: BoxConstraints(
          maxHeight: Get.height * 0.75
        ),
        backgroundColor: Colors.transparent,
        builder: (context) {
          return StatefulBuilder(builder: (context, set) {
            return Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: buildReplyReview(review,set),
            );
          });
        });
  }
}

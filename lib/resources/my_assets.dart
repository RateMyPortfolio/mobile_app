import 'package:flutter/material.dart';
import 'package:rate_my_portfolio/resources/my_colors.dart';
import 'package:shimmer/shimmer.dart';


var appLogo = const AssetImage('assets/images/play.png');
var appDLogo = const AssetImage('assets/images/d_logo.png');
var appSplashLogo = const AssetImage('assets/images/splashlogo.png');
var appEmailLogo = const AssetImage('assets/icons/emailaddressicon.png');
var appGoogleLogo = const AssetImage('assets/images/googlelogo.png');
var appFacebookLogo = const AssetImage('assets/images/facebook.png');
var appBackArrowLogo = const AssetImage('assets/images/backarrow.png');
var appRightMarkArrow = const AssetImage('assets/images/rightmarkarrow.png');
var errorIcon = const AssetImage('assets/images/error.png');
var noInternetIcon = const AssetImage('assets/images/no_internet.png');


// var appLogo = const AssetImage('assets/images/play.png');
// var appDLogo = const AssetImage('assets/images/d_logo.png');
//
// //dialog
// var dummyCast = const AssetImage('assets/images/dummy-cast.png');
//
// var errorIcon = const AssetImage('assets/images/error.png');
// var noInternetIcon = const AssetImage('assets/images/no_internet.png');
// var questionIcon = const AssetImage('assets/images/question.png');
// var permissionIcon = const AssetImage('assets/images/permission.png');
// var circularProgress = const AssetImage('assets/images/circularProgress.gif');
// var cancelIcon = const AssetImage('assets/images/rejected.png');
// var backIcon = const AssetImage('assets/images/back.png');
// var bellIcon = const AssetImage('assets/images/bell.png');
// var shoppingBagIcon = const AssetImage('assets/images/shopping-bag.png');
//
// var filmSlateIcon = const AssetImage('assets/images/film-slate.png');
//
// var successImage = const AssetImage('assets/images/success.gif');
// var congratsImage = const AssetImage('assets/images/Congrats.png');
// var userImage = const AssetImage('assets/images/user.png');
//
// var downloadsImage = const AssetImage('assets/images/download.png');
// var historyImage = const AssetImage('assets/images/history.png');
// var avatarImage = const AssetImage('assets/images/avatar.png');
// var starImage = const AssetImage('assets/images/star.png');
// var exitImage = const AssetImage('assets/images/exit.png');
//
// var insuranceImage = const AssetImage('assets/images/insurance.png');
// var notificationImage = const AssetImage('assets/images/notification.png');
// var premiumImage = const AssetImage('assets/images/premium.png');
// var subscribeImage = const AssetImage('assets/images/subscribe.png');
// var supportImage = const AssetImage('assets/images/support.png');
//
// var bigPlayImage = const AssetImage('assets/images/big-play-button.png');
// var downloadNowImage = const AssetImage('assets/images/download-now.png');
// var likeImage = const AssetImage('assets/images/like.png');
// var likeFillImage = const AssetImage('assets/images/like_fill.png');
// var dislikeFillImage = const AssetImage('assets/images/dislike_fill.png');
// var dislikeImage = const AssetImage('assets/images/dislike.png');
// var plusSignImage = const AssetImage('assets/images/plus-sign.png');
//
// var googleIcon = const AssetImage('assets/images/google.png');
// var facebookIcon = const AssetImage('assets/images/facebook.png');
// var appleIcon = const AssetImage('assets/images/apple.png');
//
// var homeIcon = const AssetImage('assets/images/home.png');
// var searchIcon = const AssetImage('assets/images/searchh.png');
// var wishlistIcon = const AssetImage('assets/images/wishlist.png');
//
// var posterOne = const AssetImage('assets/images/movieone.jpeg');
// var posterTwo = const AssetImage('assets/images/movietwo.jpeg');
// var posterThree = const AssetImage('assets/images/moviethree.jpg');
// var posterFour = const AssetImage('assets/images/moviefour.jpg');
// var posterFive = const AssetImage('assets/images/moviefive.jpg');

Widget imageLoader() {
  return Shimmer.fromColors(
    period: Duration(milliseconds: 1000),
    baseColor:MyColor.black,
    highlightColor: Colors.grey.shade700,
    child: Container(color: Colors.black),
  );
}

Widget errorWidget(BuildContext context, String url, dynamic error) {
  return Image(
    image: errorIcon,
    fit: BoxFit.cover,
  );
}

Widget errorWidget2(BuildContext context, String url, dynamic error) {
  return Shimmer.fromColors(
    period: Duration(milliseconds: 1000),
    baseColor: MyColor.black,
    highlightColor: Colors.grey.shade700,
    child: Container(color: Colors.white),
  );
}

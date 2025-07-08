import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_routes.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_language_provider.dart';
import '../providers/app_theme_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _pageController = PageController();
  int currIndex = 0;

  void goToPage(int index) {
    if (index >= 0 && index < 3) {
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        currIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<ThemeProvider>(context);
    var local = AppLocalizations.of(context)!;

    final List<Map<String, dynamic>> onboardingData = [
      {
        "title": local.title1,
        "desc": local.desc1,
        "imageLight": AppAssets.image4,
        "imageDark": AppAssets.imagee6,
      },
      {
        "title": local.title2,
        "desc": local.desc2,
        "imageLight": AppAssets.image5,
        "imageDark": AppAssets.image7,
      },
      {
        "title": local.title3,
        "desc": local.desc3,
        "imageLight": AppAssets.image6,
        "imageDark": AppAssets.image8,
      },
    ];

    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * .04, vertical: height * .063),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image(image: AssetImage(AppAssets.onbardingImage1)),
              SizedBox(width: width * .02),
              Text('Evently', style: AppStyles.reg36primary),
            ]),
            SizedBox(height: height * .02),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() {
                    currIndex = value;
                  });
                },
                itemCount: onboardingData.length,
                itemBuilder: (context, index) {
                  final item = onboardingData[index];
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image(
                          image: AssetImage(
                            themeProvider.appTheme == ThemeMode.light
                                ? item['imageLight']
                                : item['imageDark'],
                          ),
                          fit: BoxFit.fill,
                        ),
                        SizedBox(height: height * .01),
                        Text(item['title'], style: AppStyles.bold20primary),
                        SizedBox(height: height * .02),
                        Text(
                          item['desc'],
                          style: themeProvider.appTheme == ThemeMode.light
                              ? AppStyles.med16black
                              : AppStyles.med16white,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: height*.03,),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                if (currIndex > 0)
            GestureDetector(
            onTap: () => goToPage(currIndex - 1),
    child: Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
    border: Border.all(width: 3, color: AppColors.primaryColor),
      shape: BoxShape.circle,
    ),
      child: Icon(Icons.arrow_back, color: AppColors.primaryColor),
    ),
            )
                else
                  SizedBox(width: 48),

                  // Indicator
                  Row(
                    children: List.generate(3, (index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        width: currIndex == index ? 12 : 8,
                        height: currIndex == index ? 12 : 8,
                        decoration: BoxDecoration(
                          color: currIndex == index ? AppColors.primaryColor : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      );
                    }),
                  ),

                  GestureDetector(
                    onTap: () {
                      if (currIndex < 2) {
                        goToPage(currIndex + 1);
                      } else {
                        Navigator.of(context).pushReplacementNamed(AppRoutes.loginRouteName);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(width: 3, color: AppColors.primaryColor),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.arrow_forward,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
            ),
                ],
            ),
        ),
    );
  }
}













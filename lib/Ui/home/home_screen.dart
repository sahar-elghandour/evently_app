import 'package:evently_app/Ui/home/taps/favorite/favorite_tap.dart';
import 'package:evently_app/Ui/home/taps/home_tap/home_tap.dart';
import 'package:evently_app/Ui/home/taps/map/map_tap.dart';
import 'package:evently_app/Ui/home/taps/profile/profile_tap.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../providers/event_list_provider.dart';
import '../../providers/user_provider.dart';

class HomeScreen extends StatefulWidget{
  final int initialTapIndex;
  HomeScreen({this.initialTapIndex=0});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  //int selectedIndex=0;
  List<Widget> taps=[
    HomeTap(),MapTap(),FavoriteTap(),ProfileTap()
  ];
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialTapIndex;
  }

  @override
  Widget build(BuildContext context) {
    var userProvider=Provider.of<UserProvider>(context);
    var eventListProvider=Provider.of<EventListProvider>(context);
    var width =   MediaQuery.of(context).size.width;
    var height =   MediaQuery.of(context).size.height;
   return Scaffold(
    bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        shape: CircularNotchedRectangle(),
        notchMargin: 1,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
            onTap: (index){
            selectedIndex=index;
            setState(() {
            });
            },
            items:[
              buildBottomNavigationBarItem(selectedIconName: AppAssets.sHomeIcon,
                unSelectedIconName: AppAssets.unSelectedHomeIcon,
                index: 0, labelName: AppLocalizations.of(context)!.home),
              buildBottomNavigationBarItem(selectedIconName: AppAssets.sMapIcon,
                  unSelectedIconName: AppAssets.unSelectedMapIcon,
                  index: 1, labelName: AppLocalizations.of(context)!.map),
              buildBottomNavigationBarItem(selectedIconName: AppAssets.sLoveIcon,
                  unSelectedIconName: AppAssets.unSelectedLoveIcon,
                  index: 2, labelName: AppLocalizations.of(context)!.love),
              buildBottomNavigationBarItem(selectedIconName: AppAssets.sProfileIcon,
                  unSelectedIconName: AppAssets.unSelectedProfileIcon,
                  index: 3, labelName: AppLocalizations.of(context)!.profile),
            ]

           ),
      ),floatingActionButton:SizedBox(width: width*.16,height: height*.07,
        child: FloatingActionButton(onPressed: () async {
          var result = await Navigator.of(context).pushNamed(AppRoutes.addEventRouteName);
          if (result == true) {
            eventListProvider.getALLEvents(userProvider.currentUser!.id);
          }
        },
          elevation: 0,
              shape: StadiumBorder(
                    side: BorderSide(
                 color: AppColors.whiteColor,
                  width: 5
                    )
                  ),
                  child: Icon(Icons.add,color: AppColors.whiteColor,size: 35,),

                ),
      ),
         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
     body: taps[selectedIndex],
   );
  }
  BottomNavigationBarItem buildBottomNavigationBarItem({required String selectedIconName ,required String unSelectedIconName ,required int index, required String labelName}){
    return BottomNavigationBarItem(icon:ImageIcon(AssetImage(selectedIndex == index?selectedIconName:unSelectedIconName))
    ,label: labelName);
  }
}
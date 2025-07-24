import 'package:evently_app/Ui/home/taps/widgets/custom_text_form_field.dart';
import 'package:evently_app/providers/user_provider.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/event_list_provider.dart';
import '../home_tap/widget/event_item.dart';

class FavoriteTap extends StatefulWidget{
  @override
  State<FavoriteTap> createState() => _FavoriteTapState();
}

class _FavoriteTapState extends State<FavoriteTap> {


  TextEditingController searchController= TextEditingController();
  late EventListProvider eventListProvider;
  late UserProvider userProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      eventListProvider.getAllFavEventsFromFirebase(userProvider.currentUser!.id);

    });
  }

  @override
  Widget build(BuildContext context) {
    userProvider=Provider.of<UserProvider>(context);
    eventListProvider=Provider.of<EventListProvider>(context);
    var width =   MediaQuery.of(context).size.width;
    var height =   MediaQuery.of(context).size.height;
   return SafeArea(child: Column(children: [
     Padding(
       padding:  EdgeInsets.symmetric(horizontal: width*.04),
       child: CustomTextFormField(hintText: 'Search for Event',
         hintStyle: AppStyles.bold14primary,borderSideColor: AppColors.primaryColor,controller:searchController ,
       prefixIcon: Icon(Icons.search,color: AppColors.primaryColor,),),
     ),
     Expanded(
         child:eventListProvider.favEventList.isEmpty?Center(
           child: Text('No Fav Events added'),
         ): ListView.separated(
             padding: EdgeInsets.only(top: height*.02),
             itemBuilder: (context, index) {
               return EventItem(event: eventListProvider.favEventList[index]);
             }
             , separatorBuilder: (context, index) {
           return SizedBox(height: height*.001,);
           },
             itemCount: eventListProvider.favEventList.length))
    ]));
  }
}
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:islamm786/extra/audio_surah2/frontend/pages/home_page/index.dart';
import 'package:islamm786/extra/qari_screen.dart';

import 'package:islamm786/extra/surah_detail.dart';
import 'package:islamm786/extra/widgets/sajda_custom_tile.dart';
import 'package:islamm786/extra/widgets/surah_custem_tile.dart';


import '../Constants.dart';
import 'api_services.dart';
import 'constants/constants.dart';
import 'jus_screen.dart';
import 'models/sajda.dart';
import 'models/surah.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({Key? key}) : super(key: key);

  @override
  _QuranScreenState createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {

  ApiServices apiServices = ApiServices();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5, // Added
      initialIndex: 0,
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(80.0),
            child: AppBar(
              leading: InkWell(
                  onTap: (){
                    Get.back();
                  },
                  child: const Icon(Icons.arrow_back_ios,color: Colors.white,size: 17,)),
              title: Text('Quran Digital',style: TextStyle(fontFamily: "NooreHidayat",color: Colors.white,fontSize: 16,fontWeight: FontWeight.w500),),
              backgroundColor: arabicColor,
              centerTitle: true,
              
              toolbarHeight: 55,
              bottom: TabBar(
                indicatorWeight: 2,
                indicatorPadding: EdgeInsets.all(0),
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: whiteColor,
                isScrollable: true,
                physics: NeverScrollableScrollPhysics(),
                tabAlignment:TabAlignment.start,
            
                tabs: [
                  Text(
                    'VERSE BY VERSE',
                    style: TextStyle(
            
                        color: Colors.white,
                        fontFamily: "Uthmani",
                        fontSize: 16),
                  ),
                  //index - 0
                  Text(
                    'SAJDA',
                    style: TextStyle(
                        fontFamily: "Uthmani",
                        color: Colors.white,
            
                        fontSize: 16),
                  ),//index - 1
                  Text(
                    'PARA',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Uthmani",
                        fontSize: 16),
                  ),
                  //       Text(
                  //       'LISTEN QURAN',
                  //       style: TextStyle(
                  //       color: Colors.white,
                  //           fontFamily: "Uthmani",
                  //       fontSize: 16),
                  // ),
                  Text(
                    'SURAH',
                    style: TextStyle(
                        fontFamily: "Uthmani",
                        color: Colors.white,
            
                        fontSize: 16),
                  ),/// index - 2
                ],
              ),
            
            ),
          ),
          body: TabBarView(

            children:  <Widget>[
              const HomePageScreen(),
              FutureBuilder(
                future: apiServices.getSajda(),
                builder: (context,AsyncSnapshot<SajdaList> snapshot){
                  if(snapshot.hasError){
                    return const Center(child: Text('Something went wrong'),);
                  }
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const Center(child: CircularProgressIndicator(),);
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.sajdaAyahs.length,
                    itemBuilder: (context , index,) => SajdaCustomTile(snapshot.data!.sajdaAyahs[index], context,),

                  );
                },
              ),
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                    itemCount: 30,
                    itemBuilder: (context,index){
                      return GestureDetector(
                        onTap: (){
                          setState(() {
                            Constants.juzIndex = (index + 1);
                          });
                          Get.to(()=>JuzScreen());
                          //Navigator.push(context, MaterialPageRoute(builder: (context)=>JuzScreen()));
                        },
                        child: Card(

                          elevation: 4,
                          color: arabicColor,
                          child: Center(
                            child: Text('${index+1} ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20),),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              // QariListScreen(),

              FutureBuilder(
                future: apiServices.getSurah(),
                builder: (BuildContext context, AsyncSnapshot<List<Surah>> snapshot) {
                  if (snapshot.hasData) {
                    List<Surah>? surah = snapshot.data;
                    return ListView.builder(
                      itemCount: surah!.length,
                      itemBuilder: (context, index) => SurahCustomListTile(surah: surah[index],
                          context: context, ontap: (){
                            setState(() {
                              Constants.surahIndex = (index + 1);
                            });
                            Get.to(()=>Surahdetail());
                            //Navigator.push(context, MaterialPageRoute(builder: (context)=>Surahdetail()));
                          }),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

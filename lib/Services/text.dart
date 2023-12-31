
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../Constants.dart';
import '../Screens/allah_name.dart';
Widget AllahNames(){
  Widget listAllahEng(){
    final listArb=[
      'ٱلْرَّحِيْمُ', 'ٱلْرَّحْمَـانُ', 'الْمَلِكُ', 'الْقُدُّوسُ', 'السَّلاَمُ',
      'الْمُؤْمِنُ', 'الْمُهَيْمِنُ', 'الْعَزِيزُ', 'الْجَبَّارُ', 'الْمُتَكَبِّرُ',
      'الْخَالِقُ', 'الْبَارِئُ', 'الْمُصَوِّرُ', 'الْغَفَّارُ', 'الْقَهَّارُ',
      'الْبَاسِطُ', 'الْخَافِضُ', 'الرَّافِعُ', 'الْمُعِزُّ', 'المُذِلُّ',
      'السَّمِيعُ', 'الْبَصِيرُ', 'الْحَكَمُ', 'الْعَدْلُ', 'اللَّطِيفُ',
      'الْخَبِيرُ', 'الْحَلِيمُ', 'الْعَظِيمُ', 'الْغَفُورُ', 'الشَّكُورُ',
      'الْعَلِيُّ', 'الْكَبِيرُ', 'الْحَفِيظُ', 'المُقيِت', 'الْحسِيبُ',
      'الْجَلِيلُ', 'الْكَرِيمُ', 'الرَّقِيبُ', 'الْمُجِيبُ', 'الْوَاسِعُ',
      'الْحَكِيمُ', 'الْوَدُودُ', 'الْمَجِيدُ', 'الْبَاعِثُ', 'الشَّهِيدُ',
      'الْحَقُّ', 'الْوَكِيلُ', 'الْقَوِيُّ', 'الْمَتِينُ', 'الْوَلِيُّ',
      'الْحَمِيدُ', 'الْمُحْصِي', 'الْمُبْدِئُ', 'الْمُعِيدُ', 'الْمُحْيِي',
      'اَلْمُمِيتُ', 'الْحَيُّ', 'الْقَيُّومُ', 'الْوَاجِدُ', 'الْمَاجِدُ',
      'الْواحِدُ', 'اَلاَحَدُ', 'الصَّمَدُ', 'الْقَادِرُ', 'الْمُقْتَدِرُ',
      'الْمُقَدِّمُ', 'الْمُؤَخِّرُ', 'الأوَّلُ', 'الآخِرُ', 'الظَّاهِرُ',
      'الْبَاطِنُ', 'الْوَالِي', 'الْمُتَعَالِي', 'الْبَرُّ', 'التَّوَابُ',
      'الْمُنْتَقِمُ', 'العَفُوُّ', 'الرَّؤُوفُ', 'مَالِكُ الْمُلْكِ', 'ذُوالْجَلاَلِ وَالإكْرَامِ',
      'الْمُقْسِطُ', 'الْجَامِعُ', 'الْغَنِيُّ', 'الْمُغْنِي', 'اَلْمَانِعُ',
      'الضَّارَّ', 'النَّافِعُ', 'النُّورُ', 'الْهَادِي', 'الْبَدِيعُ',
      'اَلْبَاقِي', 'الْوَارِثُ', 'الرَّشِيدُ', 'الصَّبُورُ',

    ];
    final listEng=[
      'The Bestower of Mercy',
      'The Most or Entirely Merciful',

    ];
    final _random = new Random();
   // var elementEng = listEng.first;
    var elementArb = listArb[_random.nextInt(listArb.length)];
    // var elementArb = listArb.first;
    // var elementEng = listEng.first;
int index=0;

    var hour=DateTime.now().hour;

    if (hour < 24) {
      return  Column(
mainAxisAlignment: MainAxisAlignment.start,
        children: [

          SelectableText(
            elementArb,
            textAlign: TextAlign.center,
            style: const TextStyle(color: arabicColor, fontSize: 23, fontWeight: FontWeight.w500,
                fontFamily: "noorehuda", overflow: TextOverflow.ellipsis),
          ),
          // SelectableText(
          //   elementEng,
          //   textAlign: TextAlign.justify,
          //   maxLines: 3,
          //   style: const TextStyle(color: blackColor, fontSize: 18, fontWeight: FontWeight.w500,
          //       fontFamily: "AlQalamQuran", overflow: TextOverflow.ellipsis),
          // ),
           SelectableText(
            "إِنَّ لِلَّهِ تِسْعَةٌ وَتِسْعُونَ اسْمًا، مِائَةٌ إِلَّا وَاحِدًا لَا يَحْفَظُهَا أَحَدٌ إِلَّا دَخَلَ الْجَنَّةَ",
            textAlign: TextAlign.center,

            style: TextStyle(color: blackColor, fontSize: 16, fontWeight: FontWeight.w500,
                fontFamily: "noorehuda", overflow: TextOverflow.ellipsis),
          ),
           SelectableText(
            "یقیناً الله تعالیٰ کے ننانوے نام ہیں، یعنی ایک کم سو جس نے ان کوحفظ کیا وہ جنت میں داخل ہوگا",

            textAlign: TextAlign.center,
            style:  TextStyle(color: blackColor, fontSize: 20, fontWeight: FontWeight.w500,
                fontFamily: "Jameelnoori", overflow: TextOverflow.ellipsis),
          ),
           SelectableText(
            "[ Sahih Bukhari ]",
            textAlign: TextAlign.center,
            style:  TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w300,
                fontFamily: "Lato", overflow: TextOverflow.ellipsis),
          ),


        ],
      );


    }

    return Column(
      children: [
        // Text(elementEng),
         Text(elementArb),
        SelectableText(
          "إِنَّ لِلَّهِ تِسْعَةٌ وَتِسْعُونَ اسْمًا، مِائَةٌ إِلَّا وَاحِدًا لَا يَحْفَظُهَا أَحَدٌ إِلَّا دَخَلَ الْجَنَّةَ",
          textAlign: TextAlign.start,
          maxLines: 1,
          style: TextStyle(color: blackColor, fontSize: 20, fontWeight: FontWeight.w500,
              fontFamily: "Jameelnoori", overflow: TextOverflow.ellipsis),
        ),
        SelectableText(
          "یقیناً الله تعالیٰ کے ننانوے نام ہیں، یعنی ایک کم سو جس نے ان کو حفظ کیا وہ جنت میں داخل ہوگا"
              "صحيح بخاري،َ",
          maxLines: 3,
          textAlign: TextAlign.start,
          style:  TextStyle(color: blackColor, fontSize: 18, fontWeight: FontWeight.w500,
              fontFamily: "Jameelnoori", overflow: TextOverflow.ellipsis),
        ),

      ],
    );
  }
  return Container(
    width:  double.infinity,

    margin: const EdgeInsets.only(left: 17,right: 17),
    decoration: BoxDecoration(
      color: whiteColor,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      boxShadow: [
        BoxShadow(
          color: buttonColor.withOpacity(0.2),
          blurRadius: 3,
          spreadRadius: 0.5,
          // offset: Offset(0, 0),
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10,bottom: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset("assets/icons/verse.svg",height:25,),
                  const SizedBox(width: 5,),
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      const Text("Name of the Day",style: TextStyle(color: arabicTextColor, fontSize: 16, fontFamily: "Lato", fontWeight: FontWeight.w500),),
                      InkWell(
                          onTap: (){
                            Get.to(()=>AllahName());
                          },
                          child: Text("99 Names",style: TextStyle(color: black, fontSize: 12, fontFamily: "Lato", fontWeight: FontWeight.w300),)),

                    ],
                  ),
                ],
              ),

              Row(
                children: [
                  SvgPicture.asset("assets/icons/share.svg",width: 17,color: black),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text("Share",style: TextStyle(color: black, fontSize: 12, fontFamily: "Noorehira", fontWeight: FontWeight.w400),),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10,),
          listAllahEng()



        ],
      ),
    ),
  );
}
Widget Hadith(){

  Widget hadithEng() {

    var listEng = [
      'Beware of suspicion for it is the most untruthful type of speech',
      'A slave [of Allah] may utter a word without giving it much thought by which he slips into the fire a distance further than that between east and west.',
      'Allah becomes jealous [of His honor] and that is when the believer does something He has forbidden.',
      'One Umrah to the next is an expiation for whatever happened between them and the only reward for an accepted Hajj is paradise.',
      'Yawning is from the devil so whenever one of you yawns, then let him try to suppress it as much as possible.',
      'No fatigue, illness, worry, sorrow, harm, grief, or even the prick of a thorn afflicts a Muslim except that Allah expiates some of his sins by it.',
      'The Prophet (ﷺ) would never find fault with food. If he desired it, he would eat. If he disliked it, he would leave it.',
      'The fire is surrounded by [unlawful] desires and paradise by difficulties.',
      'If you said to your companion on Friday [during Jumu’ah prayer], “Listen!”, while the imaam is giving the sermon, then you’ve erred [by engaging in idle talk].',
      'If I did not fear difficulty for my nation, then I would have commanded them to use the siwaak before every prayer.',
      'The Prophet (ﷺ) saw a man who did not wash his heel [during ablution], so he (ﷺ) said, “Save the heels from the fire!”',
      'Isn’t the one who raises his head before the imaam [during prayer] afraid that Allah may change his head to that of a donkey?',
      'Whenever someone goes to the mosque in the morning or evening, Allah prepares for him a place in paradise.',

    ];
    final listarb = [
      " سیدنا ابوہریرہ رضی اللہ عنہ سے روایت ہے کہ رسول اللہ صلی اللہ علیہ وسلم نے فرمایا: “ جس نے سبحان اللہ وبحمدہ ایک دن میں سو مرتبہ پڑھا اس کے تمام گناہ مٹا دیے جائیں گے اگرچہ (اس کے گناہ) سمندر کی جھاگ کے برابر ہوں"
      ,
      "سیدنا   ابوموسیٰ اشعری رضی اللہ عنہ نے کہا کہ نبی کریم صلی اللہ علیہ وسلم نے فرمایا  جو شخص اللہ کا ذکر کرے اور جو ذکر نہ کرے ان کی مثال زندہ اور مردہ کی سی ہے ."
        ,
      " سیدنا ابن عباس رضی اللہ عنہ سے روایت ہے کہ نبی کریم صلی اللہ علیہ وسلم تکلیف کے وقت یہ دعا مانگا کرے تھے: “ اللہ کے سوا کوئی معبود نہیں ہے، وہ بڑا تحمل والا ہے، اللہ کے سوا کوئی معبود نہیں ہے، وہ عرش عظیم کا رب ہے، اللہ کے سوا کوئی معبود نہیں ہے، وہ آسمانوں کا رب ہے اور زمین کا رب ہے اور عرش کریم کا رب ہے""(صحیح بخاری)",
     "سیدنا ابوہریرہ رضی اللہ عنہ سے روایت ہے کہ نبی کریم صلی اللہ علیہ وسلم نے فرمایا: “ اللہ تعالیٰ چور پر لعنت کرے (کم بخت) انڈا چراتا ہے تو اس کا ہاتھ کاٹا جاتا ہے اور رسی چراتا ہے تو بھی اس کا ہاتھ کاٹا جاتا ہے"" صحیح بخاری",
      " ام المؤمنین عائشہ رضی اللہ عنہا سے مروی ہے کہ رسول اللہ صلی اللہ علیہ وسلم سے سوال کیا گیا کہ اللہ تعالیٰ کو کون سا عمل پسند ہے؟ فرمایا: “ ایسا عمل جو ہمیشہ کیا جائے اگرچہ تھوڑا ہو""صحیح بخاری",
     "  سیدنا عبداللہ بن عمرو رضی اللہ عنہ کہتے ہیں نبی کریم صلی اللہ علیہ وسلم نے فرمایا: “ میرا حوض (کوثر، طول و عرض میں) مہینے کی مسافت کا ہے۔ پانی اس کا دودھ سے زیادہ سفید اور مشک سے زیادہ خوشبودار ہے اور آبخورے (پینے کے برتن جیسے جام، پیالہ وغیرہ) اس کے ایسے ہیں جیسے آسمان کے ستارے، جس نے اس میں سے (ایک دفعہ) پی لیا وہ پھر کبھی پیاسا نہ ہو گا"
    ,
      " سیدنا جابر بن عبداللہ رضی اللہ عنہ سے روایت ہے کہ انھوں نے نبی کریم صلی اللہ علیہ وسلم کو یہ فرماتے ہوئے سنا: “ جب قریش نے مجھے (معراج کے بارے میں) جھٹلایا تو میں حطیم (کعبہ) میں کھڑا ہو گیا تو اللہ تعالیٰ نے بیت المقدس کو میرے سامنے کر دیا (حجاب اٹھا دیا) پس میں نے اسے دیکھ کر قریش سے اس کی علامات بیان کرنا شروع کر دیں""صحیح بخاری",
    ];
    random(min,max){
      var rn=new Random();
      return min+rn.nextInt(max-min);
    }
    final _random = new Random();
    var elementEng = listEng.first;
    var elementarb = listarb[_random.nextInt(listarb.length)];
    var hour=DateTime.now().hour;
    print(hour);
    if (hour< 24){
      return  Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          SelectableText(
    elementarb,
            textAlign: TextAlign.center,
            style:   const TextStyle(color: arabicColor, fontSize: 20, fontWeight: FontWeight.w500,
                fontFamily: "Jameelnoori", overflow: TextOverflow.ellipsis,),
          ),
          // SelectableText(
          //   elementEng,
          //   textAlign: TextAlign.justify,
          //   maxLines: 3,
          //   style: const TextStyle(color: blackColor, fontSize: 13, fontWeight: FontWeight.w500,
          //       fontFamily: "AlQalamQuran", overflow: TextOverflow.ellipsis),
          // ),

        ],
      );
    }
    return  Column(
      children: [
        // Text(elementEng),
         Text(elementarb),
      ],
    );
  }

  return Container(
    margin: const EdgeInsets.only(left: 17.0,right: 17.0),
    width: double.infinity,
    decoration: BoxDecoration(
      color: whiteColor,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      boxShadow: [
        BoxShadow(
          color: buttonColor.withOpacity(0.2),
          blurRadius: 3,
          spreadRadius: 0.5,
          // offset: Offset(0, 0),
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10,bottom: 14.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset("assets/icons/verse.svg",height:25,),
                  const SizedBox(width: 5,),
                   const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Text("Hadith of the Day",style: TextStyle(color: arabicTextColor, fontSize: 16, fontFamily: "Lato", fontWeight: FontWeight.w500),),
                      Text("Bukhari Muslim",style:
                      TextStyle(color: black, fontSize: 13,
                          fontFamily: "Lato", fontWeight: FontWeight.w300),)
                    ],
                  ),
                ],
              ),

              Row(
                children: [
                  SvgPicture.asset("assets/icons/share.svg",width: 20,color: arabicColor),
                  const SizedBox(
                    width: 5,),
                  const Text("Share",style: TextStyle(color: arabicColor, fontSize: 14, fontFamily: "Noorehira", fontWeight: FontWeight.w400),),
                ],
              ),
            ],
          ),
          const SizedBox(width: 10,),
          hadithEng(),

        ],
      ),
    ),
  );
}
Widget verse(){

  Widget verseEng() {

    var listEng = [
      'یُعۡرَفُ الۡمُجۡرِمُوۡنَ بِسِیۡمٰہُمۡ فَیُؤۡخَذُ بِالنَّوَاصِیۡ وَ الۡاَقۡدَامِ',


    ];
    final listarb = [

      " مجرِم لوگ اپنے چہروں کی سیاہی سے پہچان لئے جائیں گے پس انہیں پیشانی کے بالوں اور پاؤں سے پکڑ کر کھینچا جائے گا",

      ];
    random(min,max){
      var rn=Random();
      return min+rn.nextInt(max-min);
    }
    final _random = new Random();
    var elementEng = listEng[_random.nextInt(listEng.length)];

    var elementarb = listarb[_random.nextInt(listarb.length)];
    // elementarb=random(1, 7).toString();
    var hour=DateTime.now().hour;
    print(hour);
    if (hour< 24){

       return  Column(
         children: [
           const SizedBox(
             height: 10,
           ),

           SelectableText(
             elementEng,
             textAlign: TextAlign.center,

             style: const TextStyle(color: blackColor, fontSize: 20, fontWeight: FontWeight.w500,
                 fontFamily: "noorehuda", overflow: TextOverflow.ellipsis),
           ),
           SelectableText(
             elementarb,
             textAlign: TextAlign.center,
             style:   const TextStyle(color: arabicColor, fontSize: 20, fontWeight: FontWeight.w500,
               fontFamily: "Jameelnoori", overflow: TextOverflow.ellipsis,),
           ),

         ],
       );
     }



    return  Column(
      children: [
        // random(1, 7),
         Text(elementEng),
         Text(elementarb),
      ],
    );
  }

  return Container(
    margin: const EdgeInsets.only(left: 17.0,right: 17.0),
    width: double.infinity,
    decoration: BoxDecoration(
      color: whiteColor,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      boxShadow: [
        BoxShadow(
          color: buttonColor.withOpacity(0.2),
          blurRadius: 3,
          spreadRadius: 0.5,
          // offset: Offset(0, 0),
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10,bottom: 14.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset("assets/icons/verse.svg",height:25,),
                  const SizedBox(width: 5,),
                   const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Text("Verse of the Day",style: TextStyle(color: arabicTextColor, fontSize: 16, fontFamily: "Lato", fontWeight: FontWeight.w500),),
                      Text("Bukhari Muslim",style:
                      TextStyle(color: black, fontSize: 13,
                          fontFamily: "Lato", fontWeight: FontWeight.w300),)
                    ],
                  ),
                ],
              ),

              Row(
                children: [
                  SvgPicture.asset("assets/icons/share.svg",width: 20,color: arabicColor),
                  const SizedBox(
                    width: 5,),
                  const Text("Share",style: TextStyle(color: arabicColor, fontSize: 14, fontFamily: "Noorehira", fontWeight: FontWeight.w400),),
                ],
              ),
            ],
          ),
          const SizedBox(width: 10,),
          verseEng(),

        ],
      ),
    ),
  );
}
Widget duaOfTheDay(){

  Widget verseEng() {

    var listUrdu = [
      "ہم سے ابومعمر نے بیان کیا، کہا ہم سے عبدالوارث بن سعید نے بیان کیا، کہا ہم سے حسین بن ذکوان معلم نے بیان کیا، کہا ہم سے عبداللہ بن بریدہ نے بیان کیا ان سے بشیر بن کعب عدوی نے کہا کہ مجھ سے شداد بن اوس رضی اللہ عنہ نے بیان کیا "
          "اور ان سے رسول اللہ صلی اللہ علیہ وسلم نے کہ سیدالاستغفار (مغفرت مانگنے کے سب کلمات کا سردار) یہ ہے یوں کہے"
          "”اے اللہ! تو میرا رب ہے، تیرے سوا کوئی معبود نہیں۔ تو نے ہی مجھے پیدا کیا اور میں تیرا ہی بندہ ہوں میں اپنی طاقت کے مطابق تجھ سے کئے ہوئے عہد اور وعدہ پر قائم ہوں۔"
          "ان بری حرکتوں کے عذاب سے جو میں نے کی ہیں تیری پناہ مانگتا ہوں مجھ پر نعمتیں تیری ہیں اس کا اقرار کرتا ہوں۔"
          "میری مغفرت کر دے کہ تیرے سوا اور کوئی بھی گناہ نہیں معاف کرتا۔"
          "نبی کریم صلی اللہ علیہ وسلم نے فرمایا کہ جس نے اس دعا کے الفاظ پر یقین رکھتے ہوئے دل سے ان کو کہہ لیا اور اسی دن اس کا انتقال ہو گیا شام ہونے سے پہلے،"
          "تو وہ جنتی ہے اور جس نے اس دعا کے الفاظ پر یقین رکھتے ہوئے رات میں ان کو پڑھ لیا اور پھر اس کا صبح ہونے سے پہلے انتقال ہو گیا تو وہ جنتی ہے",
      'ہم سے اسماعیل بن ابی اویس نے بیان کیا، کہا کہ مجھ سے امام مالک نے بیان کیا، ان سے ابوالزناد نے، ان سے اعرج نے اور ان سے ابوہریرہ رضی اللہ عنہ نے کہ رسول اللہ صلی اللہ علیہ وسلم نے فرمایا ”ہر نبی کو ایک دعا حاصل ہوتی ہے (جو قبول کی جاتی ہے) اور میں چاہتا ہوں کہ میں اپنی دعا کو آخرت میں اپنی امت کی شفاعت کے لیے محفوظ رکھوں',
' معتمر نے بیان کیا، انہوں نے اپنے والد سے سنا، انہوں نے انس رضی اللہ عنہ سے کہ نبی کریم صلی اللہ علیہ وسلم نے فرمایا کہ ہر نبی نے کچھ چیزیں مانگیں یا فرمایا کہ ہر نبی کو ایک دعا دی گئی جس چیز کی اس نے دعا مانگی پھر اسے قبول کیا گیا لیکن میں نے اپنی دعا قیامت کے دن اپنی امت کی شفاعت کے لیے محفوظ رکھی ہوئی ہے۔',
'اللہ تعالیٰ نے سورۃ نوح میں فرمایا اپنے رب سے بخشش مانگو وہ بڑا بخشنے والا ہے تم ایسا کرو گے تو وہ آسمان کے دہانے کھول دے گا اور مال اور بیٹوں سے تم کو سرفراز کرے گا اور باغ عطا فرمائے گا اور نہریں عنایت کرے گا۔“ اور سورۃ آل عمران میں فرمایا بہشت ان لوگوں کے لیے تیار کی گئی ہے جن سے کوئی بےحیائی کا کام ہو جاتا ہے یا کوئی',
    'ہم  سے ابومعمر نے بیان کیا، کہا ہم سے عبدالوارث بن سعید نے بیان کیا، کہا ہم سے حسین بن ذکوان معلم نے بیان کیا، کہا ہم سے عبداللہ بن بریدہ نے بیان کیا ان سے بشیر بن کعب عدوی نے کہا کہ مجھ سے شداد بن اوس رضی اللہ عنہ نے بیان کیا اور ان سے رسول اللہ صلی اللہ علیہ وسلم نے کہ سیدالاستغفار (مغفرت مانگنے کے سب کلمات کا سردار) یہ ہے یوں کہے اے اللہ! تو میرا رب ہے، تیرے سوا کوئی معبود نہیں۔ تو نے ہی مجھے پیدا کیا اور میں تیرا ہی بندہ ہوں میں اپنی طاقت کے مطابق تجھ سے کئے ہوئے عہد اور وعدہ پر قائم ہوں۔ ان بری حرکتوں کے عذاب سے جو میں نے کی ہیں تیری پناہ مانگتا ہوں مجھ پر نعمتیں تیری ہیں اس کا اقرار کرتا ہوں۔ میری مغفرت کر دے کہ تیرے سوا اور کوئی بھی گناہ نہیں معاف کرتا۔“ نبی کریم صلی اللہ علیہ وسلم نے فرمایا کہ جس نے اس دعا کے الفاظ پر یقین رکھتے ہوئے دل سے ان کو کہہ لیا اور اسی دن اس کا انتقال ہو گیا شام ہونے سے پہلے، تو وہ جنتی ہے اور جس نے اس دعا کے الفاظ پر یقین رکھتے ہوئے رات میں ان کو پڑھ لیا اور پھر اس کا صبح ہونے سے پہلے انتقال ہو گیا تو وہ جنتی ہے۔',
'ہم سے ابوالیمان نے بیان کیا، انہوں نے کہا ہم کو شعیب نے خبر دی، انہیں زہری نے کہا کہ مجھے ابوسلمہ بن عبدالرحمٰن نے خبر دی، انہوں نے کہا کہ ابوہریرہ رضی اللہ عنہ نے بیان کیا کہ میں نے رسول اللہ صلی اللہ علیہ وسلم سے سنا، نبی کریم صلی اللہ علیہ وسلم نے فرمایا کہ اللہ کی قسم میں دن میں ستر مرتبہ سے زیادہ اللہ سے استغفار اور اس سے توبہ کرتا ہوں۔',
   'ہم سے احمد بن یونس نے بیان کیا، کہا ہم سے ابوشہاب نے، ان سے اعمش نے، ان سے عمارہ بن عمیر نے، ان سے حارث بن سوید اور ان سے عبداللہ بن مسعود رضی اللہ عنہ نے دو احادیث (بیان کیں) ایک نبی کریم صلی اللہ علیہ وسلم سے اور دوسری خود اپنی طرف سے کہا کہ مومن اپنے گناہوں کو ایسا محسوس کرتا ہے جیسے وہ کسی پہاڑ کے نیچے بیٹھا ہے اور ڈرتا ہے کہ کہیں وہ اس کے اوپر نہ گر جائے اور بدکار اپنے گناہوں کو مکھی کی طرح ہلکا سمجھتا ہے کہ وہ اس کے ناک کے پاس سے گزری اور اس نے اپنے ہاتھ سے یوں اس طرف اشارہ کیا۔ ابوشہاب نے ناک پر اپنے ہاتھ کے اشارہ سے اس کی کیفیت بتائی پھر انہوں نے رسول اللہ صلی اللہ علیہ وسلم کی یہ حدیث بیان کی۔ اللہ تعالیٰ اپنے بندہ کی توبہ سے اس شخص سے بھی زیادہ خوش ہوتا ہے جس نے کسی پرخطر جگہ پڑاؤ کیا ہو اس کے ساتھ اس کی سواری بھی ہو اور اس پر کھانے پینے کی چیزیں موجود ہوں۔ وہ سر رکھ کر سو گیا ہو اور جب بیدار ہوا ہو تو اس کی سواری غائب رہی ہو۔ آخر بھوک و پیاس یا جو کچھ اللہ نے چاہا اسے سخت لگ جائے وہ اپنے دل میں سوچے کہ مجھے اب گھر واپس چلا جانا چاہئے اور جب وہ واپس ہوا اور پھر سو گیا لیکن اس نیند سے جو سر اٹھایا تو اس کی سواری وہاں کھانا پینا لیے ہوئے سامنے کھڑی ہے تو خیال کرو اس کو کس قدر خوشی ہو گی۔ ابوشہاب کے ساتھ اس حدیث کو ابوعوانہ اور جریر نے بھی اعمش سے روایت کیا، اور شعبہ اور ابومسلم (عبیداللہ بن سعید) نے اس کو اعمش سے روایت کیا، انہوں نے ابراہیم تیمی سے، انہوں نے حارث بن سوید سے اور ابومعاویہ نے یوں کہا ہم سے اعمش نے بیان کیا، انہوں نے عمارہ سے انہوں نے اسود بن یزید سے، انہوں نے عبداللہ بن مسعود رضی اللہ عنہ سے۔ اور ہم سے اعمش نے بیان کیا انہوں نے ابراہیم تیمی سے، انہوں نے حارث بن سوید سے، انہوں نے عبداللہ بن مسعود رضی اللہ عنہ سے۔',
    'ہم سے اسحاق بن منصور نے بیان کیا، کہا ہم کو حبان بن ہلال نے خبر دی، کہا ہم سے ہمام بن یحییٰ نے بیان کیا، کہا ہم سے قتادہ نے بیان کیا اور ان سے انس بن مالک رضی اللہ عنہ نے بیان کیا اور ان سے نبی کریم صلی اللہ علیہ وسلم نے (دوسری سند) امام بخاری رحمہ اللہ نے کہا کہ ہم سے ہدبہ نے بیان کیا، کہا ہم سے ہمام نے بیان کیا، کہا ہم سے قتادہ نے بیان کیا، ان سے انس بن مالک رضی اللہ عنہ نے بیان کیا کہ رسول اللہ صلی اللہ علیہ وسلم نے فرمایا ”اللہ تعالیٰ اپنے بندے کی توبہ سے تم میں سے اس شخص سے بھی زیادہ خوش ہوتا ہے جس کا اونٹ مایوسی کے بعد اچانک اسے مل گیا ہو حالانکہ وہ ایک چٹیل میدان میں گم ہوا تھا۔',
    'ہم سے عبداللہ بن محمد مسندی نے بیان کیا، انہوں نے کہا ہم سے ہشام بن یوسف نے بیان کیا، انہوں نے کہا ہم کو معمر نے خبر دی، انہیں زہری نے، انہیں عروہ نے اور انہیں عائشہ رضی اللہ عنہا نے کہ نبی کریم صلی اللہ علیہ وسلم رات میں (تہجد کی) گیارہ رکعات پڑھتے تھے پھر جب فجر طلوع ہو جاتی تو دو ہلکی رکعات (سنت فجر) پڑھتے۔ اس کے بعد آپ دائیں پہلو لیٹ جاتے آخر مؤذن آتا اور نبی کریم صلی اللہ علیہ وسلم کو اطلاع دیتا تو آپ فجر کی نماز پڑھاتے۔',
    'ہم سے مسدد نے بیان کیا، انہوں نے کہا ہم سے معتمر بن سلیمان نے بیان کیا، کہا کہ میں نے منصور سے سنا، ان سے سعد بن عبیدہ نے بیان کیا کہ مجھ سے براء بن عازب رضی اللہ عنہ نے بیان کیا، انہوں نے بیان کیا کہ رسول اللہ صلی اللہ علیہ وسلم نے فرمایا ”جب تو سونے لگے تو نماز کے وضو کی طرح وضو کر پھر دائیں کروٹ لیٹ جا اور یہ دعا پڑھ اے اللہ! میں نے اپنے آپ کو تیری اطاعت میں دے دیا۔ اپنا سب کچھ تیرے سپرد کر دیا۔ اپنے معاملات تیرے حوالے کر دئیے۔ خوف کی وجہ سے اور تیری (رحمت و ثواب کی) امید میں کوئی پناہ گاہ کوئی مخلص تیرے سوا نہیں میں تیری کتاب پر ایمان لایا جو تو نے نازل کی ہے اور تیرے نبی پر جن کو تو نے بھیجا ہے۔“ اس کے بعد اگر تم مر گئے تو فطرت (دین اسلام) پر مرو گے پس ان کلمات کو (رات کی) سب سے آخری بات بناؤ جنہیں تم اپنی زبان سے ادا کرو (براء بن عازب رضی اللہ عنہ نے بیان کیا) میں نے عرض کی  کہنے میں کیا وجہ ہے؟ نبی کریم صلی اللہ علیہ وسلم نے فرمایا کہ نہیں کہو۔',
'ہم سے قبیصہ بن عقبہ نے بیان کیا، کہا ہم سے سفیان ثوری نے بیان کیا، ان سے عبدالملک بن عمیر نے، ان سے ربعی بن حراش نے اور ان سے حذیفہ بن یمان رضی اللہ عنہ نے بیان کیا کہ نبی کریم صلی اللہ علیہ وسلم جب اپنے بستر پر لیٹتے تو یہ کہتے  ”تیرے ہی نام کے ساتھ میں مردہ اور زندہ رہتا ہوں“ اور جب بیدار ہوتے تو کہتے  ”اسی اللہ کے لیے تمام تعریفیں ہیں جس نے ہمیں زندہ کیا۔ اس کے بعد کہ اس نے موت طاری کر دی تھی اور اسی کی طرف لوٹنا ہے۔“ قرآن شریف میں جو لفظ  ہے اس کا بھی یہی معنی ہے کہ ہم اس کو نکال کر اٹھاتے ہیں',
'ہم سے سعید بن ربیع اور محمد بن عرعرہ نے بیان کیا، ان دونوں نے کہا کہ ہم سے شعبہ نے بیان کیا، ان سے ابواسحاق نے بیان کیا، انہوں نے براء بن عازب رضی اللہ عنہما سے سنا کہ نبی کریم صلی اللہ علیہ وسلم نے ایک صحابی کو حکم دیا (دوسری سند) امام بخاری رحمہ اللہ نے کہا کہ ہم سے آدم نے بیان کیا، انہوں نے کہا ہم سے شعبہ نے بیان کیا ان سے ابواسحاق ہمدانی نے بیان کیا، اور ان سے براء بن عازب رضی اللہ عنہما نے بیان کیا کہ نبی کریم صلی اللہ علیہ وسلم نے ایک صحابی کو وصیت کی اور فرمایا کہ جب بستر پر جانے لگو تو یہ دعا پڑھا کرو ”اے اللہ! میں نے اپنی جان تیرے سپرد کی اور اپنا معاملہ تجھے سونپا اور اپنے آپ کو تیری طرف متوجہ کیا اور تجھ پر بھروسہ کیا، تیری طرف رغبت ہے تیرے خوف کی وجہ سے، تجھ سے تیرے سوا کوئی جائے پناہ نہیں، میں تیری کتاب پر ایمان لایا جو تو نے نازل کی اور تیرے نبی پر جنہیں تو نے بھیجا۔“ پھر اگر وہ مرا تو فطرت (اسلام) پر مرے گا۔',
'ہم سے موسیٰ بن اسماعیل نے بیان کیا، کہا ہم سے ابوعوانہ نے بیان کیا، ان سے عبدالملک بن عمیر نے، ان سے ربعی نے اور ان سے حذیفہ رضی اللہ عنہ نے بیان کیا کہ نبی کریم صلی اللہ علیہ وسلم جب رات میں بستر پر لیٹتے تو اپنا ہاتھ اپنے رخسار کے نیچے رکھتے اور یہ کہتے «اللهم باسمك أموت وأحيا» ”اے اللہ! تیرے نام کے ساتھ مرتا ہوں اور زندہ ہوتا ہوں۔“ اور جب آپ بیدار ہوتے تو کہتے  ”تمام تعریفیں اس اللہ کے لیے ہیں جس نے ہمیں زندہ کیا اس کے بعد کہ ہمیں موت (مراد نیند ہے) دے دی تھی اور تیری ہی طرف جانا ہے۔',
   'ہم سے مسدد نے بیان کیا، انہوں نے کہا ہم سے عبدالواحد نے بیان کیا، انہوں نے کہا ہم سے علاء بن مسیب نے بیان کیا، انہوں نے کہا کہ مجھ سے میرے باپ نے بیان کیا اور ان سے براء بن عازب رضی اللہ عنہما نے بیان کیا کہ رسول اللہ صلی اللہ علیہ وسلم جب اپنے بستر پر لیٹتے تو دائیں پہلو پر لیٹتے اور پھر کہتے  اور رسول اللہ صلی اللہ علیہ وسلم نے فرمایا کہ جس شخص نے یہ دعا پڑھی اور پھر اس رات اگر اس کی وفات ہو گئی تو اس کی وفات فطرت پر ہو گی۔ قرآن مجید میں جو کا لفظ آیا ہے یہ بھی  سے نکالا ہے  کا معنی ملک یعنی سلطنت جیسے کہتے ہیں کہ سے بہتر ہے یعنی ڈرانا رحم کرنے سے بہتر ہے۔',
    'ہم سے علی بن عبداللہ مدینی نے بیان کیا، کہا ہم سے عبدالرحمٰن ابن مہدی نے، ان سے سفیان ثوری نے، ان سے سلمہ بن کہیل نے، ان سے کریب نے اور ان سے عبداللہ بن عباس رضی اللہ عنہما نے بیان کیا کہ میں میمونہ (رضی اللہ عنہا) کے یہاں ایک رات سویا تو نبی کریم صلی اللہ علیہ وسلم اٹھے اور آپ نے اپنی حوائج ضرورت پوری کرنے کے بعد اپنا چہرہ دھویا، پھر دونوں ہاتھ دھوئے اور پھر سو گئے اس کے بعد آپ کھڑے ہو گئے اور مشکیزہ کے پاس گئے اور آپ نے اس کا منہ کھولا پھر درمیانہ وضو کیا (نہ مبالغہ کے ساتھ نہ معمولی اور ہلکے قسم کا، تین تین مرتبہ سے) کم دھویا۔ البتہ پانی ہر جگہ پہنچا دیا۔ پھر آپ نے نماز پڑھی۔ میں بھی کھڑا ہوا اور آپ کے پیچھے ہی رہا کیونکہ میں اسے پسند نہیں کرتا تھا کہ نبی کریم صلی اللہ علیہ وسلم یہ سمجھیں کہ میں آپ کا انتظار کر رہا تھا۔ میں نے بھی وضو کر لیا تھا۔ نبی کریم صلی اللہ علیہ وسلم جب کھڑے ہو کر نماز پڑھنے لگے تو میں بھی آپ کے بائیں طرف کھڑا ہو گیا۔ آپ نے میرا کان پکڑ کر دائیں طرف کر دیا، میں نے نبی کریم صلی اللہ علیہ وسلم (کی اقتداء میں) تیرہ رکعت نماز مکمل کی۔ اس کے بعد آپ سو گئے اور آپ کی سانس میں آواز پیدا ہونے لگی۔ نبی کریم صلی اللہ علیہ وسلم جب سوتے تھے تو آپ کی سانس میں آواز پیدا ہونے لگتی تھی۔ اس کے بعد بلال رضی اللہ عنہ نے آپ کو نماز کی اطلاع دی چنانچہ آپ نے (نیا وضو) کئے بغیر نماز پڑھی۔ نبی کریم صلی اللہ علیہ وسلم اپنی دعا میں یہ کہتے تھے ”اے اللہ! میرے دل میں نور پیدا کر، میری نظر میں نور پیدا کر، میرے کان میں نور پیدا کر، میرے دائیں طرف نور پیدا کر، میرے بائیں طرف نور پیدا کر، میرے اوپر نور پیدا کر، میرے نیچے نور پیدا کر میرے آگے نور پیدا کر، میرے پیچھے نور پیدا کر اور مجھے نور عطا فرما۔“ کریب (راوی حدیث) نے بیان کیا کہ میرے پاس مزید سات لفظ محفوظ ہیں۔ پھر میں نے عباس رضی اللہ عنہما کے ایک صاحب زادے سے ملاقات کی تو انہوں نے مجھ سے ان کے متعلق بیان کیا کہ ”میرے پٹھے، میرا گوشت، میرا خون، میرے بال اور میرا چمڑا ان سب میں نور بھر دے۔“ اور دو چیزوں کا اور بھی ذکر کیا۔',
'ہم سے عبداللہ بن محمد مسندی نے بیان کیا، انہوں نے کہا ہم سے سفیان بن عیینہ نے بیان کیا، انہوں نے کہا میں نے سلیمان بن ابی مسلم سے سنا، انہوں نے طاؤس سے روایت کیا اور انہوں نے ابن عباس رضی اللہ عنہما سے کہ نبی کریم صلی اللہ علیہ وسلم جب رات میں تہجد کے لیے کھڑے ہوتے تو یہ دعا کرتے ”اے اللہ! تیرے ہی لیے تمام تعریفیں ہیں تو آسمان و زمین اور ان میں موجود تمام چیزوں کا نور ہے، تیرے ہی لیے تمام تعریفیں ہیں تو آسمان اور زمین اور ان میں موجود تمام چیزوں کا قائم رکھنے والا ہے اور تیرے ہی لیے تمام تعریفیں ہیں، تو حق ہے، تیرا وعدہ حق ہے، تیرا قول حق ہے، تجھ سے ملنا حق ہے، جنت حق ہے، دوزخ حق ہے، قیامت حق ہے، انبیاء حق ہیں اور محمد رسول اللہ صلی اللہ علیہ وسلم حق ہیں۔ اے اللہ! تیرے سپرد کیا، تجھ پر بھروسہ کیا، تجھ پر ایمان لایا، تیری طرف رجوع کیا، دشمنوں کا معاملہ تیرے سپرد کیا، فیصلہ تیرے سپرد کیا، پس میری اگلی پچھلی خطائیں معاف کر۔ وہ بھی جو میں نے چھپ کر کی ہیں اور وہ بھی جو کھل کر کی ہیں تو ہی سب سے پہلے ہے اور تو ہی سب سے بعد میں ہے، صرف تو ہی معبود ہے اور تیرے سوا کوئی معبود نہیں۔',
    ];
    final listarb = ['حَدَّثَنَا أَبُو مَعْمَرٍ، حَدَّثَنَا عَبْدُ الْوَارِثِ، حَدَّثَنَا الْحُسَيْنُ، حَدَّثَنَا عَبْدُ اللَّهِ بْنُ بُرَيْدَةَ، قَالَ: حَدَّثَنِي بُشَيْرُ بْنُ كَعْبٍ الْعَدَوِيُّ، قَالَ: حَدَّثَنِي شَدَّادُ بْنُ أَوْسٍ رَضِيَ اللَّهُ عَنْهُ، عَنِ النَّبِيِّ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ:" سَيِّدُ الِاسْتِغْفَارِ أَنْ تَقُولَ: اللَّهُمَّ أَنْتَ رَبِّي، لَا إِلَهَ إِلَّا أَنْتَ، خَلَقْتَنِي وَأَنَا عَبْدُكَ، وَأَنَا عَلَى عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ، أَعُوذُ بِكَ مِنْ شَرِّ مَا صَنَعْتُ، أَبُوءُ لَكَ بِنِعْمَتِكَ عَلَيَّ، وَأَبُوءُ لَكَ بِذَنْبِي فَاغْفِرْ لِي فَإِنَّهُ لَا يَغْفِرُ الذُّنُوبَ إِلَّا أَنْتَ، قَالَ: وَمَنْ قَالَهَا مِنَ النَّهَارِ مُوقِنًا بِهَا فَمَاتَ مِنْ يَوْمِهِ قَبْلَ أَنْ يُمْسِيَ، فَهُوَ مِنْ أَهْلِ الْجَنَّةِ، وَمَنْ قَالَهَا مِنَ اللَّيْلِ وَهُوَ مُوقِنٌ بِهَا فَمَاتَ قَبْلَ أَنْ يُصْبِحَ، فَهُوَ مِنْ أَهْلِ الْجَنَّةِ',


      //   'حَدَّثَنَا إِسْمَاعِيلُ، قَالَ: حَدَّثَنِي مَالِكٌ، عَنْ أَبِي الزِّنَادِ، عَنِ الْأَعْرَجِ، عَنْ أَبِي هُرَيْرَةَ، أَنّ رَسُولَ اللَّهِ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ، قَالَ:" لِكُلِّ نَبِيٍّ دَعْوَةٌ مُسْتَجَابَةٌ يَدْعُو بِهَا، وَأُرِيدُ أَنْ أَخْتَبِئَ دَعْوَتِي شَفَاعَةً لِأُمَّتِي فِي الْآخِرَةِ".',
    //   'وَقَال لِي خَلِيفَةُ، قَالَ مُعْتَمِرٌ، سَمِعْتُ أَبِي، عَنْ أَنَسٍ، عَنِ النَّبِيِّ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ، قَالَ: كُلُّ نَبِيٍّ سَأَلَ سُؤْلًا، أَوْ قَالَ: لِكُلِّ نَبِيٍّ دَعْوَةٌ قَدْ دَعَا بِهَا، فَاسْتُجِيبَ فَجَعَلْتُ دَعْوَتِي شَفَاعَةً لِأُمَّتِي يَوْمَ الْقِيَامَةِ',
    // 'وَقَوْلِهِ تَعَالَى: اسْتَغْفِرُوا رَبَّكُمْ إِنَّهُ كَانَ غَفَّارًا {10} يُرْسِلِ السَّمَاءَ عَلَيْكُمْ مِدْرَارًا {11} وَيُمْدِدْكُمْ بِأَمْوَالٍ وَبَنِينَ وَيَجْعَلْ لَكُمْ جَنَّاتٍ وَيَجْعَلْ لَكُمْ أَنْهَارًا {12} سورة نوح آية 10-12 وَالَّذِينَ إِذَا فَعَلُوا فَاحِشَةً أَوْ ظَلَمُوا أَنْفُسَهُمْ ذَكَرُوا اللَّهَ فَاسْتَغْفَرُوا لِذُنُوبِهِمْ وَمَنْ يَغْفِرُ الذُّنُوبَ إِلا اللَّهُ وَلَمْ يُصِرُّوا عَلَى مَا فَعَلُوا وَهُمْ يَعْلَمُونَ سورة آل عمران آية 135"',
    //


    ];
    random(min,max){
      var rn=Random();
      return min+rn.nextInt(max-min);
    }
    final _random = new Random();
    var elementEng = listUrdu[_random.nextInt(listUrdu.length)];
    var elementarb = listarb[_random.nextInt(listarb.length)];
    // elementarb=random(1, 7).toString();
    var hour=DateTime.now().hour;
    print(hour);
    if (hour< 24){

       return  Column(
         children: [
           const SizedBox(
             height: 10,
           ),

           // SelectableText(
           //   elementarb,
           //   textAlign: TextAlign.center,
           //   style: const TextStyle(color: blackColor, fontSize: 19, fontWeight: FontWeight.w500,
           //       fontFamily: "Uthmani", overflow: TextOverflow.ellipsis),
           // ),
           SelectableText(
             elementEng,
             textAlign: TextAlign.center,
             style:   const TextStyle(color: arabicColor, fontSize: 20, fontWeight: FontWeight.w500,
               fontFamily: "Jameelnoori", overflow: TextOverflow.ellipsis,),
           ),

         ],
       );
     }



    return  Column(
      children: [
        // random(1, 7),
         Text(elementEng),
         Text(elementarb),
      ],
    );
  }

  return Container(
    margin: const EdgeInsets.only(left: 17.0,right: 17.0),
    width: double.infinity,
    decoration: BoxDecoration(
      color: whiteColor,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      boxShadow: [
        BoxShadow(
          color: buttonColor.withOpacity(0.2),
          blurRadius: 3,
          spreadRadius: 0.5,
          // offset: Offset(0, 0),
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10,bottom: 14.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset("assets/icons/verse.svg",height:25,),
                  const SizedBox(width: 5,),
                   const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Text("Dua of the Day",style: TextStyle(color: arabicTextColor, fontSize: 16, fontFamily: "Lato", fontWeight: FontWeight.w500),),
                      Text("Bukhari Muslim",style:
                      TextStyle(color: black, fontSize: 13,
                          fontFamily: "Lato", fontWeight: FontWeight.w300),)
                    ],
                  ),
                ],
              ),

              Row(
                children: [
                  SvgPicture.asset("assets/icons/share.svg",width: 20,color: arabicColor),
                  const SizedBox(
                    width: 5,),
                  const Text("Share",style: TextStyle(color: arabicColor, fontSize: 14, fontFamily: "Noorehira", fontWeight: FontWeight.w400),),
                ],
              ),
            ],
          ),
          const SizedBox(width: 10,),
          verseEng(),

        ],
      ),
    ),
  );
}
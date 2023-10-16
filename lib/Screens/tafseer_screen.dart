import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Constants.dart';

class Tafseer extends StatelessWidget {
  const Tafseer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0.3,
        title: const Text("Tafseer", style: TextStyle(color: blackColor, fontSize: 20, fontWeight: FontWeight.bold, fontFamily: "Lato"),),
        centerTitle: true,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios, color: blackColor,),
          onTap: (){
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              child: Icon(Icons.more_vert, color: blackColor,),
              onTap: (){
              },
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 20, top: 25),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset("assets/icons/tafseerleft.png", width: 50,),
                    Text("سورة فاتحہ کا نام اور وجہ تسمیہ",style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                    Image.asset("assets/icons/tafseers.png", width: 50,),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            child: Padding(
              padding: const EdgeInsets.only(left: 30,),
              child: Image.asset("assets/icons/tafseerbl.png", width: 50,),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 10,
            child: Padding(
              padding: const EdgeInsets.only(right: 30,),
              child: Image.asset("assets/icons/tafseerbr.png", width: 50,),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 45, right: 45),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Column(
                  children: [
                    // Row(
                    //   children: [
                    //     Flexible(
                    //         child: Text("،اس کا دوسرا نام ” الحمد “ ہے کیونکہ الحمد سے شروع کی جاتی ہے ، اس کا تیسرا نام ” ام القرآن “ یا ام الکتاب “ ام “ ہر چیز کی اصل کو کہتے ہیں کیونکہ اس سورة کے مضامین پورے قرآن کے لیے بمنزلہ اصل اور جڑ کے ہیں، اور اس سورة فاتحہ میں پورے قرآن کریم کے مضامین کا اجمالی خاکہ موجود ہے جس کی تفصیل پورا قرآن کریم ہے ۔",
                    //         textAlign: TextAlign.justify, textDirection: TextDirection.rtl,),
                    //     ),
                    //   ],
                    // ),
                    Row(
                      children: [
                        Flexible(
                          child: Text("سات آیتیں دہرائی ہوئی کیونکہ اس سورة کو نماز کی ہر رکعت میں دہرایا جاتا ہے۔ اس کا پانچواں نام : ” کافیہ “ ہے کیونکہ قرآن کریم کے سارے مضامین پر اجمالی طور پر کافی ہے ، اس کا چھٹا نام ” سورة الکنز “۔ ہے کنز کے معنی خزانہ کے ہیں آنحضرت (صلی اللہ علیہ وآلہ وسلم) نے فرمایا کہ اللہ تعالیٰ فرماتے ہیں کہ: سورة فاتحہ میرے عرش کے خزانوں میں ایک خزانہ ہے ، اس کا ساتواں نام ” سورة الشفاء “ ہے آنحضرت (صلی اللہ علیہ وآلہ وسلم) نے فرمایا فاتحہ موت کے علاوہ ہر بیماری کا علاج ہے ، اس کا آٹھواں نام : ” سورة الاساس “ ہے اساس کا معنی بنیاد ہے کیونکہ یہ سورة پورے قرآن کریم کی بنیاد ہے۔سورہ فاتحہ  كے فضائل حضرت ابو سعید بن المعلی سے منقول ہے کہ آنحضرت (صلی اللہ علیہ وآلہ وسلم) نے ارشاد فرمایا: میرے ساتھ آئیں ، تجھے قرآن کی سب سے بڑی سورة مسجد سے نکلنے سے پہلے سکھا دوں گا میں ساتھ ہوگیا ، جب مسجد کے دروازے پر پہنچے تو مجھے اچھی ",
                            textAlign: TextAlign.justify, textDirection: TextDirection.rtl,style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 16, fontFamily: "Lato"
                            ),),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      )
    );
  }
}

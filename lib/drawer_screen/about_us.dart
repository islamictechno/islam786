import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:islamm786/Constants.dart';
import 'package:islamm786/app_utils/text_utils.dart';

class AboutUsScreen extends StatefulWidget {
  // const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  var image1 = "assets/morning.jpg";
  var image2 = "assets/eve.jpg";
  var image3 = "assets/night.jpg";
  String? _currentAddress;

  // Position? _currentPosition;

  var image;
  var loader = true;

  getImage() {
    var hour = DateTime.now().hour;

    if (hour < 12) {
      image = image1;
    } else if (hour < 17) {
      image = image2;
    } else {
      image = image3;
    }
    print(image);
    return image;
  }

  TextUtils _textUtils = TextUtils();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          elevation: 0.0,
          leading: InkWell(onTap: (){
            Get.back();},
              child: Icon(Icons.arrow_back_ios,size: 15,color: Colors.white,)),
          backgroundColor: arabicColor,
          title: Text("About Us",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white)),
          centerTitle: true,
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: 0.30,
            // colorFilter:
            // ColorFilter.mode(Colors.white.withOpacity(0.2),
            //     BlendMode.dstATop),
            image: AssetImage(
              "assets/check.png",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _textUtils.normal(
                    "Welcome to Islam786,"
                    " a platform designed to enrich your "
                    "spiritual journey and connect you with the teachings of Islam. "
                    "We are dedicated to providing a comprehensive and user-friendly"
                    " resource for Muslims and anyone interested in learning more about "
                    "this beautiful faith.",
                    Colors.black,
                    14.0,
                    TextAlign.start,
                    maxLines: 5),
                const SizedBox(
                  height: 10,
                ),
                _textUtils.bold(
                    "Our Mission", arabicColor, 17.0, TextAlign.start),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: _textUtils.medium("Quranic Resources: ",
                      arabicColor, 15.0, TextAlign.start),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: _textUtils.normal(
                      "Explore the Quran in various translations, "
                      "tafseer (interpretations), and audio recitations to enhance"
                      " your understanding and connection with the Quran.",
                      Colors.black,
                      14.0,
                      TextAlign.start,
                      maxLines: 4),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: _textUtils.medium("Hadith Collections: ",
                      arabicColor, 15.0, TextAlign.start),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: _textUtils.normal(
                      "Access a vast library of"
                      " authentic hadiths and their explanations to learn"
                      "from the sayings and actions of the Prophet "
                      "Muhammad (صلى الله عليه وسلم).",
                      Colors.black,
                      14.0,
                      TextAlign.start,
                      maxLines: 4),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: _textUtils.medium("Prayer Times and Qibla Direction:",
                      arabicColor, 15.0, TextAlign.start),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: _textUtils.normal(
                      "Stay updated with accurate prayer times "
                      "and find the Qibla direction no matter "
                      "where you are in the world.",
                      Colors.black,
                      14.0,
                      TextAlign.start,
                      maxLines: 4),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: _textUtils.medium("Islamic Articles and Videos:",
                      arabicColor, 15.0, TextAlign.start),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: _textUtils.normal(
                      "Dive into a wealth of articles, videos, and sermons"
                          " on a wide range of Islamic topics, including "
                          "spirituality, ethics, and history.",
                      Colors.black,
                      14.0,
                      TextAlign.start,
                      maxLines: 4),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: _textUtils.medium("Dua and Supplication:",
                      arabicColor, 15.0, TextAlign.start),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: _textUtils.normal(
                      "Discover a collection of supplications and duas "
                          "for various occasions, as well as guidance on how to"
                          " make heartfelt prayers.",
                      Colors.black,
                      14.0,
                      TextAlign.start,
                      maxLines: 4),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: _textUtils.medium("Community and Engagement:",
                      arabicColor, 15.0, TextAlign.start),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: _textUtils.normal(
                      "Connect with a global community of like-minded individuals,"
                          " share your thoughts, and participate in discussions"
                          " to foster a sense of unity and brotherhood",
                      Colors.black,
                      14.0,
                      TextAlign.start,
                      maxLines: 4),
                ),
                const SizedBox(
                  height: 10,
                ),
                _textUtils.bold(
                    "Our Commitment",arabicColor, 17.0, TextAlign.start),
                _textUtils.normal(
                    "At Islam786, we are committed to the following principles:",
                    Colors.black,
                    14.0,
                    TextAlign.start,
                    maxLines: 4),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: _textUtils.medium("Authenticity:", arabicColor,
                      15.0, TextAlign.start),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: _textUtils.normal(
                      "We strive to provide authentic "
                      "Islamic content "
                      "that adheres to the Quran and the teachings of the"
                          " Prophet Muhammad "
                      "(صلى الله عليه وسلم).",
                      Colors.black,
                      14.0,
                      TextAlign.start,
                      maxLines: 4),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: _textUtils.medium(
                      "Inclusivity:", arabicColor, 15.0, TextAlign.start),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: _textUtils.normal(
                      "Our platform is open to Muslims and non-Muslims alike,"
                          " promoting understanding, respect, and dialogue.",
                      Colors.black,
                      14.0,
                      TextAlign.start,
                      maxLines: 4),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: _textUtils.medium("Accessibility:",arabicColor,
                      15.0, TextAlign.start),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: _textUtils.normal(
                      "We aim to make Islamic knowledge readily available"
                          " through user-friendly interfaces and multilingual "
                          "content.",
                      Colors.black,
                      14.0,
                      TextAlign.start,
                      maxLines: 4),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: _textUtils.medium("Continuous Improvement:",
                      arabicColor, 15.0, TextAlign.start),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: _textUtils.normal(
                      "We value feedback from our users and are dedicated "
                          "to continually enhancing our platform to better "
                          "serve your needs.",
                      Colors.black,
                      14.0,
                      TextAlign.start,
                      maxLines: 4),
                ),
                SizedBox(
                  height: 15,
                ),
                _textUtils.normal(
                    "Thank you for choosing Islam786 as your source for Islamic knowledge and guidance. We hope that our platform enriches your spiritual journey and helps you grow closer to Allah(عز و جل).",
                    Colors.black,
                    14.0,
                    TextAlign.start,
                    maxLines: 4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

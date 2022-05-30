import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rooya/Utils/primary_color.dart';
import 'package:rooya/Utils/text_filed/app_font.dart';

class General extends StatefulWidget {
  const General({Key? key}) : super(key: key);

  @override
  _GeneralState createState() => _GeneralState();
}

class _GeneralState extends State<General> {
  String countryCode = '+971';

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (c, size) {
      var height = size.maxHeight;
      var width = size.maxWidth;
      return SafeArea(
          child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Get.back();
            },
            color: Colors.white,
          ),
          centerTitle: false,
          title: Text(
            'GENERAL',
            style: TextStyle(
                fontFamily: AppFonts.segoeui,
                fontSize: 14,
                color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.030),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.030,
                ),
                Stack(
                  children: [
                    CircularProfileAvatar(
                      '',
                      child: SvgPicture.asset(
                        'assets/svg/sliderimg.svg',
                        fit: BoxFit.cover,
                      ),
                      elevation: 5,
                      radius: 50,
                    ),
                    
                    //SvgPicture.asset('assets/svg/edit.svg'),
                  ],
                ),
                SizedBox(
                  height: height * 0.010,
                ),
                TextFieldsProfile(
                  // controller: _provider.lNameCont,
                  hint: 'First Name'.tr,
                  uperhint: 'First Name'.tr,
                  width: width,
                ),
                SizedBox(
                  height: height * 0.015,
                ),
                TextFieldsProfile(
                  // controller: _provider.lNameCont,
                  hint: 'Last Name'.tr,
                  uperhint: 'Last Name'.tr,
                  width: width,
                ),
                SizedBox(
                  height: height * 0.015,
                ),
                TextFieldsProfile(
                  // controller: _provider.lNameCont,
                  hint: 'Email'.tr,
                  uperhint: 'Email'.tr,
                  width: width,
                ),
                SizedBox(
                  height: height * 0.015,
                ),
                TextFieldsProfile(
                  // controller: _provider.lNameCont,
                  hint: 'Country'.tr,
                  uperhint: 'Country'.tr,
                  width: width,
                ),
                SizedBox(
                  height: height * 0.015,
                ),
                TextFieldsProfile(
                  // controller: _provider.lNameCont,
                  hint: 'Gender'.tr,
                  uperhint: 'Gender'.tr,
                  width: width,
                ),
                SizedBox(
                  height: height * 0.015,
                ),
                Padding(
                  padding: EdgeInsets.only(left: width * 0.015),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Phone',
                      style: TextStyle(
                          fontSize: 11,
                          letterSpacing: 0.4,
                          fontWeight: FontWeight.bold,
                          fontFamily: AppFonts.segoeui),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.008,
                ),
                Container(
                  width: width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.green.withOpacity(0.10),
                            offset: Offset(4, 4),
                            blurRadius: 3),
                        BoxShadow(
                            color: Colors.green.withOpacity(0.1),
                            offset: Offset(-0.5, -0.5),
                            blurRadius: 1)
                      ],
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    children: [
                      CountryCodePicker(
                        padding: EdgeInsets.symmetric(horizontal: 0),
                        hideMainText: false,
                        alignLeft: false,
                        onChanged: (e) {
                          print(e.dialCode);
                          setState(() {
                            countryCode = e.dialCode!;
                          });
                        },
                        initialSelection: '+971',
                        showCountryOnly: false,
                        showOnlyCountryWhenClosed: false,
                        favorite: ['+971', 'UAE'],
                      ),
                      Expanded(
                        child: TextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(
                                countryCode == '+971' ? 9 : 10),
                          ],
                          //controller: _provider.phonecontrooler,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: width * 0.030),
                              border: InputBorder.none,
                              hintText: countryCode == '+971'
                                  ? '55 505 5505'
                                  : '555 505 5505',
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 0.5,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w300)),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.030,
                ),
                Container(
                  height: height * 0.060,
                  width: width,
                  child: Center(
                    child: Text(
                      'SAVE CHANGES',
                      style: TextStyle(
                          fontFamily: AppFonts.segoeui,
                          fontSize: 13,
                          color: Colors.white),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: greenColor,
                      borderRadius: BorderRadius.circular(5)),
                ),
                SizedBox(
                  height: height * 0.050,
                ),
              ],
            ),
          ),
          physics: BouncingScrollPhysics(),
        ),
      ));
    });
  }
}

class TextFieldsProfile extends StatefulWidget {
  TextFieldsProfile(
      {Key? key,
      this.hint,
      this.controller,
      this.icon,
      this.color,
      this.uperhint,
      this.obsucreTextUp = false,
      this.isnumber = false,
      this.enable = true,
      this.isArabic = false,
      this.width,
      this.sufixIcon,
      this.maxLines = 1})
      : super(key: key);
  final hint;
  final IconData? icon;
  final width;
  final TextEditingController? controller;
  final color;
  final String? uperhint;
  final bool obsucreTextUp;
  final bool isnumber;
  final bool enable;
  final bool isArabic;
  final Widget? sufixIcon;
  final int? maxLines;

  @override
  _TextFieldsProfileState createState() => _TextFieldsProfileState();
}

class _TextFieldsProfileState extends State<TextFieldsProfile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: widget.width * 0.015),
          child: Text(
            '${widget.uperhint}',
            style: TextStyle(
                fontSize: 11,
                letterSpacing: 0.4,
                fontWeight: FontWeight.bold,
                fontFamily: AppFonts.segoeui),
          ),
        ),
        SizedBox(
          height: Get.height / 130,
        ),
        Container(
          width: widget.width,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.green.withOpacity(0.10),
                    offset: Offset(4, 4),
                    blurRadius: 3),
                BoxShadow(
                    color: Colors.green.withOpacity(0.1),
                    offset: Offset(-0.5, -0.5),
                    blurRadius: 1)
              ],
              borderRadius: BorderRadius.circular(5)),
          child: TextFormField(
            controller: widget.controller,
            obscureText: widget.obsucreTextUp,
            enabled: widget.enable,
            keyboardType: widget.isnumber == true ? TextInputType.number : null,
            textAlign: TextAlign.start,
            maxLines: widget.maxLines,
            style: TextStyle(),
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(
                    left: widget.width * 0.030,
                    right: widget.width * 0.030,
                    bottom: widget.width * 0.010),
                border: InputBorder.none,
                suffixIcon: widget.sufixIcon,
                hintText: '${widget.hint}',
                hintStyle: TextStyle(
                    fontSize: 10,
                    fontFamily: AppFonts.segoeui,
                    letterSpacing: 0.5,
                    color: Colors.black54,
                    fontWeight: FontWeight.w300)),
          ),
        ),
      ],
    );
  }
}

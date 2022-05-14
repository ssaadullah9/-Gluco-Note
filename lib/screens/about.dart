import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_saja/translations/locale_keys.g.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black54,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            LocaleKeys.about.tr,
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 70,
            ),
            Center(
              child: Container(
                  height: 200,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
                      enabled: false,
                      readOnly: true,
                      maxLines: 12,
                      decoration: InputDecoration(
                          hintMaxLines: null,
                          hintText: LocaleKeys.about_descripption.tr,
                          hintStyle: TextStyle(
                            fontSize: 13,
                            letterSpacing: 1,
                          )),
                    ),
                  )),
            ),
            SizedBox(
              height: 40,
            ),
            Center(
                child: Text(
                  LocaleKeys.support.tr,
                  style: TextStyle(color: Colors.black, fontSize: 12),
                )),
            SizedBox(
              height: 20,
            ),
            Center(
                child: Text(
                  LocaleKeys.gluco_team.tr,
                  style: TextStyle(color: Colors.black, fontSize: 12),
                )),
          ],
        ));
  }
}
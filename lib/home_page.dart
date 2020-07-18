import 'package:flutter/material.dart';
import 'package:language_converter/translate.dart';
import 'dropdown_list.dart';
import 'package:translator/translator.dart';

String toConvert = '';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var translations;
  bool isPressed = false;
  String lang ;
  Future<String> convertedString(String text, String key) async {
    if(key==null){
      key = 'English';
    }
    final translator = GoogleTranslator();
    var translation = await translator.translate(text, to: languageKey[key]);
    return translation;
  }

  DropdownButton<String> dropdownButton() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String language in languages) {
      var item = DropdownMenuItem(
        child: Text(
          language,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        value: language,
      );
      dropdownItems.add(item);
    }

    return DropdownButton<String>(
      hint: Text('Choose a Language'),
      elevation: 100,
      icon: Icon(Icons.arrow_drop_down),
      items: dropdownItems,
      value: lang,
      onChanged: (value) {
        setState(() {
          lang = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Language Converter'),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: 200,
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'Enter the text...'),
                  onChanged: (text) {
                    toConvert = text;
                  },
                ),
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
              ),
              Container(
                child: dropdownButton(),
              ),
              Container(
                height: 200,
                padding: EdgeInsets.all(20),
                width: double.infinity,
                child: isPressed
                    ? Text(
                        translations,
                        style: TextStyle(fontSize: 25),
                      )
                    : Text('Translated text...'),
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
              ),
              FlatButton(
                color: Colors.black,
                child: Text(
                  'Convert',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () async {
                  translations = await convertedString(toConvert, lang);
                  setState(() {
                    isPressed = true;
                  });
                },
              )
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

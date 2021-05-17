import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:smartwarehouse_fr/screens/home.dart';
import 'package:smartwarehouse_fr/theme/theme.dart';

Future<void> main() async {
  await SentryFlutter.init((options) {
    options.dsn =
        'https://e8a72a4bbe4c4b2fa17c3cf1c6f0f2df@o624173.ingest.sentry.io/5753254';
  }, appRunner: () => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Warehouse FaceRecognition',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: MyHomePage(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? name;

  // @override
  // void initState() {
  //   _loadDataUser();
  //   super.initState();
  // }

  // _loadDataUser() async {
  //   SharedPreferences localData = await SharedPreferences.getInstance();
  //   var username = jsonDecode(localData.getString('username'));

  //   if (username != null) {
  //     setState(() {
  //       name = username['name'];
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          SizedBox(height: 10),
          Image.asset(
            'assets/logos/pp-construction-&-investment.png',
            height: MediaQuery.of(context).size.height / 3.3,
          ),
          Divider(
            color: kSecondaryColor,
            thickness: 0.5,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: MediaQuery.of(context).size.height / 1.7,
            width: MediaQuery.of(context).size.width,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    height: 140,
                    width: 210,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/inbound.png',
                            ),
                            Text(
                              'Login for Inbound',
                              style: textInputDecoration.labelStyle!.copyWith(
                                  fontWeight: FontWeight.w400, fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                          ]),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0)),
                        boxShadow: [
                          new BoxShadow(
                            color: Colors.black,
                            blurRadius: 1.5,
                          )
                        ]),
                  ),
                  Container(
                    height: 45,
                    width: 210,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    MyHomePage()));
                      },
                      style: ElevatedButton.styleFrom(
                          primary: kMaincolor,
                          alignment: Alignment.centerRight),
                      child: RichText(
                          textAlign: TextAlign.end,
                          text: TextSpan(
                              style: textInputDecoration.labelStyle,
                              children: <InlineSpan>[
                                TextSpan(
                                    text: 'Start',
                                    style: textInputDecoration.labelStyle!
                                        .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16)),
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: Icon(
                                    Icons.arrow_right_outlined,
                                    color: Colors.white,
                                    size: 35,
                                  ),
                                ),
                              ])),
                    ),
                    decoration: BoxDecoration(
                        color: kMaincolor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0)),
                        boxShadow: [
                          new BoxShadow(
                              color: Colors.black,
                              blurRadius: 3.0,
                              offset: Offset(0, 0.9))
                        ]),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 140,
                    width: 210,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/outbound.png',
                            ),
                            Text(
                              'Login for Request Outbound',
                              style: textInputDecoration.labelStyle!.copyWith(
                                  fontWeight: FontWeight.w400, fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                          ]),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0)),
                        boxShadow: [
                          new BoxShadow(
                            color: Colors.black,
                            blurRadius: 1.5,
                          )
                        ]),
                  ),
                  Container(
                    height: 45,
                    width: 210,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          primary: kMaincolor,
                          alignment: Alignment.centerRight),
                      child: RichText(
                          textAlign: TextAlign.end,
                          text: TextSpan(
                              style: textInputDecoration.labelStyle,
                              children: <InlineSpan>[
                                TextSpan(
                                    text: 'Open',
                                    style: textInputDecoration.labelStyle!
                                        .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16)),
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: Icon(
                                    Icons.arrow_right_outlined,
                                    color: Colors.white,
                                    size: 35,
                                  ),
                                ),
                              ])),
                    ),
                    decoration: BoxDecoration(
                        color: kMaincolor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0)),
                        boxShadow: [
                          new BoxShadow(
                              color: Colors.black,
                              blurRadius: 3.0,
                              offset: Offset(0, 0.9))
                        ]),
                  )
                ]),
          ),
          TextButton(
              onPressed: () {},
              child: Text(
                'Face Registration',
                style: textInputDecoration.labelStyle!.copyWith(
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.underline,
                    fontSize: 18),
              ))
        ]),
      ),
    );
  }

  // void logout() async {
  //   var res = await UserAuth().getData('/logout');
  //   var body = json.decode(res.body);
  //   if (body['success']) {
  //     SharedPreferences localData = await SharedPreferences.getInstance();
  //     localData.remove('username');
  //     localData.remove('token');
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => LoginScreen()));
  //   }
  // }
}

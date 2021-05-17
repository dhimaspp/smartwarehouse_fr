import 'package:smartwarehouse_fr/services/db.dart';
import 'package:smartwarehouse_fr/screens/sign_in.dart';
import 'package:smartwarehouse_fr/screens/sign_out.dart';
import 'package:smartwarehouse_fr/services/facenet.dart';
import 'package:smartwarehouse_fr/services/ml_service.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:smartwarehouse_fr/theme/theme.dart';
import 'package:smartwarehouse_fr/my_flutter_app_icons.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Services injection
  FaceNetService _faceNetService = FaceNetService();
  MLVisionService _mlVisionService = MLVisionService();
  DataBaseService _dataBaseService = DataBaseService();

  CameraDescription? cameraDescription;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _startUp();
  }

  /// 1 Obtain a list of the available cameras on the device.
  /// 2 loads the face net model
  _startUp() async {
    _setLoading(true);

    List<CameraDescription> cameras = await availableCameras();

    /// takes the front camera
    cameraDescription = cameras.firstWhere(
      (CameraDescription camera) =>
          camera.lensDirection == CameraLensDirection.front,
    );

    // start the services
    await _faceNetService.loadModel();
    await _dataBaseService.loadDB();
    _mlVisionService.initialize();
    if (_faceNetService.loadModel() != null) {
      print(_faceNetService.loadModel());
    }
    _setLoading(false);
  }

  // shows or hides the circular progress indicator
  _setLoading(bool value) {
    setState(() {
      loading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kTextLightColor,
      // appBar: AppBar(
      //   leading: Container(),
      //   elevation: 0,
      //   backgroundColor: Colors.white,
      //   actions: <Widget>[
      //     Padding(
      //       padding: EdgeInsets.only(right: 20, top: 20),
      //       child: PopupMenuButton<String>(
      //         child: Icon(
      //           Icons.more_vert,
      //           color: Colors.black,
      //         ),
      //         onSelected: (value) {
      //           switch (value) {
      //             case 'Clear DB':
      //               _dataBaseService.cleanDB();
      //               break;
      //           }
      //         },
      //         itemBuilder: (BuildContext context) {
      //           return {'Clear DB'}.map((String choice) {
      //             return PopupMenuItem<String>(
      //               value: choice,
      //               child: Text(choice),
      //             );
      //           }).toList();
      //         },
      //       ),
      //     ),
      //   ],
      // ),
      body: !loading
          ? SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Image(
                      image: AssetImage('assets/face-recognition.png'),
                      height: 220,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Column(
                        children: [
                          Text(
                            "FACE RECOGNITION AUTHENTICATION",
                            style: textInputDecoration.labelStyle!.copyWith(
                                fontSize: 25, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Inbound & Outbound App with \nFace Recognition",
                            style: textInputDecoration.labelStyle!.copyWith(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => SignIn(
                                  cameraDescription: cameraDescription,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.1),
                                  blurRadius: 1,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                vertical: 14, horizontal: 16),
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'LOGIN INBOUND',
                                  style: textInputDecoration.labelStyle!
                                      .copyWith(fontSize: 16),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(MyFlutterApp.inbound, color: kMaincolor)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => SignIn(
                                  cameraDescription: cameraDescription,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.1),
                                  blurRadius: 1,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                vertical: 14, horizontal: 16),
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'LOGIN OUTBOUND',
                                  style: textInputDecoration.labelStyle!
                                      .copyWith(fontSize: 16),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(MyFlutterApp.outbound, color: kMaincolor)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Divider(
                            thickness: 2,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => SignUp(
                                  cameraDescription: cameraDescription,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: kMaincolor,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.1),
                                  blurRadius: 1,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                vertical: 14, horizontal: 16),
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'SIGN UP',
                                  style: textInputDecoration.labelStyle!
                                      .copyWith(
                                          color: Colors.white, fontSize: 16),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(Icons.person_add, color: Colors.white)
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

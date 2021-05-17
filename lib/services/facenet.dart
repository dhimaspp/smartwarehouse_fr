import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:smartwarehouse_fr/services/db.dart';
import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:tflite_flutter/tflite_flutter.dart' as tflite;
import 'package:image/image.dart' as imglib;
import 'package:vector_math/vector_math.dart' as vect_lib;

class FaceNetService {
  // singleton boilerplate
  static final FaceNetService _faceNetService = FaceNetService._internal();

  factory FaceNetService() {
    return _faceNetService;
  }
  // singleton boilerplate
  FaceNetService._internal();

  DataBaseService _dataBaseService = DataBaseService();

  late tflite.Interpreter _interpreter;

  double threshold = 1.0;
  List? _predictedData;
  List? get predictedData => this._predictedData;

  //  saved users data
  dynamic data = {};
  String modelAsset = 'mobilenetarcface.tflite';
  int dimensiOutput = 512; // 512 untuk arcface, 192 untuk facenet
  //end sepasang------------------ note: tidak bisa langsung reload saat debug
  //kadang apk di HP harus diuninstall dulu jika ingin mengganti model dan dimensi outputnya, idk why

  Future loadModel() async {
    try {
      final gpuDelegateV2 = tflite.GpuDelegateV2(
          options: tflite.GpuDelegateOptionsV2(
              false,
              tflite.TfLiteGpuInferenceUsage.fastSingleAnswer,
              tflite.TfLiteGpuInferencePriority.minLatency,
              tflite.TfLiteGpuInferencePriority.auto,
              tflite.TfLiteGpuInferencePriority.auto));

      var interpreterOptions = tflite.InterpreterOptions()
        ..addDelegate(gpuDelegateV2);
      this._interpreter = await tflite.Interpreter.fromAsset(modelAsset,
          options: interpreterOptions);
      print('model loaded successfully');
    } catch (e) {
      print('Failed to load model.');
      print(e);
    }
  }

  setCurrentPrediction(CameraImage cameraImage, Face face) {
    /// crops the face from the image and transforms it to an array of data
    List input = _preProcess(cameraImage, face);

    /// then reshapes input and ouput to model format 🧑‍🔧
    input = input.reshape([1, 112, 112, 3]);
    // List output = List.generate(1, (index) => List.filled(192, 0));
    List output = List.filled(1 * dimensiOutput, 0).reshape([1, dimensiOutput]);

    /// runs and transforms the data 🤖
    this._interpreter.run(input, output);
    // output = output.reshape([192]); //todo: change to 512

    this._predictedData = List.from(output);
    return predict(this._predictedData).toUpperCase();
  }

  /// takes the predicted data previously saved and do inference
  String predict(List? currEmb) {
    /// search closer user prediction if exists
    if (data.length == 0) return "No Face saved";
    double minAngle = 70;
    double threshold = 50;
    double currAngle = 0.0;
    String predRes = "NOT RECOGNIZED";
    for (String label in data.keys) {
      currAngle = angle(data[label], currEmb); // angle / euclideanDistance
      print(label + ' ' + currAngle.toString());
      if (currAngle <= threshold && currAngle < minAngle) {
        minAngle = currAngle;
        predRes = label;
      }
    }
    //print(minDist.toString() + " " + predRes);
    return predRes;
    // return predict(this._predictedData);
    // return _searchResult(this._predictedData);
  }

  /// _preProess: crops the image to be more easy
  /// to detect and transforms it to model input.
  /// [cameraImage]: current image
  /// [face]: face detected
  List _preProcess(CameraImage image, Face faceDetected) {
    // crops the face 💇
    imglib.Image croppedImage = _cropFace(image, faceDetected);
    imglib.Image img = imglib.copyResizeCropSquare(croppedImage, 112);

    // transforms the cropped face to array data
    Float32List imageAsList = imageToByteListFloat32(img);
    return imageAsList;
  }

  /// crops the face from the image 💇
  /// [cameraImage]: current image
  /// [face]: face detected
  _cropFace(CameraImage image, Face faceDetected) {
    imglib.Image convertedImage = _convertCameraImage(image);
    double x = faceDetected.boundingBox.left - 10.0;
    double y = faceDetected.boundingBox.top - 10.0;
    double w = faceDetected.boundingBox.width + 10.0;
    double h = faceDetected.boundingBox.height + 10.0;
    return imglib.copyCrop(
        convertedImage, x.round(), y.round(), w.round(), h.round());
  }

  /// converts ___CameraImage___ type to ___Image___ type
  /// [image]: image to be converted
  imglib.Image _convertCameraImage(CameraImage image) {
    int width = image.width;
    int height = image.height;
    var img = imglib.Image(width, height);
    const int hexFF = 0xFF000000;
    final int uvyButtonStride = image.planes[1].bytesPerRow;
    final int? uvPixelStride = image.planes[1].bytesPerPixel;
    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        final int uvIndex =
            uvPixelStride! * (x / 2).floor() + uvyButtonStride * (y / 2).floor();
        final int index = y * width + x;
        final yp = image.planes[0].bytes[index];
        final up = image.planes[1].bytes[uvIndex];
        final vp = image.planes[2].bytes[uvIndex];
        int r = (yp + vp * 1436 / 1024 - 179).round().clamp(0, 255);
        int g = (yp - up * 46549 / 131072 + 44 - vp * 93604 / 131072 + 91)
            .round()
            .clamp(0, 255);
        int b = (yp + up * 1814 / 1024 - 227).round().clamp(0, 255);
        img.data[index] = hexFF | (b << 16) | (g << 8) | r;
      }
    }
    var img1 = imglib.copyRotate(img, -90);
    return img1;
  }

  Float32List imageToByteListFloat32(imglib.Image image) {
    /// input size = 112
    var convertedBytes = Float32List(1 * 112 * 112 * 3);
    var buffer = Float32List.view(convertedBytes.buffer);
    int pixelIndex = 0;

    for (var i = 0; i < 112; i++) {
      for (var j = 0; j < 112; j++) {
        var pixel = image.getPixel(j, i);

        /// mean: 128
        /// std: 128
        buffer[pixelIndex++] = (imglib.getRed(pixel) - 128) / 128;
        buffer[pixelIndex++] = (imglib.getGreen(pixel) - 128) / 128;
        buffer[pixelIndex++] = (imglib.getBlue(pixel) - 128) / 128;
      }
    }
    return convertedBytes.buffer.asFloat32List();
  }

  /// searchs the result in the DDBB (this function should be performed by Backend)
  /// [predictedData]: Array that represents the face by the MobileFaceNet model
  String? _searchResult(List predictedData) {
    Map<String, dynamic>? data = _dataBaseService.db;

    /// if no faces saved
    if (data?.length == 0) return null;
    double minDist = 999;
    double currDist = 0.0;
    String? predRes;

    /// search the closest result 👓
    for (String label in data!.keys) {
      currDist = _euclideanDistance(data[label], predictedData);
      if (currDist <= threshold && currDist < minDist) {
        minDist = currDist;
        predRes = label;
      }
    }
    return predRes;
  }

  /// Adds the power of the difference between each point
  /// then computes the sqrt of the result 📐
  double _euclideanDistance(List? e1, List e2) {
    if (e1 == null || e2 == null) throw Exception("Null argument");

    double sum = 0.0;
    for (int i = 0; i < e1.length; i++) {
      sum += pow((e1[i] - e2[i]), 2);
    }
    return sqrt(sum);
  }

  void setPredictedData(value) {
    this._predictedData = value;
  }

  double angle(List e1, List? e2) {
    //kalkulasi degree dari radian(theta atau angle)
    //formula: theta=arccos(dot product/(magnitide vect1 * magnitide vect1))
    //dot product
    double dotProduct = dotProductVecs(e1, e2);

    //magnitude of vectors
    double magnitudeVector1 = calculateVecMagnitude(e1);
    double magnitudeVector2 = calculateVecMagnitude(e1);

    //theta
    double theta = 0.0;

    theta = acos(dotProduct / (magnitudeVector1 * magnitudeVector2));
    double degreeTheta = vect_lib.degrees(theta);
    return degreeTheta;
  }

  double dotProductVecs(List x1, List? x2) {
    double dotProduct = 0.0;
    for (int i = 0; i < x1.length; i++) {
      dotProduct += x1[i] * x2![i];
    }
    return dotProduct;
  }

  double calculateVecMagnitude(List x) {
    double magnitude = 0.0;
    for (int i = 0; i < x.length; i++) {
      magnitude += pow((x[i]), 2);
    }
    magnitude = sqrt(magnitude);
    return magnitude;
  }
}

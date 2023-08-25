import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class ana_sayfa extends StatefulWidget {
  const ana_sayfa({Key? key}) : super(key: key);

  @override
  State<ana_sayfa> createState() => _ana_sayfaState();
}

class _ana_sayfaState extends State<ana_sayfa> {

  static Future<bool> requestCameraPermission() async {
    var status = await Permission.camera.request();
    return status.isGranted;
  }

  String barkod = "0";

  bool cameraPermissionGranted = false;

  Future<void> al () async {
    cameraPermissionGranted = await requestCameraPermission();

    if (cameraPermissionGranted) {
      String barcode = await FlutterBarcodeScanner.scanBarcode(
        '#FF0000',
        'Vazgeç',
        true,
        ScanMode.BARCODE,
      );

      if (barcode != '-1')
      {
        print(barcode);
        setState(() {
          barkod = barcode;
        });
      }
      else
      {
        print("Barkod yok");
        barkod = barcode;
      }
      }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("$barkod",style: TextStyle(fontSize: 25),),
            ElevatedButton(
              onPressed: al,
              child: Text("Okut"),
            ),
          ],
        ),
      ),
    );
  }
}

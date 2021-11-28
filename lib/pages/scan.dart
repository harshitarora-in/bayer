import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:barcode_scan2/platform_wrapper.dart';
import 'package:bayer/api/airtable_api.dart';
import 'package:bayer/contants.dart';
import 'package:bayer/pages/information_webview.dart';
import 'package:bayer/pages/report_webview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Scan extends StatefulWidget {
  const Scan({Key? key}) : super(key: key);

  @override
  State<Scan> createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  List<num> _uniqueKeyList = List<num>.empty(growable: true);
  dynamic response;
  int _itemsLength = 0;
  String? _qrScanResult;
  String? exceptionText = 'none';
  String? _uniqueKeyId;
  bool _flag = false;
  bool _boolScanned = false;
  AirtableApiServices airtableApiServices = AirtableApiServices();
  @override
  void initState() {
    updateAirtableList();
    super.initState();
  }

  void updateAirtableList() async {
    response = await airtableApiServices.fetchAirtableData();
    _itemsLength = await (response['records']).length;
    setState(() {
      _itemsLength;
    });
    for (int i = 0; i < _itemsLength; i++) {
      _uniqueKeyList.add(response['records'][i]['fields']['uniqueKey']);
    }
  }

  Future _qrScanner() async {
    try {
      _boolScanned = false;
      var scanResult = await BarcodeScanner.scan(
          options: const ScanOptions(
        android: AndroidOptions(
          aspectTolerance: 0.0,
          useAutoFocus: true,
        ),
      ));
      setState(() {
        _qrScanResult = scanResult.rawContent.toString();
        if (_qrScanResult!.isNotEmpty) {
          _boolScanned = true;
        }
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          exceptionText = "Camera Access denied";
          _boolScanned = false;
        });
      } else {
        setState(() {
          exceptionText = "Unknown Error $ex";
          _boolScanned = false;
        });
      }
    } on FormatException {
      setState(() {
        exceptionText = "Pressed back button before scanning";
        _boolScanned = false;
      });
    } catch (ex) {
      setState(() {
        exceptionText = "Unknown exception $ex";
        _boolScanned = false;
      });
    }
  }

  Future verifyQr() async {
    String? onlyNum = _qrScanResult!.replaceAll(RegExp("[^0-9]"), "");
    setState(() {
      onlyNum;
    });
    for (int i = 0; i < _itemsLength; i++) {
      if (_uniqueKeyList[i] == int.parse(onlyNum.toString())) {
        _uniqueKeyList.remove(int.parse(onlyNum.toString()));
        setState(() {
          _uniqueKeyList;
        });
        _uniqueKeyId = await response['records'][i]['id'];
        await airtableApiServices.deleteAirtableRecord(
            record: _uniqueKeyId.toString());
        setState(() {
          _uniqueKeyId;
          _itemsLength = _itemsLength - 1;
        });
        _flag = true;
        showGenuinePopup(context);
        break;
      }
    }
    if (_flag == false && _boolScanned == true) {
      showFakePopup(context);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _uniqueKeyList = List.empty();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset('assets/images/information.jpg')),
            const SizedBox(height: 10),
            SizedBox(
              height: 45,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  onPressed: () async {
                    await _qrScanner();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductInformation(
                                productLink: _qrScanResult)));
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                      backgroundColor: MaterialStateProperty.all(kDarkBlue)),
                  child: Text('Scan outter QR for info',
                      style: GoogleFonts.inter(
                          fontSize: 18,
                          color: kWhite,
                          fontWeight: FontWeight.w500))),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: const [
                  Expanded(
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                  ),
                  Text("OR"),
                  Expanded(
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                  ),
                ],
              ),
            ),
            ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset("assets/images/verifyproduct.jpeg")),
            const SizedBox(height: 10),
            SizedBox(
              height: 45,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  onPressed: () async {
                    await _qrScanner();
                    await verifyQr();
                    setState(() {
                      _flag = false;
                    });
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                      backgroundColor: MaterialStateProperty.all(kDarkBlue)),
                  child: Text('Scan inner QR for Verification',
                      style: GoogleFonts.inter(
                          fontSize: 18,
                          color: kWhite,
                          fontWeight: FontWeight.w500))),
            ),
            const SizedBox(height: 40)
          ],
        ),
      ),
    );
  }

  showFakePopup(BuildContext context) {
    Alert(
        context: context,
        title: "Counterfeit Product ",
        desc: "Oops scanned product is counterfeit ",
        image: Image.asset("assets/images/fake.jpg"),
        buttons: [
          DialogButton(
              color: kDarkBlue,
              child: Text(
                "Okay",
                style: GoogleFonts.inter(
                  color: kWhite,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          DialogButton(
              color: Colors.red,
              child: Text(
                "Report",
                style: GoogleFonts.inter(
                  color: kWhite,
                ),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Report()));
              })
        ]).show();
  }

  showGenuinePopup(BuildContext context) {
    Alert(
        context: context,
        title: "Genuine Product",
        desc: "Authentication success scanned product is Genuine!",
        image: Image.asset("assets/images/genuine.jpg"),
        buttons: [
          DialogButton(
              color: kDarkBlue,
              child: Text(
                "Okay",
                style: GoogleFonts.inter(
                  color: kWhite,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              })
        ]).show();
  }
}

import 'package:bayer/contants.dart';
import 'package:bayer/methods.dart/calculate.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late TextEditingController amountTextEditingController;
  late TextEditingController priceTextEditingController;
  late TextEditingController weightTextEditingController;
  num _amountInvested = 0;
  num _cropPrice = 0;
  num _cropWeight = 0;
  num _cropValue = 0;
  num _profitLoss = 0;
  num _pProfitLoss = 0;
  bool _isButtonEnabled = false;
  bool _isEnabled = true;

  @override
  void initState() {
    amountTextEditingController = TextEditingController();
    priceTextEditingController = TextEditingController();
    weightTextEditingController = TextEditingController();
    weightTextEditingController.addListener(() {
      _isButtonEnabled = (weightTextEditingController.text.isNotEmpty) &&
          (priceTextEditingController.text.isNotEmpty) &&
          (amountTextEditingController.text.isNotEmpty);
      setState(() {
        _isButtonEnabled;
      });
    });
    priceTextEditingController.addListener(() {
      _isButtonEnabled = (weightTextEditingController.text.isNotEmpty) &&
          (priceTextEditingController.text.isNotEmpty) &&
          (amountTextEditingController.text.isNotEmpty);
      setState(() {
        _isButtonEnabled;
      });
    });
    amountTextEditingController.addListener(() {
      _isButtonEnabled = (weightTextEditingController.text.isNotEmpty) &&
          (priceTextEditingController.text.isNotEmpty) &&
          (amountTextEditingController.text.isNotEmpty);
      setState(() {
        _isButtonEnabled;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    amountTextEditingController.dispose();
    priceTextEditingController.dispose();
    weightTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    onTap: () {
                      setState(() {
                        _isEnabled = true;
                      });
                    },
                    readOnly: !_isEnabled,
                    onChanged: (value) {
                      setState(() {
                        _amountInvested = num.parse(value);
                      });
                    },
                    cursorColor: kDarkBlue,
                    style: const TextStyle(color: Colors.black),
                    keyboardType: TextInputType.number,
                    controller: amountTextEditingController,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: _isEnabled
                                ? const BorderSide(color: kDarkBlue, width: 2.0)
                                : const BorderSide(
                                    color: Colors.grey, width: 1.0)),
                        labelStyle: const TextStyle(color: Colors.black),
                        labelText: "Amount Invested",
                        hintText: "Amount invested in ₹",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        )),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    onTap: () {
                      setState(() {
                        _isEnabled = true;
                      });
                    },
                    readOnly: !_isEnabled,
                    onChanged: (value) {
                      setState(() {
                        _cropPrice = num.parse(value);
                      });
                    },
                    cursorColor: kDarkBlue,
                    style: const TextStyle(color: Colors.black),
                    keyboardType: TextInputType.number,
                    controller: priceTextEditingController,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: _isEnabled
                                ? const BorderSide(color: kDarkBlue, width: 2.0)
                                : const BorderSide(
                                    color: kDarkBlue, width: 2.0)),
                        labelStyle: const TextStyle(color: Colors.black),
                        labelText: "Crop Price",
                        hintText: "Per Kg price in ₹",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        )),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    onTap: () {
                      setState(() {
                        _isEnabled = true;
                      });
                    },
                    readOnly: !_isEnabled,
                    onChanged: (value) {
                      setState(() {
                        _cropWeight = num.parse(value);
                      });
                    },
                    cursorColor: kDarkBlue,
                    style: const TextStyle(color: Colors.black),
                    keyboardType: TextInputType.number,
                    controller: weightTextEditingController,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: _isEnabled
                                ? const BorderSide(color: kDarkBlue, width: 2.0)
                                : const BorderSide(
                                    color: kDarkBlue, width: 2.0)),
                        labelStyle: const TextStyle(color: Colors.black),
                        labelText: "Crop Weight",
                        hintText: "Crop Weight in Kg",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        )),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(left: 4, right: 4),
                padding: const EdgeInsets.only(
                    left: 12, top: 10, bottom: 20, right: 15),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    border: Border.all(color: Colors.grey)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '*result are calculated if you sell crop today',
                        style: GoogleFonts.inter(fontSize: 10),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Current Crop Value:',
                                    style: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                                const SizedBox(height: 15),
                                Text(
                                    _profitLoss == 0
                                        ? "Profit/Loss:"
                                        : _profitLoss > 0
                                            ? "Profit:"
                                            : "Loss:",
                                    style: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                                const SizedBox(height: 15),
                                Text(
                                    _pProfitLoss == 0
                                        ? 'Profit/Loss in %'
                                        : _pProfitLoss > 0
                                            ? "Profit in %"
                                            : "Loss in %",
                                    style: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("₹ " + _cropValue.toString(),
                                    style: GoogleFonts.inter(
                                        color: _cropValue == 0
                                            ? Colors.black87
                                            : kDarkBlue)),
                                const SizedBox(height: 15),
                                Text(
                                    "₹ " +
                                        _profitLoss
                                            .toString()
                                            .replaceAll('-', ''),
                                    style: GoogleFonts.inter(
                                        color: _profitLoss == 0
                                            ? kDarkBlue
                                            : _profitLoss > 0
                                                ? Colors.green
                                                : Colors.red)),
                                const SizedBox(height: 15),
                                Text(
                                    _pProfitLoss
                                            .toStringAsFixed(2)
                                            .replaceAll('-', '') +
                                        " %",
                                    style: GoogleFonts.inter(
                                        color: _pProfitLoss == 0
                                            ? kDarkBlue
                                            : _pProfitLoss > 0
                                                ? Colors.green
                                                : Colors.red))
                              ],
                            ),
                          ]),
                    ]),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 45,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: _isButtonEnabled
                        ? () {
                            _cropValue = Calculate().calculateValue(
                                cropPrice: _cropPrice, cropWeight: _cropWeight);
                            _profitLoss = _cropValue - _amountInvested;
                            _pProfitLoss = Calculate().calulatepProfitLoss(
                                amountInvested: _amountInvested,
                                currentValue: _cropValue);
                            setState(() {
                              _cropValue;
                              _profitLoss;
                              _pProfitLoss;
                              _isButtonEnabled = false;
                              _isEnabled = false;
                            });
                          }
                        : null,
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                        backgroundColor: _isButtonEnabled
                            ? MaterialStateProperty.all(kDarkBlue)
                            : MaterialStateProperty.all(
                                const Color(0xAA10384F))),
                    child: Text('Calculate',
                        style: GoogleFonts.inter(
                            fontSize: 18,
                            color: kWhite,
                            fontWeight: FontWeight.w500))),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}

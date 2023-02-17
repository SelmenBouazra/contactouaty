import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

class QRImage extends StatelessWidget {
  const QRImage(this.data, {super.key});

  final String data;

  @override
  Widget build(BuildContext context) {
    return BarcodeWidget(
      data: data,
      barcode: Barcode.qrCode(),
      color: Colors.white,
      height: 250,
      width: 250,
    );
  }
}

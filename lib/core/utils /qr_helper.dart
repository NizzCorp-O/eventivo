import 'dart:typed_data';
import 'package:qr_flutter/qr_flutter.dart';

Future<Uint8List> generateQrCodeBytes(String data) async {
  final qrPainter = QrPainter(
    data: data,
    version: QrVersions.auto,
    gapless: true,
  );

  final picData = await qrPainter.toImageData(220); // QR size
  return picData!.buffer.asUint8List();
}
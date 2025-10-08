import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';

Future<String> generateAndUploadQR(String data, String paymentId) async {
  final qrValidationResult = QrValidator.validate(
    data: data,
    version: QrVersions.auto,
    errorCorrectionLevel: QrErrorCorrectLevel.H,
  );

  if (qrValidationResult.status == QrValidationStatus.valid) {
    final qrCode = qrValidationResult.qrCode!;
    final painter = QrPainter.withQr(
      qr: qrCode,
      color: const Color(0xFF000000),
      emptyColor: const Color(0xFFFFFFFF),
      gapless: true,
    );

    final picData = await painter.toImageData(300);
    final bytes = picData!.buffer.asUint8List();

    final storageRef = FirebaseStorage.instance
        .ref()
        .child('qr_codes')
        .child('$paymentId.png');

    await storageRef.putData(bytes, SettableMetadata(contentType: 'image/png'));
    final qrUrl = await storageRef.getDownloadURL();

    return qrUrl;
  }

  throw Exception("QR Generation Failed");
}

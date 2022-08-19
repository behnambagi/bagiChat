// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'package:get/get.dart';
// import '../utils/utils.dart';
//
// class ScanQrCodeWidget extends StatefulWidget {
//   const ScanQrCodeWidget({Key? key}) : super(key: key);
//
//   @override
//   _ScanQrCodeWidgetState createState() => _ScanQrCodeWidgetState();
// }
//
// class _ScanQrCodeWidgetState extends State<ScanQrCodeWidget> {
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   Barcode? result;
//   QRViewController? controller;
//
//   // In order to get hot reload to work we need to pause the camera if the platform
//   // is android, or resume the camera if the platform is iOS.
//   @override
//   void reassemble() {
//     super.reassemble();
//     if (Platform.isAndroid) {
//       controller?.pauseCamera();
//     } else if (Platform.isIOS) {
//       controller?.resumeCamera();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("")),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             flex: 5,
//             child: QRView(
//               key: qrKey,
//               overlay: QrScannerOverlayShape(
//                   borderWidth: 6, borderColor: Colors.white),
//               onQRViewCreated: (controller) =>
//                   _onQRViewCreated(context, controller),
//               formatsAllowed: const [BarcodeFormat.qrcode],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _onQRViewCreated(BuildContext context, QRViewController controller) {
//     this.controller = controller;
//     controller.scannedDataStream.listen((scanData) {
//       if (result != null) return;
//       result = scanData;
//       //controller.dispose();
//       Get.back(result: scanData.code);
//       //Navigator.pop(context,scanData);
//     });
//   }
//
//   @override
//   void dispose() {
//     controller?.dispose();
//     logger.d("QRCode disposed");
//     super.dispose();
//   }
// }

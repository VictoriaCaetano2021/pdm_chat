// import 'package:flutter/material.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

// class QRCodeScannerScreen extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _QRCodeScannerScreenState();
// }

// class _QRCodeScannerScreenState extends State<QRCodeScannerScreen> {
//   late final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
//   late QRViewController _controller;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Leitor QR Code'),
//       ),
//       body: Stack(
//         alignment: Alignment.center,
//         children: [
//           QRView(
//             key: _qrKey,
//             onQRViewCreated: _onQRViewCreated,
//           ),
//         ],
//       ),
//     );
//   }

//   void _onQRViewCreated(QRViewController controller) {
//     setState(() {
//       _controller = controller;
//     });

//     controller.scannedDataStream.listen((scanData) {
//       // Aqui você pode tratar os dados do QR code, por exemplo, exibindo-os em um diálogo
//       showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Text('Conteúdo do QR Code'),
//             content: Text(scanData.code),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: Text('Fechar'),
//               ),
//             ],
//           );
//         },
//       );
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_html/style.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: StreetViewPanorama(),
//     );
//   }
// }

// class StreetViewPanorama extends StatelessWidget {
//   final String streetViewIframe =
//       '<iframe src="https://www.google.com/maps/embed?pb=!4v1700087009713!6m8!1m7!1suJTF6jobnskZc6Fs1NmPxw!2m2!1d38.03477437331608!2d-78.50052392861473!3f52.91831585745551!4f-8.933266676527253!5f0.7820865974627469" width="800" height="600" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Street View Panorama'),
//       ),
//       body: SingleChildScrollView(
//         child: Html(
//           data: streetViewIframe,
//           style: {
//             'iframe': Style(
//               height: 600,
//               width: 800,
//             ),
//           },
//         ),
//       ),
//     );
//   }
// }

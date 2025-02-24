// import 'package:external_path/external_path.dart';
// import 'package:flutter/material.dart';

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {

//   @override
//   void initState() {
// getPath();

//     getPublicDirectoryPath();
//     super.initState();
//   }

//  List<String> exPath = [];
//    Future<void> getPath() async {
//     List<String> paths;
//     // getExternalStorageDirectories() will return list containing internal storage directory path
//     // And external storage (SD card) directory path (if exists)
//     paths = await ExternalPath.getExternalStorageDirectories();

//     setState(() {
//       exPath = paths; // [/storage/emulated/0, /storage/B3AE-4D28]
//     });
//   }

//    Future<void> getPublicDirectoryPath() async {
//     String path;

//     path = await ExternalPath.getExternalStoragePublicDirectory(
//         ExternalPath.DIRECTORY_DCIM);

//     setState(() {
//       print(" path: $path"); // /storage/emulated/0/Download
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title:const Text("Deven 123"),
//       ),
//       body:ListView.builder(
//           itemCount: exPath.length,
//           itemBuilder: (context, index) {
//             print("Index:$index");
//             return Center(child: Text(exPath[index]));
//           }),
//     );
//   }
// }
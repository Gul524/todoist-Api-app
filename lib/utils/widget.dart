import 'package:flutter/material.dart';
import 'package:practice/utils/configs.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  MyTextField({
    required this.hintText,
    required this.controller,

  });

  @override
  Widget build(BuildContext context) {
    return
 SizedBox(
      height: 60,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none, // Remove border
          filled: true,
          fillColor: Colors.transparent, // Make background color transparent
          contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          hintStyle: TextStyle(
            color: Mycolor.grey, // Set hint text color to gray
          ),
        ),
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black87,
        ),
      ),
    );
  }
}


void goto(BuildContext context, Widget page) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}



// class MyPopupMenuButton extends StatelessWidget {
//   const MyPopupMenuButton({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return PopupMenuButton<String>(   

//       itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
//         const PopupMenuItem<String>(   

//           value: 'Option 1',
//           child: Text('Option 1'),
//         ),
//         const PopupMenuItem<String>(
//           value: 'Option 2',
//           child: Text('Option   
//  2'),
//         ),
//       ],
//       onSelected: (String value) {
//         // Handle the selected option
//         print('Selected: $value');
//       },
//       child: const Icon(Icons.more_vert), // Customize the button icon
//     );
//   }
// }



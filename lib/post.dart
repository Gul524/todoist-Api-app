
// /*
// class MyTextField extends StatelessWidget {
//   final String name;
//   final String hintText;

//   const MyTextField({super.key, required this.name, required this.hintText});

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       decoration: InputDecoration(
//         hintText: hintText,

//         border: const OutlineInputBorder(),

//         labelText: name,
//       ),
//       onSubmitted: (value) => data[name] = value, 
//     );
//   }
// }

// */

// Future<http.Response> postMapToApi(Map<String, dynamic> data, String apiUrl) async {
//   final response = await http.post(
//     Uri.parse(apiUrl),
//     body: jsonEncode(data), 
//   );
//   return response;
// }
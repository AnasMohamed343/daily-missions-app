// import 'package:flutter/material.dart';
//
// import '../../component/cutom_text_form-field.dart';
//
// class EditTaskBottomSheet extends StatelessWidget {
//   const EditTaskBottomSheet({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Form(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Text(
//               AppLocalizations.of(context)!.editTask,
//               style: Theme.of(context).textTheme.titleMedium,
//               textAlign: TextAlign.center,
//             ),
//             CustomTextFormField(
//               controller: titleController,
//               labelText: AppLocalizations.of(context)!.taskTitle,
//               validator: (input) {
//                 if (input == null || input.trim().isEmpty) {
//                   return 'Enter Task Title';
//                 }
//                 return null;
//               },
//             ),
//             CustomTextFormField(
//               controller: detailsController,
//               labelText: AppLocalizations.of(context)!.taskDetails,
//               maxLines: 4,
//               validator: (input) {
//                 if (input == null || input.trim().isEmpty) {
//                   return 'Enter Task Details';
//                 }
//                 return null;
//               },
//             ),
//             ElevatedButton(
//               style: ButtonStyle(
//                 backgroundColor:
//                     MaterialStateProperty.all<Color>(Color(0xff5D9CEC)),
//                 foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
//               ),
//               onPressed: () {
//                 _editTask(task, titleController.text, detailsController.text);
//                 Navigator.pop(context);
//               },
//               child: Text(
//                 AppLocalizations.of(context)!.saveChanges,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

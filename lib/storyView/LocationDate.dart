import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stories/stateManagement/editorModel.dart';

// This class has access to its respective EditorModel through the
// Consumer<EditorModel> widget.
class LocationDate extends StatelessWidget {
  LocationDate({this.dateTime});

  // Returns the respective month as a String
  String _getMonth(int month) {
    switch (month) {
      case 1:
        return 'Januar';
        break;
      case 2:
        return 'Februar';
        break;
      case 3:
        return 'März';
        break;
      case 4:
        return 'April';
        break;
      case 5:
        return 'Mai';
        break;
      case 6:
        return 'Juni';
        break;
      case 7:
        return 'Juli';
        break;
      case 8:
        return 'August';
        break;
      case 9:
        return 'September';
        break;
      case 10:
        return 'Oktober';
        break;
      case 11:
        return 'November';
        break;
      default:
        return 'December';
    }
  }

  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Consumer<EditorModel>(
      builder: (context, editorModel, _) {
        return Row(
          children: [
            Container(width: 16.5),
            Text('Location, '),
            GestureDetector(
              onTap: () {
                showDatePicker(
                        context: context,
                        initialDate: dateTime,
                        firstDate: DateTime(DateTime.now().year - 70),
                        lastDate: DateTime(DateTime.now().year + 30))
                    .then((pickedDate) {
                  if (pickedDate != null) {
                    editorModel.setDateTo(pickedDate);
                  }
                });
              },
              child: Text(
                  '${dateTime.day}. ${_getMonth(dateTime.month)} ${dateTime.year}'),
            ),
          ],
        );
      },
    );
  }
}

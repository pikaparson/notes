import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:notes_list/core/data/classes/note_class.dart';
import 'package:notes_list/core/statics/style_library.dart';
import '../../../../core/data/enums/colors.dart';
import '../../../../core/statics/color_library.dart';

Widget card(NoteClass note, BuildContext context) {

  /// Получение цвета по перечислению
  Color getColorByEnum(CardColors color) {
    switch (color) {
      case CardColors.Red:
        return  ColorLibrary.redCard;
      case CardColors.Orange:
        return  ColorLibrary.orangeCard;
      case CardColors.Yellow:
        return  ColorLibrary.yellowCard;
      case CardColors.Green:
        return  ColorLibrary.greenCard;
      case CardColors.LightBlue:
        return  ColorLibrary.lightBlueCard;
      case CardColors.Blue:
        return  ColorLibrary.blueCard;
      case CardColors.Violet:
        return  ColorLibrary.violetCard;
      case CardColors.Pink:
        return  ColorLibrary.pinkCard;
      case CardColors.Brown:
        return  ColorLibrary.brownCard;
      default:
        return ColorLibrary.redCard;
    }
  }

  return Slidable(
    groupTag: 0,
    endActionPane: ActionPane(
      extentRatio: 0.14,
      motion: const ScrollMotion(),
      children: [
        SlidableAction(
          onPressed: (context) {

          },
          foregroundColor: ColorLibrary.mainGray,
          icon: Icons.delete,
        ),
      ],
    ),
    child: GestureDetector(
      onTap: () {

      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: getColorByEnum(note.color),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(note.name, style: StyleLibrary.cardTitle,),
              if (note.description != null) ...[
                SizedBox(height: 10,),
                Text('${note.description}', style: StyleLibrary.main,),
              ],
            ],
          ),
        ),
      ),
    ),
  );
}
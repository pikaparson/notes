import 'package:hive/hive.dart';
import '../../../../core/hive/hive_adapter_type_id.dart';
import '../enums/colors.dart';
import '../enums/note_types.dart';
import 'list_item_class.dart';

@HiveType(typeId: HiveAdapterTypeId.noteClass)
/// Класс заметок
class NoteClass {

  @HiveField(0)
  /// Название заметки
  String name;

  @HiveField(1)
  /// Описание заметки
  String? description;

  @HiveField(2)
  /// Дата заметки (по умолчанию - сегодня)
  DateTime date;

  @HiveField(3)
  /// Цвет карточки заметки
  CardColors color;

  @HiveField(4)
  /// Тип карточек
  NoteTypes type;

  @HiveField(5)
  /// Время
  DateTime? time;

  @HiveField(6)
  /// Элементы списка
  List<ListItemClass>? listItems;

  @HiveField(7)
  /// Дата создания заметки
  final DateTime createDate;

  /// Конструктор класса
  NoteClass({
    required this.name,
    this.description,
    required this.date,
    required this.color,
    required this.type,
    this.time,
    this.listItems,
    DateTime? createDate,
  }) : createDate = createDate ?? DateTime.now();

  /// Возвращение измененной копии
  NoteClass copyWith({
    String? name,
    String? description,
    DateTime? date,
    CardColors? color,
    NoteTypes? type,
    DateTime? time,
    List<ListItemClass>? listItems
  }){
    return NoteClass(
      name: name ?? this.name,
      description: description ?? this.description,
      date: date ?? this.date,
      color: color ?? this.color,
      type: type ?? this.type,
      time: time ?? this.time,
      listItems: listItems ?? this.listItems,
      createDate: createDate
    );
  }
}

/// Адаптер класса заметок
class NoteClassAdapter extends TypeAdapter<NoteClass> {
  @override
  final int typeId = HiveAdapterTypeId.noteClass;

  @override
  NoteClass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteClass(
        name: fields[0] as String,
        description: fields[1] as String?,
        date: fields[2] as DateTime,
        color: fields[3] as CardColors,
        type: fields[4] as NoteTypes,
        time: fields[5] as DateTime?,
        listItems: fields[6] as List<ListItemClass>?,
        createDate: fields[7] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, NoteClass obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.color)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.time)
      ..writeByte(6)
      ..write(obj.listItems)
      ..writeByte(7)
      ..write(obj.createDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
        other is NoteClassAdapter &&
          runtimeType == other.runtimeType &&
            typeId == other.typeId;
}
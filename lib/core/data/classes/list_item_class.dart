import 'package:hive/hive.dart';
import '../../hive/hive_adapter_type_id.dart';

@HiveType(typeId: HiveAdapterTypeId.listItem)
/// Класс пункта списка заметки
class ListItemClass {
  @HiveField(0)
  /// Название пункта
  String name;

  @HiveField(1)
  /// Выполнен ли пункт
  bool isCompleted;

  /// Конструктор
  ListItemClass({
    required this.name,
    this.isCompleted = false,
  });

  /// Копия с изменениями
  ListItemClass copyWith({
    String? name,
    bool? isCompleted,
  }) {
    return ListItemClass(
      name: name ?? this.name,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

/// Адаптер для Hive
class ListItemClassAdapter extends TypeAdapter<ListItemClass> {
  @override
  final int typeId = HiveAdapterTypeId.listItem;

  @override
  ListItemClass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ListItemClass(
      name: fields[0] as String,
      isCompleted: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ListItemClass obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.isCompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ListItemClassAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}
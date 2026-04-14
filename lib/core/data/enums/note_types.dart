import 'package:hive/hive.dart';
import '../../../../core/hive/hive_adapter_type_id.dart';

@HiveType(typeId: HiveAdapterTypeId.noteTypes)
/// Типы заметок
enum NoteTypes {
  @HiveField(0)
  /// Текстовый тип заметок
  Text,
  @HiveField(1)
  /// Временной тип заметок
  Time,
  @HiveField(2)
  /// Списковый тип заметок
  List
}

/// Адаптер для типов заметки
class NoteTypesAdapter extends TypeAdapter<NoteTypes> {
  @override
  final int typeId = HiveAdapterTypeId.noteTypes;

  @override
  NoteTypes read(BinaryReader reader) {
    final index = reader.readInt();
    return NoteTypes.values[index];
  }

  @override
  void write(BinaryWriter writer, NoteTypes obj) {
    writer.writeInt(obj.index);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is NoteTypesAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}
import 'package:hive/hive.dart';
import '../../../../core/hive/hive_adapter_type_id.dart';

@HiveType(typeId: HiveAdapterTypeId.colors)
/// Цвета карточек
enum CardColors {
  @HiveField(0)
  /// Красный
  Red,
  @HiveField(1)
  /// Оранжевый
  Orange,
  @HiveField(2)
  /// Желтый
  Yellow,
  @HiveField(3)
  /// Зеленый
  Green,
  @HiveField(4)
  /// Голубой
  LightBlue,
  @HiveField(5)
  /// Синий
  Blue,
  @HiveField(6)
  /// Фиолетовый
  Violet,
  @HiveField(7)
  /// Розовый
  Pink,
  @HiveField(8)
  /// Коричневый
  Brown
}

/// Адаптер для цветов карточек
class ColorsAdapter extends TypeAdapter<CardColors> {
  @override
  final int typeId = HiveAdapterTypeId.colors;

  @override
  CardColors read(BinaryReader reader) {
    final index = reader.readInt();
    return CardColors.values[index];
  }

  @override
  void write(BinaryWriter writer, CardColors obj) {
    writer.writeInt(obj.index);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ColorsAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}
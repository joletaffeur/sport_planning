// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_workout.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ModelWorkoutAdapter extends TypeAdapter<ModelWorkout> {
  @override
  final int typeId = 0;

  @override
  ModelWorkout read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ModelWorkout(
      name: fields[0] as String,
      exercises: (fields[1] as List?)?.cast<ModelExercise>(),
      days: (fields[2] as List).cast<WeekDay>(),
    );
  }

  @override
  void write(BinaryWriter writer, ModelWorkout obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.exercises)
      ..writeByte(2)
      ..write(obj.days);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModelWorkoutAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

import 'package:equatable/equatable.dart';

/// A key/value pair representing an entry in a [Map].
class Tuple<K, V> extends Equatable {
  final K key;
  final V value;

  const Tuple(this.key, this.value);

  @override
  List<Object?> get props => [key, value];

  @override
  String toString() {
    return "$key,$value";
  }
}

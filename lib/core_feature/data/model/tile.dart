import 'package:equatable/equatable.dart';

import 'position.dart';

/// Model for a puzzle tile.
class Tile extends Equatable {
  const Tile({
    required this.value,
    required this.name,
    required this.correctPosition,
    required this.currentPosition,
    this.isWhitespace = false,
  });

  /// Value representing the correct position of [Tile] in a list. Begins from 1.
  final int value;

  /// String representing a name visible to a player.
  final String name;

  /// The correct 2D [Position] of the [Tile]. All tiles must be in their
  /// correct position to complete the puzzle.
  final Position correctPosition;

  /// The current 2D [Position] of the [Tile].
  final Position currentPosition;

  /// Denotes if the [Tile] is the whitespace tile or not.
  final bool isWhitespace;

  bool isCorrect() => correctPosition == currentPosition;

  /// Create a copy of this [Tile] with updated current position.
  Tile copyWith({required Position currentPosition}) {
    return Tile(
      value: value,
      name: name,
      correctPosition: correctPosition,
      currentPosition: currentPosition,
      isWhitespace: isWhitespace,
    );
  }

  @override
  List<Object> get props => [
        value,
        name,
        correctPosition,
        currentPosition,
        isWhitespace,
      ];
}

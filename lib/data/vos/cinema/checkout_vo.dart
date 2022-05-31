import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data/vos/cinema/snacks_vo.dart';

part 'checkout_vo.g.dart';

@JsonSerializable()
class CheckOutVO {

  @JsonKey(name: "cinema_day_timeslot_id")
  int? timeSlotsId;

  @JsonKey(name: "row")
  String? row;

  @JsonKey(name: "seat_number")
  String? seatName;

  @JsonKey(name: "booking_date")
  String? bookingDate;

  @JsonKey(name: "total_price")
  double? totalPrice;

  @JsonKey(name: "movie_id")
  int? movieId;

  @JsonKey(name: "card_id")
  int? cardId;

  @JsonKey(name: "cinema_id")
  int? cinemaId;

  @JsonKey(name: "snacks")
  List<SnacksVO>? snacks;

  CheckOutVO(this.timeSlotsId, this.row, this.seatName, this.bookingDate,
      this.totalPrice, this.movieId, this.cardId, this.cinemaId, this.snacks);

  factory CheckOutVO.fromJson(Map<String, dynamic> json) => _$CheckOutVOFromJson(json);

  Map<String, dynamic> toJson() => _$CheckOutVOToJson(this);

  @override
  String toString() {
    return 'CheckOutVO{timeSlotsId: $timeSlotsId, row: $row, seatName: $seatName, bookingDate: $bookingDate, totalPrice: $totalPrice, movieId: $movieId, cardId: $cardId, cinemaId: $cinemaId, snacks: $snacks}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CheckOutVO &&
          runtimeType == other.runtimeType &&
          timeSlotsId == other.timeSlotsId &&
          row == other.row &&
          seatName == other.seatName &&
          bookingDate == other.bookingDate &&
          totalPrice == other.totalPrice &&
          movieId == other.movieId &&
          cardId == other.cardId &&
          cinemaId == other.cinemaId &&
          listEquals(other.snacks, snacks);

  @override
  int get hashCode =>
      timeSlotsId.hashCode ^
      row.hashCode ^
      seatName.hashCode ^
      bookingDate.hashCode ^
      totalPrice.hashCode ^
      movieId.hashCode ^
      cardId.hashCode ^
      cinemaId.hashCode ^
      snacks.hashCode;
}
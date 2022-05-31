import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data/vos/cinema/snacks_vo.dart';
import 'package:movie_booking_app/data/vos/cinema/time_slots_vo.dart';

part 'user_booking_vo.g.dart';

@JsonSerializable()
class UserBookingVO {

  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "booking_no")
  String? bookingNo;

  @JsonKey(name: "booking_date")
  String? bookingDate;

  @JsonKey(name: "row")
  String? row;

  @JsonKey(name: "seat")
  String? seat;

  @JsonKey(name: "total_seat")
  int? totalSeat;

  @JsonKey(name: "total")
  String? total;

  @JsonKey(name: "movie_id")
  int? movieId;

  @JsonKey(name: "cinema_id")
  int? cinemaId;

  @JsonKey(name: "username")
  String? userName;

  @JsonKey(name: "timeslot")
  TimeSlotsVO? timeSlotsVO;

  @JsonKey(name: "snacks")
  List<SnacksVO>? snacks;

  @JsonKey(name: "qr_code")
  String? qrCode;

  UserBookingVO(
      this.id,
      this.bookingNo,
      this.bookingDate,
      this.row,
      this.seat,
      this.totalSeat,
      this.total,
      this.movieId,
      this.cinemaId,
      this.userName,
      this.timeSlotsVO,
      this.snacks,
      this.qrCode);

  factory UserBookingVO.fromJson(Map<String, dynamic> json) => _$UserBookingVOFromJson(json);

  Map<String, dynamic> toJson() => _$UserBookingVOToJson(this);

  @override
  String toString() {
    return 'UserBookingVO{id: $id, bookingNo: $bookingNo, bookingDate: $bookingDate, row: $row, seat: $seat, totalSeat: $totalSeat, total: $total, movieId: $movieId, cinemaId: $cinemaId, userName: $userName, timeSlotsVO: $timeSlotsVO, snacks: $snacks, qrCode: $qrCode}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserBookingVO &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          bookingNo == other.bookingNo &&
          bookingDate == other.bookingDate &&
          row == other.row &&
          seat == other.seat &&
          totalSeat == other.totalSeat &&
          total == other.total &&
          movieId == other.movieId &&
          cinemaId == other.cinemaId &&
          userName == other.userName &&
          timeSlotsVO == other.timeSlotsVO &&
          listEquals(other.snacks, snacks) &&
          qrCode == other.qrCode;

  @override
  int get hashCode =>
      id.hashCode ^
      bookingNo.hashCode ^
      bookingDate.hashCode ^
      row.hashCode ^
      seat.hashCode ^
      totalSeat.hashCode ^
      total.hashCode ^
      movieId.hashCode ^
      cinemaId.hashCode ^
      userName.hashCode ^
      timeSlotsVO.hashCode ^
      snacks.hashCode ^
      qrCode.hashCode;
}
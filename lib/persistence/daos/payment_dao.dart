import 'package:hive/hive.dart';
import 'package:movie_booking_app/data/vos/cinema/payment_vo.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

abstract class PaymentDao {

  Stream<void> getAllPaymentEventStream();

  Stream<List<PaymentVO>> getPaymentStream() ;

  void saveAllPayments(List<PaymentVO>? paymentList);

  List<PaymentVO> getAllPayments();

}
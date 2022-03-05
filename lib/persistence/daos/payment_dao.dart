import 'package:hive/hive.dart';
import 'package:movie_booking_app/data/vos/cinema/payment_vo.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

class PaymentDao {

  static final PaymentDao _singleton = PaymentDao._internal();

  factory PaymentDao() {
    return _singleton;
  }

  PaymentDao._internal();

  Stream<void> getAllPaymentEventStream() {
    return getPaymentBox().watch();
  }

  Stream<List<PaymentVO>> getPaymentStream() {
    return Stream.value(getAllPayments().toList());
  }

  void saveAllPayments(List<PaymentVO>? paymentList) async {
    Map<int, PaymentVO> paymentMap = Map.fromIterable(paymentList ?? [], key: (payment) => payment.id, value: (payment) => payment);
    await getPaymentBox().putAll(paymentMap);
  }

  List<PaymentVO> getAllPayments() {
    return getPaymentBox().values.toList();
  }

  Box<PaymentVO> getPaymentBox() {
    return Hive.box<PaymentVO>(BOX_NAME_PAYMENT_VO);
  }

}
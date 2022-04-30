import 'package:hive/hive.dart';
import 'package:movie_booking_app/data/vos/cinema/payment_vo.dart';
import 'package:movie_booking_app/persistence/daos/payment_dao.dart';

import '../../hive_constants.dart';

class PaymentDaoImpl extends PaymentDao {

  static final PaymentDaoImpl _singleton = PaymentDaoImpl._internal();

  factory PaymentDaoImpl() {
    return _singleton;
  }

  PaymentDaoImpl._internal();

  @override
  Stream<void> getAllPaymentEventStream() {
    return getPaymentBox().watch();
  }

  @override
  Stream<List<PaymentVO>> getPaymentStream() {
    return Stream.value(getAllPayments().toList());
  }

  @override
  void saveAllPayments(List<PaymentVO>? paymentList) async {
    Map<int, PaymentVO> paymentMap = Map.fromIterable(paymentList ?? [], key: (payment) => payment.id, value: (payment) => payment);
    await getPaymentBox().putAll(paymentMap);
  }

  @override
  List<PaymentVO> getAllPayments() {
    return getPaymentBox().values.toList();
  }

  Box<PaymentVO> getPaymentBox() {
    return Hive.box<PaymentVO>(BOX_NAME_PAYMENT_VO);
  }

}
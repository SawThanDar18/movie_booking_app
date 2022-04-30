import 'package:movie_booking_app/data/vos/cinema/payment_vo.dart';
import 'package:movie_booking_app/persistence/daos/payment_dao.dart';

import '../mock_data/mock_data.dart';

class PaymentDaoImplMock extends PaymentDao {
  Map<int, PaymentVO> paymentMethodFromDatabaseMock = {};

  @override
  Stream<void> getAllPaymentEventStream() {
    return Stream.value(null);
  }

  @override
  List<PaymentVO> getAllPayments() {
    return getMockPaymentMethodList();
  }

  @override
  Stream<List<PaymentVO>> getPaymentStream() {
    return Stream.value(getMockPaymentMethodList());
  }

  @override
  void saveAllPayments(List<PaymentVO>? paymentList) {
    paymentList?.forEach((payment) {
      paymentMethodFromDatabaseMock[payment.id ?? 0] = payment;
    });
  }

}
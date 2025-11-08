
import 'package:edc_v2/core/model/either.dart';
import 'package:edc_v2/core/model/failure.dart';

abstract class PaymentRepository{
  Future<Either<Failure,String>> requestPayment(double amount, String applicationId);
}
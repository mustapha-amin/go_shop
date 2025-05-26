sealed class PaymentStatus {}
class PaymentInitial extends PaymentStatus {}
class PaymentPending extends PaymentStatus {}
class PaymentSuccess extends PaymentStatus {}
class PaymentFailed extends PaymentStatus {
  final String error;
  PaymentFailed(this.error);
}
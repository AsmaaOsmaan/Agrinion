class Payment{
  int ? paymentId;
  double? paymentAmount;
  int?  invoiceId;
  String? createdAt;
  Payment({
    this.invoiceId,
    this.paymentAmount,
    this.paymentId,
    this.createdAt
});

}
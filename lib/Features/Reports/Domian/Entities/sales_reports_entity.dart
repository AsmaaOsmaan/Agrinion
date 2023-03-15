class SalesReportEntity {
  String? clientNumber;
  String? clientName;
  String? invoiceNumber;
  int? clientId;
  int? productId;
  String? fromDate;
  String? toDate;

  SalesReportEntity({
    this.clientNumber,
    this.invoiceNumber,
    this.clientId,
    this.productId,
    this.fromDate,
    this.toDate,
    this.clientName,
  });

  String toUrl() {
    String url = "";
    if (fromDate != "") {
      url = url + "from_date=$fromDate&";
    }
    if (toDate != "") {
      url = url + "to_date=$toDate&";
    }
    if (productId != null) {
      url = url + "product=$productId&";
    }
    if (clientId != null) {
      url = url + "client_name_id=$clientId&";
    }
    if (clientNumber != "") {
      url = url + "client_number=$clientNumber&";
    }
    if (invoiceNumber != "") {
      url = url + "invoice_number=$invoiceNumber&";
    }
    return url;
  }
}

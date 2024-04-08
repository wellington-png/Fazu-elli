class Expense {
  
  final int? year;
  final String? cnpjCpfSupplier;
  final int? documentCode;
  final int? batchCode;
  final int? documentTypeCode;
  final String? documentDate;
  final int? month;
  final String? supplierName;
  final String? documentNumber;
  final String? reimbursementNumber;
  final int? installment;
  final String? expenseType;
  final String? documentType;
  final String? documentURL;
  final double? documentValue;
  final double? glossValue;
  final double? netValue;

  Expense({
    this.year,
    this.cnpjCpfSupplier,
    this.documentCode,
    this.batchCode,
    this.documentTypeCode,
    this.documentDate,
    this.month,
    this.supplierName,
    this.documentNumber,
    this.reimbursementNumber,
    this.installment,
    this.expenseType,
    this.documentType,
    this.documentURL,
    this.documentValue,
    this.glossValue,
    this.netValue,
  });

factory Expense.fromJson(Map<String, dynamic> json) {
  return Expense(
    year: json['ano'] ?? 0,
    cnpjCpfSupplier: json['cnpjCpfFornecedor'] ?? '',
    documentCode: json['codDocumento'] ?? '',
    batchCode: json['codLote'] ?? '',
    documentTypeCode: json['codTipoDocumento'] ?? '',
    documentDate: json['dataDocumento'] ?? '',
    month: json['mes'] ?? 0,
    supplierName: json['nomeFornecedor'] ?? '',
    documentNumber: json['numDocumento'] ?? '',
    reimbursementNumber: json['numRessarcimento'] ?? '',
    installment: json['parcela'] ?? '',
    expenseType: json['tipoDespesa'] ?? '',
    documentType: json['tipoDocumento'] ?? '',
    documentURL: json['urlDocumento'] ?? '',
    documentValue: json['valorDocumento'] ?? 0.0,
    glossValue: json['valorGlosa'] ?? 0.0,
    netValue: json['valorLiquido'] ?? 0.0,
  );
}

  static List<Expense> fromJsonList(List<dynamic> json) {
    return json.map((expense) => Expense.fromJson(expense)).toList();
  }
}

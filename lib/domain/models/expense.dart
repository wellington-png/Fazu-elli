class ExpenseModel {
  
  final int year;
  final String cnpjCpfSupplier;
  final int documentCode;
  final int batchCode;
  final int documentTypeCode;
  final String documentDate;
  final int month;
  final String supplierName;
  final String documentNumber;
  final String reimbursementNumber;
  final int installment;
  final String expenseType;
  final String documentType;
  final String documentURL;
  final double documentValue;
  final double glossValue;
  final double netValue;

  ExpenseModel({
    required this.year,
    required this.cnpjCpfSupplier,
    required this.documentCode,
    required this.batchCode,
    required this.documentTypeCode,
    required this.documentDate,
    required this.month,
    required this.supplierName,
    required this.documentNumber,
    required this.reimbursementNumber,
    required this.installment,
    required this.expenseType,
    required this.documentType,
    required this.documentURL,
    required this.documentValue,
    required this.glossValue,
    required this.netValue,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      year: json['ano'],
      cnpjCpfSupplier: json['cnpjCpfFornecedor'],
      documentCode: json['codDocumento'],
      batchCode: json['codLote'],
      documentTypeCode: json['codTipoDocumento'],
      documentDate: json['dataDocumento'],
      month: json['mes'],
      supplierName: json['nomeFornecedor'],
      documentNumber: json['numDocumento'],
      reimbursementNumber: json['numRessarcimento'],
      installment: json['parcela'],
      expenseType: json['tipoDespesa'],
      documentType: json['tipoDocumento'],
      documentURL: json['urlDocumento'],
      documentValue: json['valorDocumento'],
      glossValue: json['valorGlosa'],
      netValue: json['valorLiquido'],
    );
  }
}

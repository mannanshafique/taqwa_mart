class ProductOrderCreationModel {
  String id;
  String? quantity;
  String? amount;
  

  ProductOrderCreationModel({this.quantity, this.amount, required this.id});

  ProductOrderCreationModel.fromJson(Map<String, dynamic> json)
      : 
        id = json['id'],
        quantity = json['quantity'],
        amount = json['amount'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'quantity': quantity,
        'amount': amount,
       
      };
}
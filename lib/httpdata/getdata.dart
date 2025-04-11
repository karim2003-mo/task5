import 'dart:convert';

import 'package:http/http.dart' as http;
class GetData{
  static const String BASE_URL="https://labour-britta-hend-ff0587b6.koyeb.app";
  Future getproducts() async{
    Uri uri=Uri.parse("$BASE_URL/app/products/");
    var response=await http.get(uri).timeout(const Duration(seconds: 10),);
    if(response.statusCode==200){
      List products=jsonDecode(response.body)["products"];
      return products;}else{
        return null;
      }
  }
}
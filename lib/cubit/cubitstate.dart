import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task5/cubit/widgetstate.dart';
import 'package:task5/httpdata/getdata.dart';
import 'package:task5/httpdata/product.dart';

class HttpCubitState extends Cubit<FetchData>{
  HttpCubitState():super(Loading());
  void fetchdata()async{
    try{
      List data=await GetData().getproducts();
      List newdata=Product.convert_to_product(data);
      emit(Loaded(newdata));
    }catch(e){
      emit(Error());
    }
  }
}
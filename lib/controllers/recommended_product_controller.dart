import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../data/repositary/recommended_product_repo.dart';
import '../model/recommended_model.dart';
import '../utils/constants.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductsRepo recommendedProductsRepo;

  //init
  RecommendedProductController({required this.recommendedProductsRepo});

  List<Products> _recommendedProductList = [];

  // List<dynamic> getterPopularProductList(){
  //   return _popularProductList;
  // }
  bool _isLoading = false ;
  bool  get isLoading => _isLoading;
  List<Products> get recommendedProductList => _recommendedProductList;

  Future<void> getRecommendedProductList() async {
    Response response = await recommendedProductsRepo.getRecommendedProductList();
    if(response.statusCode ==200 ){
      _recommendedProductList = [];
      _recommendedProductList.addAll(RecommendedProductModel.fromJson(response.body).products!);
      _isLoading = true ;
      update();
    }
    else {
      print("else ${response.statusCode}");
    }
  }
}
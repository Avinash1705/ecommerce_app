
import 'package:ecommerce_app/data/api/api_client.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';

class PopularProductsRepo extends GetxService{
    final ApiClient apiClient;

    PopularProductsRepo({required this.apiClient});

    Future<Response> getPopularProductList() async{
      return await apiClient.getData(Constants.popularProductUri);
    }
}
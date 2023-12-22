import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';

import '../../utils/constants.dart';
import '../api/api_client.dart';

class RecommendedProductsRepo extends GetxService{
  final ApiClient apiClient;

  RecommendedProductsRepo({required this.apiClient});

  Future<Response> getRecommendedProductList() async{
    return await apiClient.getData(Constants.recommendedProductUri);
  }
}
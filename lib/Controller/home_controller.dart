import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kenmark_itan_assignment/Modle/product_list_modle.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  List<ProductListModel>? product_list;
  List<ProductListModel>? response_list;
  List<ProductListModel> searchResult = [];
  var search = false;

  List slides = [
    "product1.png",
    "product2.png",
    "product3.jpg",
    "product4.jpeg",
    "product5.jpeg",
  ];

  

  @override
  void onInit() {
    getResponse();

    // TODO: implement onInit
    super.onInit();
  }
// To Get Coffee Products From APi
  getResponse() async {
    filter = false;
    update();
    try {
      var uri =
          await http.get(Uri.parse("https://api.sampleapis.com/coffee/hot"));
      if (uri.statusCode == 200) {
        var response = jsonDecode(uri.body);
        print("---------Product Response-----------");
        print(response);

     
        response_list =
            ProductListModel.getProductList(response).cast<ProductListModel>();
        update();

    
      
      }
    } catch (e) {
      print(e);
    }
  }
//To Get Search Results
  getSearchResult(String query) {
    searchResult = [];

    if (query.isNotEmpty) {
      response_list!.forEach((element) {
        if (element.title!.toLowerCase().contains(query.toLowerCase())) {
          searchResult.add(element);
          update();
          
        }
      });
    } else {
      getResponse();
    }
  }

  showResults() {
    
filter=true;
    search = true;

    update();
    searchResult=[];
    update();
    product_list=[];
    update();
  }

  searchFinalResult() {
    product_list = null;

    product_list = searchResult;
    update();
  }

  static List category = ["Latte", "Mocha", "Caramel", "Machhiato"];
  List selectedFilters = [];
  static List<bool> checkedItems =
      List.generate(category.length, (index) => false);
  showCheckboxDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Options'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: MediaQuery.sizeOf(context).height*0.3,
                child: Column(
                  children: [
                    for (int i = 0; i <= checkedItems.length - 1; i++) ...[
                      CheckboxListTile(
                        title: Text(category[i]),
                        value: checkedItems[i],
                        onChanged: (bool? value) {
                         
                          setState(() {
                            checkedItems[i] = value!;
                          });
                          setState(() {
                            if (value!) {
                              selectedFilters.add(category[i].toString());
                            }
                            if (!value) {
                              if (selectedFilters.contains(category[i])) {
                                selectedFilters.remove(category[i]);
                              }
                            }
                          });
                          print(selectedFilters);
                        },
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                getApplyFiltersList();
                // Do something with the selected options
                print('Selected Options: $checkedItems');
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

//Funtion to apply filters
  var filter = false;
  getApplyFiltersList() {
    product_list = [];
    filter = true;
    update();
    for (var j in selectedFilters) {
      for (int i = 0; i < response_list!.length - 1; i++) {
        {
          if (response_list![i].title!.contains(j[0])) {
            print(response_list![i]);
            product_list!.add(response_list![i]);
            update();
          }
        }
      }
    }
    print("product list length");
    print(product_list!.length);
  }
  toggleFilter(){
    filter=false;
    product_list=[];
    update();
  }
}

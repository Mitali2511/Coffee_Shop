import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kenmark_itan_assignment/Modle/product_list_modle.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  List imageurls = [
    "https://firebasestorage.googleapis.com/v0/b/kenmark-itan-assignment.appspot.com/o/sliders%2Fproduct1.png?alt=media&token=43e535e6-2552-4137-85ed-6c3d1e41318e",
    "https://firebasestorage.googleapis.com/v0/b/kenmark-itan-assignment.appspot.com/o/sliders%2Fproduct3.jpg?alt=media&token=89ad3416-9490-4c73-8b6f-1a7083c84383",
    "https://firebasestorage.googleapis.com/v0/b/kenmark-itan-assignment.appspot.com/o/sliders%2Fproduct2.png?alt=media&token=15779c37-21c8-4707-a74b-13e7b7ed8714",
    "https://firebasestorage.googleapis.com/v0/b/kenmark-itan-assignment.appspot.com/o/sliders%2Fproduct4.jpeg?alt=media&token=e3c1bb44-d4bf-4b22-9bb1-f6e9e0e3361d",
    "https://firebasestorage.googleapis.com/v0/b/kenmark-itan-assignment.appspot.com/o/sliders%2Fproduct5.jpeg?alt=media&token=b39c92e6-4a0b-404c-969a-0c2915adc5e5"
  ];

  List<ProductListModel>? product_list;
  final slide = PageController();
  List<ProductListModel>? response_list;
  List<ProductListModel> searchResult = [];
  static List category = ["Latte", "Mocha", "Caramel", "Machhiato"];
  List selectedFilters = [];
  static List<bool> checkedItems =
      List.generate(category.length, (index) => false);

  var search = false;

  List slides = [];

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

//To show the results on screen
  showResults() {
    filter = true;
    search = true;

    update();
    searchResult = [];
    update();
    product_list = [];
    update();
  }

//Final Search Result
  searchFinalResult() {
    product_list = null;

    product_list = searchResult;
    update();
  }

  //DailogBox
  showCheckboxDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Options'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: MediaQuery.sizeOf(context).height * 0.3,
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
  }

  toggleFilter() {
    filter = false;
    product_list = [];
    update();
  }
}

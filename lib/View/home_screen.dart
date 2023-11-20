import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kenmark_itan_assignment/Controller/home_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  
  final TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 219, 185, 172),
//AppBar

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            //Logo
            Image(
              image: const AssetImage(
                "assets/logo.png",
              ),
              height: MediaQuery.sizeOf(context).height * 0.08,
            ),
            //Name
            Text(
              "Coffee Shop",
              style: Theme.of(context).textTheme.titleLarge,
            )
          ],
        ),
      ),

//Body

      body: GetBuilder<HomeController>(
          init: HomeController(),
          builder: (controller) {
            return ListView(padding: const EdgeInsets.all(10), children: [
//SearchBar

              TextField(
                onTap: () {
                  controller.showResults();
                },
                controller: search,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(255, 236, 236, 236),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  hintText: "search",
                  prefixIcon: const Icon(
                    Icons.search,
                  ),
                ),
                onChanged: (value) {
                  controller.getSearchResult(value);
                  controller.searchFinalResult();
                },
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.01,
              ),

//Search result List

              controller.search
                  ? controller.searchResult.isEmpty
                      ? const Offstage()
                      : Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white),
                          child: ListView.builder(
                            itemCount: controller.searchResult.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return ListTile(
                                onTap: () {
                                  controller.searchFinalResult();
                                },
                                title:
                                    Text(controller.searchResult[index].title!),
                              );
                            },
                          ),
                        )
                  : const Offstage(),

//Back Button

              controller.filter
                  ? controller.product_list!.isEmpty
                      ? const Offstage()
                      : Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                              onPressed: () {
                                controller.toggleFilter();
                              },
                              icon: const Icon(Icons.arrow_back)),
                        )
                  : const Offstage(),

//Filtered Result List

              controller.filter || controller.search
                  ? controller.product_list == null
                      //

                      ? const Center(child: CircularProgressIndicator())
                      //
                      : controller.product_list!.isEmpty
                          //
                          ? const Offstage()
                          //
                          : Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.product_list!.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        children: [
//Image

                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        controller
                                                            .product_list![
                                                                index]
                                                            .image!),
                                                    fit: BoxFit.cover)),
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.2,
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.35,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.03,
                                          ),

                                          //
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
//Name

                                              Text(
                                                controller.product_list![index]
                                                    .title!,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.08,
                                              ),

//Price

                                              Text(
                                                "Rs.${controller.product_list![index].id}00",
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              //Buttons

                                              Row(
                                                children: [
                                                  OutlinedButton(
                                                      style: OutlinedButton
                                                          .styleFrom(
                                                              side: const BorderSide(
                                                                  color: Colors
                                                                      .brown)),
                                                      onPressed: () {},
                                                      child: const Text(
                                                          "Add to Cart")),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  OutlinedButton(
                                                      style: OutlinedButton
                                                          .styleFrom(
                                                              side: const BorderSide(
                                                                  color: Colors
                                                                      .brown)),
                                                      onPressed: () {},
                                                      child:
                                                          const Text("Buy Now"))
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                  : const Offstage(),

//slides

              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.3,
                child: PageView.builder(
                    itemCount: controller.slides.length,
                    controller: controller.slide,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/${controller.slides[index]}"),
                                fit: BoxFit.cover),
                          ),
                          width: MediaQuery.sizeOf(context).width * 0.3,
                        ),
                      );
                    }),
              ),
//SmoothPageIndicator

              Center(
                child: SmoothPageIndicator(
                  controller: controller.slide,
                  count: controller.slides.length,
                  effect: const ScrollingDotsEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      dotColor: Colors.white,
                      activeDotColor: Colors.white),
                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.03,
              ),

//Grid view

              controller.response_list == null
                  ? const Center(child: CircularProgressIndicator())
                  : controller.response_list!.isEmpty
                      ? const Text("No Data Found")
                      : Expanded(
                          child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: controller.response_list!.length,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: 0.55),
                          itemBuilder: (context, index) {
                            return Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                children: [
//Image

                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20)),
                                        image: DecorationImage(
                                            image: NetworkImage(controller
                                                .response_list![index].image!),
                                            fit: BoxFit.cover)),
                                    height:
                                        MediaQuery.sizeOf(context).height * 0.2,
                                    width: MediaQuery.sizeOf(context).width,
                                  ),

//Name

                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          controller
                                              .response_list![index].title!,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.03,
                                        ),

//Price

                                        Text(
                                          "Rs.${controller.response_list![index].id}00",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
//Buttons

                                        SizedBox(
                                          width: double.infinity,
                                          child: OutlinedButton(
                                              style: OutlinedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  side: const BorderSide(
                                                      color: Colors.brown)),
                                              onPressed: () {},
                                              child: const Text("Add to Cart")),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          child: OutlinedButton(
                                              style: OutlinedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  side: const BorderSide(
                                                      color: Colors.brown)),
                                              onPressed: () {},
                                              child: const Text("Buy Now")),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ))
            ]);
          }),
//Filter button

      floatingActionButton: GetBuilder<HomeController>(builder: (controller) {
        return FloatingActionButton(
            child: Icon(
              Icons.filter_alt_outlined,
              size: MediaQuery.sizeOf(context).height * 0.045,
            ),
            onPressed: () {
              controller.showCheckboxDialog(context);
            });
      }),
    );
  }
}

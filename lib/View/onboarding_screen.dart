import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kenmark_itan_assignment/Modle/onboarding_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});

  final List<OnBoardModel> onBoardList = [
    OnBoardModel(image: "search.jpeg", title: "Search for coffee"),
    OnBoardModel(image: "filter.jpeg", title: "Filter by choice"),
    OnBoardModel(image: "add to cart.jpeg", title: "Add to cart"),
  ];

  final onboard = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [


//Pageview.builder


          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.7,
            child: PageView.builder(
                itemCount: onBoardList.length,
                controller: onboard,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset("assets/${onBoardList[index].image}"),
                      
                      Text(onBoardList[index].title.toString(),
                          style: Theme.of(context).textTheme.titleLarge),
                    ],
                  );
                }),
          ),
          Center(
            child: SmoothPageIndicator(
              controller: onboard,
              count: onBoardList.length,
              effect: const ScrollingDotsEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  dotColor: Color.fromARGB(255, 93, 62, 62),
                  activeDotColor: Color.fromARGB(255, 138, 109, 109)),
            ),
          ),
         
//Button



          ElevatedButton(
              onPressed: () {
                Get.toNamed("/login");
              },
              child: const Text("Get Started"))
        ],
      ),
    );
  }
}

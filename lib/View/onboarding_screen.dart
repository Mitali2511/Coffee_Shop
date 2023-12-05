import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kenmark_itan_assignment/Modle/onboarding_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});

  final List<OnBoardModel> onBoardList = [
    OnBoardModel(image: "https://firebasestorage.googleapis.com/v0/b/kenmark-itan-assignment.appspot.com/o/search.jpeg?alt=media&token=7b335a79-ddee-427a-96c8-345ea5218c7a", title: "Search for coffee"),
    OnBoardModel(image: "https://firebasestorage.googleapis.com/v0/b/kenmark-itan-assignment.appspot.com/o/filter.jpeg?alt=media&token=63c957e7-21ac-4e11-a225-e782080f27a4", title: "Filter by choice"),
    OnBoardModel(image: "https://firebasestorage.googleapis.com/v0/b/kenmark-itan-assignment.appspot.com/o/add%20to%20cart.jpeg?alt=media&token=e7fd5190-5af5-48d5-92ab-a5c737b0ff47", title: "Add to cart"),
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
                      Image.network(onBoardList[index].image!),
                      
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


import 'package:custom_clippers/custom_clippers.dart';
import 'package:e_commerce_app/screens/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';



class BoardingModel
{
  final String image;
  final String title;
  final String text1;
  final String text2;


  BoardingModel({
    required this.image,
    required this.title,
    required this.text1,
    required this.text2,
  });
}

class OnBoardingScreen extends StatefulWidget {

  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boarderController = PageController();

  bool islast =false;

  List<BoardingModel> boarding=[

  BoardingModel(
      image: 'assets/images/Purchase online.png',
      title: 'Purchase Online !!',
      text1: 'Searh for your product online in easy and explore',
      text2: 'others in the same you interest in' ),
  BoardingModel(
      image: 'assets/images/Track Order.png',
      title: 'Track order !!',
      text1: 'Searh for your product online in easy and explore',
      text2: 'others in the same you interest in' ),
    BoardingModel(
        image: 'assets/images/Get your order.png',
        title: 'Get your order !!',
        text1: 'Searh for your product online in easy and explore',
        text2: 'others in the same you interest in' ),




  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        actions: [
          TextButton(onPressed: (){
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context)=>Home()),
                      (route) => false);

          },
              child: Text('SKIP',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20
              ),
              ))
        ],
      ),
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            Stack(
              children: [
                ClipPath(
                  clipper: SinCosineWaveClipper(),
                  child: Container(
                    height: 170,
                    padding:const EdgeInsets.all(10),
                    color: Colors.green,
                    alignment: Alignment.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      //icon
                      Image.asset(
                        'assets/images/icon0.png',
                        width: 55,
                        height: 42,
                      ),

                      // ecommerce shop
                      const Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          'eCommerce Shop',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        ),
                      ),

                      // the line
                      Container(
                        width: 225,
                        height: 1,
                        color: Colors.white,

                      ),
                      const SizedBox(height: 5,),
                      const Text('Professional App for your',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16
                      ),
                      ),
                      const Text('eCommerce business',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16
                        ),
                      )
                    ],
                  ),
                )

              ],
            ),
          Expanded(
            child: PageView.builder(
              physics:const BouncingScrollPhysics(),
              onPageChanged: (int index){
                if(index == boarding.length-1){
                 setState(() {
                   islast=true;
                 });
                }else{
                  setState(() {
                    islast=false;
                  });
                }
              },
              controller: boarderController,
              itemBuilder: (context,index)=>buildBoardingItem(boarding[index]),
              itemCount: boarding.length,),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SmoothPageIndicator(controller: boarderController,
                    count: boarding.length,
                  effect:const  ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5,
                    activeDotColor: Colors.green
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: (){
                    if(islast){
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context)=>Home()),
                              (route) => false);
                    }
                    else{


                    boarderController.nextPage(duration:const Duration(milliseconds: 750) ,
                        curve: Curves.fastLinearToSlowEaseIn);
                    }

                  },
                  child:const Icon(Icons.arrow_forward_ios),
                  backgroundColor: Colors.green,
                ),
              ],
            ),
          ),


        ],
      )
    );
  }

  Widget buildBoardingItem(BoardingModel model)=>Column(
    children: [
      Image.asset(
        '${model.image}',
        height: 320,
      ),
      const SizedBox(height: 20,),
      Text('${model.title}',
        style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold
        ),
      ),
      Text('${model.text1}',),
      Text('${model.text2}'),

    ],
  );
}

import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children:  [
          Container(
            height: 20,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) =>  Text("LLLL"),
                separatorBuilder: (context, index) => SizedBox(width: 10,),
                itemCount: 10),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            child: ListView.separated(
              physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) =>  Text("LLLL"),
                separatorBuilder: (context, index) => SizedBox(width: 10,),
                itemCount: 100),
          ),


        ],
      ),
    );
  }
}

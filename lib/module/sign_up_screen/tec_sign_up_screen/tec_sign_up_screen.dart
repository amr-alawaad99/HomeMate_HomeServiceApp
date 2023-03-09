import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:login_register_methods/shared/components/components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../shared/components/constants.dart';

class Services {
  final String icon;
  final String job;
  bool? selected = false;

  Services({
    required this.icon,
    required this.job,
    this.selected,
  });
}

class TecSignUpScreen extends StatefulWidget {
  const TecSignUpScreen({super.key});

  @override
  State<TecSignUpScreen> createState() => _TecSignUpScreenState();
}

class _TecSignUpScreenState extends State<TecSignUpScreen> {
  List<Services> serviceList = [
    Services(icon: "assets/images/carpentry.png", job: "Carpentry"),
    Services(icon: "assets/images/cleaning.png", job: "Cleaning"),
    Services(icon: "assets/images/electrician.png", job: "Electrician"),
    Services(icon: "assets/images/kitchen.png", job: "Kitchen"),
    Services(icon: "assets/images/plumbing.png", job: "Plumbing"),
  ];

  bool value = false;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    PageController serviceController = PageController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title text
              RichText(
                text: TextSpan(
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 22.0),
                    children: [
                      const TextSpan(
                        text: "Creating ",
                      ),
                      TextSpan(
                        text: "Technical ",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 22.0,
                            color: secondaryColor,
                            fontStyle: FontStyle.italic),
                      ),
                      const TextSpan(
                        text: "account.",
                      ),
                    ]),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),

              /// Caption text
              Text(
                "Create your account now and be a service provider",
                style:
                    Theme.of(context).textTheme.caption!.copyWith(fontSize: 18.0),
              ),
              SizedBox(
                height: screenHeight * 0.04,
              ),

              /// Page indicator
              SmoothPageIndicator(
                controller: serviceController,
                count: 2,
                axisDirection: Axis.horizontal,
                effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 8.0,
                    expansionFactor: 2.5,
                    dotWidth: 8.0,
                    spacing: 5.0,
                    activeDotColor: secondaryColor),
              ),
              SizedBox(
                height: screenHeight * 0.04,
              ),

              /// Caption text
              Text(
                "Choose a service",
                style:
                    Theme.of(context).textTheme.caption!.copyWith(fontSize: 18.0),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),

              /// Choose service ListView
              Container(
                height: 130,
                child: ListView.separated(
                  itemCount: serviceList.length,
                  controller: serviceController,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) =>
                      servicesBuilder(serviceList[index], index),
                  separatorBuilder: (context, index) => SizedBox(),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),

              /// TFFs
              Row(
                children: [
                  Expanded(
                    child: defaultTextFromField(
                      hintText: "First Name",
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.02,
                  ),
                  Expanded(
                    child: defaultTextFromField(
                      hintText: "Lase Name",
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Container(
                child: defaultTextFromField(
                  hintText: "Email",
                ),
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 20.0,
                        offset: Offset(0.0, 0.75)),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      const Text("+20"),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                        child: Container(
                          height: 40,
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          style: const TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 18.0,
                          ),
                          decoration: const InputDecoration(
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            hintText: "Phone Number",
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Container(
                child: defaultTextFromField(
                    hintText: "Create Password", isSuffix: true),
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Container(
                child: defaultTextFromField(
                    hintText: "Repeat Password", isSuffix: true),
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Row(
                children: [
                  Checkbox(
                    value: value,
                    onChanged: (bool? value) {
                      setState(() {
                        this.value = value!;
                      });
                    },
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                          text: "Do you agree to our ",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 15.0),
                          children: [
                            TextSpan(
                              text: "Privacy Policy and Terms.",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                  color: Colors.blue,
                                  fontSize: 15.0,
                                  decoration: TextDecoration.underline),
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              Container(
                child: defaultButton(
                  text: "Create account",
                  onPress: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget servicesBuilder(Services services, int index) => Padding(
        padding: const EdgeInsets.all(5.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(10.0),
          onTap: () {
            setState(() {
              for(int i = 0; i < serviceList.length; i++){
                serviceList[i].selected = false;
              }
              serviceList[index].selected = true;
            });
          },
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              if(serviceList[index].selected == true)
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(
                    TablerIcons.circle_check,
                    color: successColor,
                  ),
                ),
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: serviceList[index].selected == true? Colors.greenAccent.withOpacity(0.2) : Colors.white,
                  border: Border.all(
                    color: serviceList[index].selected == true? successColor : Colors.grey.shade300,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage(
                        services.icon,
                      ),
                      height: 60,
                      width: 60,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(services.job),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}

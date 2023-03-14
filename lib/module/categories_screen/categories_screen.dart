import 'package:flutter/material.dart';
import 'package:login_register_methods/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            children: [
              defaultCategoriesBox(
                img: 'assets/images/cleaning.png',
                text: 'Cleaning',
              ),
              const SizedBox(
                width: 15,
              ),
              defaultCategoriesBox(
                img: 'assets/images/kitchen.png',
                text: 'Kitchen',
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              defaultCategoriesBox(
                img: 'assets/images/plumbing.png',
                text: 'Plumbing',
              ),
              const SizedBox(
                width: 15,
              ),
              defaultCategoriesBox(
                img: 'assets/images/paint.png',
                text: 'Paint',
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              defaultCategoriesBox(
                img: 'assets/images/carpentry.png',
                text: 'Carpentry',
              ),
              const SizedBox(
                width: 15,
              ),
              defaultCategoriesBox(
                img: 'assets/images/electrician.png',
                text: 'Electricity',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:dealhub/constants/global_variable.dart';
import 'package:dealhub/features/account/services/account_services.dart';
import 'package:dealhub/features/account/widgets/below_app_bar.dart';
import 'package:dealhub/features/account/widgets/orders.dart';
import 'package:dealhub/features/account/widgets/top_buttons.dart';
import 'package:dealhub/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: 120,
                    height: 45,
                    color: Colors.black,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Hello, ',
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: user.name,
                          style: const TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              IconButton(
                  onPressed: () => {
                        AccountServices().logOut(context),
                      },
                  icon: const Icon(Icons.logout))
            ],
          ),
        ),
      ),
      body: const Column(
        children: [
          //BelowAppBar(),
          // SizedBox(height: 10),
          // TopButtons(),
          SizedBox(height: 20),
          Orders(),
        ],
      ),
    );
  }
}

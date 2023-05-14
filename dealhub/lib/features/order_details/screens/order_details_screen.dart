import 'package:dealhub/common/widgets/custom_button.dart';
import 'package:dealhub/constants/global_variable.dart';
import 'package:dealhub/features/admin/services/admin_services.dart';
import 'package:dealhub/features/search/screens/search_screen.dart';
import 'package:dealhub/models/order.dart';
import 'package:dealhub/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class OrderDetailScreen extends StatefulWidget {
  static const String routeName = '/order-details';
  final Order order;
  const OrderDetailScreen({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  int currentStep = 0;
  final AdminServices adminServices = AdminServices();

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  void initState() {
    super.initState();
    currentStep = widget.order.status;
  }

  // ONLY FOR ADMIN
  void changeOrderStatus(int status) {
    adminServices.changeOrderStatus(
      context: context,
      status: status + 1,
      order: widget.order,
      onSuccess: () {
        setState(() {
          currentStep += 1;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: const Text(
            'Order details',
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          // title: Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Expanded(
          //       child: Container(
          //         height: 42,
          //         margin: const EdgeInsets.only(left: 15),
          //         child: Material(
          //           borderRadius: BorderRadius.circular(7),
          //           elevation: 1,
          //           child: TextFormField(
          //             onFieldSubmitted: navigateToSearchScreen,
          //             decoration: InputDecoration(
          //               prefixIcon: InkWell(
          //                 onTap: () {},
          //                 child: const Padding(
          //                   padding: EdgeInsets.only(
          //                     left: 6,
          //                   ),
          //                   child: Icon(
          //                     Icons.search,
          //                     color: Colors.black,
          //                     size: 23,
          //                   ),
          //                 ),
          //               ),
          //               filled: true,
          //               fillColor: Colors.white,
          //               contentPadding: const EdgeInsets.only(top: 10),
          //               border: const OutlineInputBorder(
          //                 borderRadius: BorderRadius.all(
          //                   Radius.circular(7),
          //                 ),
          //                 borderSide: BorderSide.none,
          //               ),
          //               enabledBorder: const OutlineInputBorder(
          //                 borderRadius: BorderRadius.all(
          //                   Radius.circular(7),
          //                 ),
          //                 borderSide: BorderSide(
          //                   color: Colors.black38,
          //                   width: 1,
          //                 ),
          //               ),
          //               hintText: 'Search',
          //               hintStyle: const TextStyle(
          //                 fontWeight: FontWeight.w500,
          //                 fontSize: 17,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const Text(
              //   'View order details',
              //   style: TextStyle(
              //     fontSize: 22,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Order Date:      ${DateFormat().format(
                      DateTime.fromMillisecondsSinceEpoch(
                          widget.order.orderedAt),
                    )}'),
                    Text('Order ID:          ${widget.order.id}'),
                    Text('Order Total:      \$${widget.order.totalPrice}'),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              // const Text(
              //   'Purchase Details',
              //   style: TextStyle(
              //     fontSize: 22,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (int i = 0; i < widget.order.products.length; i++)
                      Row(
                        children: [
                          Image.network(
                            widget.order.products[i].images[0],
                            height: 120,
                            width: 120,
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.order.products[i].name,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  'Qty: ${widget.order.quantity[i]}',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Tracking',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Stepper(
                  currentStep: currentStep,
                  controlsBuilder: (context, details) {
                    if (user.type == 'admin' && currentStep != 3) {
                      return CustomButton(
                        text: 'Done',
                        onTap: () => changeOrderStatus(details.currentStep),
                      );
                    }
                    return const SizedBox();
                  },
                  steps: [
                    Step(
                      title: const Text('Pending'),
                      content: const Text(
                        'Order is yet to be delivered',
                      ),
                      isActive: currentStep > 0,
                      state: currentStep > 0
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: const Text('Delivered'),
                      content: const Text(
                        'Order has been delivered.',
                      ),
                      isActive: currentStep > 1,
                      state: currentStep > 1
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: const Text('Received'),
                      content: Text(
                        user.type == 'admin'
                            ? 'Customer has received the order.'
                            : 'You have received your order.',
                      ),
                      isActive: currentStep > 2,
                      state: currentStep > 2
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: const Text('Completed'),
                      content: const Text(
                        'Your order has been completed and signed by you',
                      ),
                      isActive: currentStep >= 3,
                      state: currentStep >= 3
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

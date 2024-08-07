import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../common/color_pallete.dart';
import '../../../components/ui/custom_app_bar.dart';
import '../../../components/ui/my_list_view.dart';
import '../../../components/ui/rounded_container.dart';
import '../../../components/ui/text_view.dart';
import '../controllers/deposit_controller.dart';
import '../widgets/fixed_deposit_alert.dart';

// ignore: must_be_immutable
class MultipleAccountsScreen extends GetView<DepositController> {
  const MultipleAccountsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    // double ffem = fem * 0.97;

    return Scaffold(
      backgroundColor: ColorPallete.primary,
      body: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(0, 50 * fem),
          child: CustomAppBar(
              pageName:
                  "${controller.pageName.value.subgroupName!.capitalize!} Accounts"),
        ),
        backgroundColor: ColorPallete.theme,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10 * fem,
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 15.0 * fem),
              //   child: const Row(
              //     children: [
              //       TextView(
              //         text: "Your Accounts :",
              //         color: ColorPallete.secondary,
              //         fontSize: 16,
              //         weight: FontWeight.w700,
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(
                height: 5 * fem,
              ),
              Obx(
                () => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0 * fem),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RoundedContainer(
                        radius: 10,
                        borderColor: ColorPallete.secondary,
                        child: Padding(
                          padding: EdgeInsets.all(10.0 * fem),
                          child: MyListView(
                            children: [
                              const Center(
                                child: TextView(
                                  text: "Total Number of Accounts",
                                  color: ColorPallete.secondary,
                                  fontSize: 14,
                                  weight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: 10 * fem,
                              ),
                              Center(
                                child: TextView(
                                  text: "${controller.accounts.length}",
                                  color: ColorPallete.secondary,
                                  fontSize: 18,
                                  weight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10 * fem,
                      ),
                      RoundedContainer(
                        radius: 10,
                        borderColor: ColorPallete.secondary,
                        child: Padding(
                          padding: EdgeInsets.all(10.0 * fem),
                          child: MyListView(
                            children: [
                              const Center(
                                child: TextView(
                                  text: "Total Deposited Amount",
                                  color: ColorPallete.secondary,
                                  fontSize: 14,
                                  weight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: 10 * fem,
                              ),
                              Center(
                                child: TextView(
                                  text: "₹ ${controller.getTotalAmount()} /-",
                                  color: ColorPallete.secondary,
                                  fontSize: 18,
                                  weight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10 * fem,
                      ),
                      if (controller.selectedAccount.value.actype == "FD")
                        InkWell(
                          onTap: () {
                            controller.toClosedAccounts();
                          },
                          child: RoundedContainer(
                            radius: 10,
                            height: 40 * fem,
                            borderColor: ColorPallete.primary,
                            color: ColorPallete.primary,
                            child: const Center(
                              child: TextView(
                                text: "Closed Accounts",
                                color: ColorPallete.theme,
                                fontSize: 14,
                                weight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10 * fem,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 5,
                            backgroundColor: ColorPallete.red.withOpacity(0.2),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const TextView(
                            text: "Matured Fixed Deposit",
                            color: ColorPallete.secondary,
                            fontSize: 12,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 5,
                            backgroundColor: Colors.green.withOpacity(0.5),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const TextView(
                            text: "Maturity Date is near",
                            color: ColorPallete.secondary,
                            fontSize: 12,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),

              Expanded(
                child: Obx(
                  () => controller.isLoading.value
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0 * fem),
                          child: MyListView(
                            children: [
                              1,
                              2,
                              3,
                            ]
                                .map((e) => Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5.0 * fem,
                                          vertical: 5 * fem),
                                      child: RoundedContainer(
                                        radius: 0,
                                        child: Shimmer.fromColors(
                                          baseColor:
                                              Colors.grey.withOpacity(0.2),
                                          highlightColor: Colors.white,
                                          child: RoundedContainer(
                                            radius: 10,
                                            color: ColorPallete.grey,
                                            height: 100 * fem,
                                          ),
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        )
                      : controller.accounts.isEmpty
                          ? const SizedBox(
                              // height: 100,
                              child: Center(
                                child: TextView(
                                  text: "No Accounts",
                                  color: ColorPallete.grey,
                                  fontSize: 16,
                                ),
                              ),
                            )
                          : MyListView(
                              scroll: true,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.0 * fem,
                                      vertical: 5 * fem),
                                  child: MyListView(
                                    children: controller.accounts
                                        .map((element) => Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5.0 * fem,
                                                  vertical: 7.5 * fem),
                                              child: Container(
                                                decoration:
                                                    BoxDecoration(boxShadow: [
                                                  BoxShadow(
                                                    offset: Offset(0, 5 * fem),
                                                    blurRadius: 10,
                                                    spreadRadius: 2,
                                                    color: ColorPallete.grey
                                                        .withOpacity(0.2),
                                                  )
                                                ]),
                                                child: RoundedContainer(
                                                  radius: 10,
                                                  color: ColorPallete.theme,
                                                  clip: Clip
                                                      .antiAliasWithSaveLayer,
                                                  borderColor: Colors.grey
                                                      .withOpacity(0.2),
                                                  child: Container(
                                                    color: DateFormat(
                                                                    "yyyy-MM-dd")
                                                                .parse(element
                                                                    .fdMaster!
                                                                    .dateMatur!)
                                                                .difference(
                                                                    DateTime
                                                                        .now())
                                                                .inDays <
                                                            0
                                                        ? ColorPallete.red
                                                            .withOpacity(0.2)
                                                        :
                                                        // DateFormat("yyyy-MM-dd")
                                                        //             .parse(element
                                                        //                 .fdMaster!
                                                        //                 .dateMatur!)
                                                        //             .difference(
                                                        //                 DateTime
                                                        //                     .now())
                                                        //             .inDays <=
                                                        //         30
                                                        //     ?
                                                        Colors.green
                                                            .withOpacity(0.5),
                                                    // : ColorPallete.theme,
                                                    child: Padding(
                                                      padding: EdgeInsets.all(
                                                          15.0 * fem),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const TextView(
                                                                text:
                                                                    "Account No. : ",
                                                                color: ColorPallete
                                                                    .secondary,
                                                                fontSize: 14,
                                                              ),
                                                              Expanded(
                                                                child: TextView(
                                                                  text: element
                                                                      .fdMaster!
                                                                      .accountId!
                                                                      .capitalize!,
                                                                  color: ColorPallete
                                                                      .primary,
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 5 * fem,
                                                          ),
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const TextView(
                                                                text:
                                                                    "Account Name : ",
                                                                color: ColorPallete
                                                                    .secondary,
                                                                fontSize: 14,
                                                              ),
                                                              Expanded(
                                                                child: TextView(
                                                                  text: element
                                                                      .accountName!
                                                                      .capitalize!,
                                                                  color: ColorPallete
                                                                      .primary,
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 5 * fem,
                                                          ),
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              TextView(
                                                                text:
                                                                    "${(element.subgroupId ?? "") == "8" ? "RD" : "Deposit"} Amount : ",
                                                                color: ColorPallete
                                                                    .secondary,
                                                                fontSize: 14,
                                                              ),
                                                              Expanded(
                                                                child: TextView(
                                                                  text:
                                                                      "₹ ${element.fdMaster!.amount!}/-",
                                                                  color: ColorPallete
                                                                      .primary,
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 5 * fem,
                                                          ),
                                                          Row(
                                                            children: [
                                                              const TextView(
                                                                text:
                                                                    "Maturity Date : ",
                                                                color: ColorPallete
                                                                    .secondary,
                                                                fontSize: 14,
                                                              ),
                                                              TextView(
                                                                text: controller.formatDate(
                                                                    element
                                                                        .fdMaster!
                                                                        .dateMatur!,
                                                                    format:
                                                                        "yyyy-MM-dd"),
                                                                color:
                                                                    ColorPallete
                                                                        .red,
                                                                fontSize: 14,
                                                              ),
                                                              const Spacer(),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 10 * fem,
                                                          ),
                                                          Row(
                                                            children: [
                                                              const Spacer(),
                                                              InkWell(
                                                                onTap: () {
                                                                  // controller
                                                                  //     .onFDAccountSelected(
                                                                  //         element);

                                                                  showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return FixedDepositDetailsAlert(
                                                                        account:
                                                                            element,
                                                                        showStatement: [
                                                                          "8"
                                                                        ].contains(controller
                                                                            .pageName
                                                                            .value
                                                                            .subgroupId),
                                                                      );
                                                                    },
                                                                  );
                                                                },
                                                                child:
                                                                    RoundedContainer(
                                                                  radius: 10,
                                                                  color: ColorPallete
                                                                      .primary,
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            15.0 *
                                                                                fem,
                                                                        vertical:
                                                                            10 *
                                                                                fem),
                                                                    child:
                                                                        const TextView(
                                                                      text:
                                                                          "View More",
                                                                      color: ColorPallete
                                                                          .theme,
                                                                      fontSize:
                                                                          14,
                                                                      weight: FontWeight
                                                                          .bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                ),
                              ],
                            ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

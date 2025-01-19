import 'dart:async';

import 'package:business/src/controllers/current_user_company_controller.dart';
import 'package:business/src/models/other/company.dart';
import 'package:business/src/models/other/company_contact.dart';
import 'package:business/src/ui/pages/companies/widget/custom_btn.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompanyDetailScreen extends StatefulWidget {
  const CompanyDetailScreen({super.key, required this.company});
  final Company company;

  @override
  State<CompanyDetailScreen> createState() => _CompanyDetailScreenState();
}

class _CompanyDetailScreenState extends State<CompanyDetailScreen>
    with SingleTickerProviderStateMixin {
  final CurrentUserCompanyController _currentUserCompanyController =
      Get.find<CurrentUserCompanyController>();

  late TabController _tabController;
  var userCanReportCompany = false;
  var isCompanyReportSent = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCurrentUserCompanyInfo();
    });
  }

  Future<void> getCurrentUserCompanyInfo() async {
    var userCanReportCompanyResult = await _currentUserCompanyController
        .userCanReportCompany(clientId: widget.company.id ?? -1);
    setState(() {
      userCanReportCompany = userCanReportCompanyResult;
    });
  }

  void onSubmitReportCompany() async {
    var result = await _currentUserCompanyController.onSubmitReportCompany(
      clientId: widget.company.id!,
    );
    if (result == true) {
      setState(() {
        isCompanyReportSent = true;
      });
      Navigator.pop(context);
    }
  }

  Future<void> _makePhoneCall(String? phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber ?? '',
    );
    await launchUrl(launchUri);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (!didPop) {
          Get.back(result: true);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey.shade100,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: AppBar(
            elevation: 0,
            backgroundColor: Get.theme.primaryColor,
            iconTheme: const IconThemeData(color: Colors.white),
            title: Text(
              'Company Details',
              style: Get.theme.primaryTextTheme.bodyMedium
                  ?.copyWith(fontSize: 25, fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
          ),
        ),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade300,
                width: 1,
              ),
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.grey.shade300, // Border color
                      width: 0.5,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Hero(
                      tag: widget.company.id ?? '',
                      child: CachedNetworkImage(
                        imageUrl: widget.company.getCompanyLogoUrl() ?? '',
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              widget.company.companyName ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                wordSpacing: -1,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0, left: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  widget.company.timeAgo,
                                  style: Get.theme.primaryTextTheme.bodySmall
                                      ?.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey),
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                Icon(
                                  Icons.access_time,
                                  color: Colors.grey.shade500,
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: widget.company.category!.trim() != '' ? 8 : 0,
                      ),
                      widget.company.category!.trim() != ''
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 0),
                                  child: Icon(
                                    Icons.domain,
                                    color: Get.theme.primaryColor,
                                    size: 18,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Flexible(
                                  child: Text(
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    widget.company.category!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox(),
                      SizedBox(
                        height: widget.company.domain!.trim() != '' ? 8 : 0,
                      ),
                      widget.company.domain!.trim() != ''
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Icon(
                                    Icons.content_paste,
                                    color: Get.theme.primaryColor,
                                    size: 18,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Flexible(
                                  child: Text(
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    widget.company.domain!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox(),
                      SizedBox(
                        height: widget.company.email!.trim() != '' ? 8 : 0,
                      ),
                      widget.company.email!.trim() != ''
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Icon(
                                    Icons.email_outlined,
                                    color: Get.theme.primaryColor,
                                    size: 18,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Flexible(
                                  child: Text(
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    widget.company.email ?? '',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox(),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  String phoneNumber =
                                      widget.company.companyFax!;
                                  _makePhoneCall(phoneNumber);
                                },
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 2),
                                      child: Icon(
                                        Icons.fax_outlined,
                                        color: Get.theme.primaryColor,
                                        size: 18,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text.rich(
                                      maxLines: 1,
                                      style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text:
                                                '${widget.company.companyFax}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black87,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              widget.company.companyPhone1!.trim() != ''
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Center(
                                        child: Container(
                                          height: 20,
                                          width: 1,
                                          color: Colors.grey.shade300,
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                              widget.company.companyPhone1!.trim() != ''
                                  ? InkWell(
                                      onTap: () {
                                        String phoneNumber = widget.company
                                                .companyPhone1Extension! +
                                            widget.company.companyPhone1!;
                                        _makePhoneCall(phoneNumber);
                                      },
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 2),
                                            child: Icon(
                                              Icons.phone_outlined,
                                              color: Get.theme.primaryColor,
                                              size: 18,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text.rich(
                                            maxLines: 1,
                                            style: const TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            TextSpan(
                                              children: [
                                                widget.company
                                                            .companyPhone1Extension!
                                                            .trim() !=
                                                        ''
                                                    ? TextSpan(
                                                        text:
                                                            ' ${widget.company.companyPhone1Extension} ',
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.black87,
                                                          fontSize: 14,
                                                        ),
                                                      )
                                                    : const TextSpan(),
                                                TextSpan(
                                                  text:
                                                      '${widget.company.companyPhone1}',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black87,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : const SizedBox(),
                              widget.company.companyPhone2!.trim() != ''
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Center(
                                        child: Container(
                                          height: 20,
                                          width: 1,
                                          color: Colors.grey.shade300,
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                              widget.company.companyPhone2!.trim() != ''
                                  ? InkWell(
                                      onTap: () {
                                        String phoneNumber = widget.company
                                                .companyPhone2Extension! +
                                            widget.company.companyPhone2!;
                                        _makePhoneCall(phoneNumber);
                                      },
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 2),
                                            child: Icon(
                                              Icons.phone_outlined,
                                              color: Get.theme.primaryColor,
                                              size: 18,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text.rich(
                                            maxLines: 1,
                                            style: const TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            TextSpan(
                                              children: [
                                                widget.company
                                                            .companyPhone2Extension!
                                                            .trim() !=
                                                        ''
                                                    ? TextSpan(
                                                        text:
                                                            ' ${widget.company.companyPhone2Extension} ',
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.black87,
                                                          fontSize: 14,
                                                        ),
                                                      )
                                                    : const TextSpan(),
                                                TextSpan(
                                                  text:
                                                      '${widget.company.companyPhone2}',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black87,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Icon(
                              Icons.place_outlined,
                              color: Get.theme.primaryColor,
                              size: 18,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Flexible(
                            child: Text(
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              "${widget.company.companyAddress1}, ${widget.company.commune}, ${widget.company.wilaya}.",
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: widget.company.companyAddress2!.trim() != ''
                            ? 8
                            : 0,
                      ),
                      widget.company.companyAddress2!.trim() != ''
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Icon(
                                    Icons.place_outlined,
                                    color: Get.theme.primaryColor,
                                    size: 18,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Flexible(
                                  child: Text(
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    "${widget.company.companyAddress2}.",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),

                // SizedBox(
                //   height: widget.company.activity!.trim() != '' ? 8 : 0,
                // ),
                // widget.company.activity!.trim() != ''
                //     ? Container(
                //         width: double.infinity,
                //         padding: const EdgeInsets.symmetric(
                //             vertical: 14, horizontal: 10),
                //         decoration: BoxDecoration(
                //           color: Colors.grey.shade100,
                //           borderRadius: BorderRadius.circular(6),
                //         ),
                //         child: Flexible(
                //           child: Text.rich(
                //             maxLines: 5,
                //             style: const TextStyle(
                //               overflow: TextOverflow.ellipsis,
                //             ),
                //             TextSpan(
                //               children: [
                //                 TextSpan(
                //                   text: widget.company.activity,
                //                   style: TextStyle(
                //                     overflow: TextOverflow.ellipsis,
                //                     fontWeight: FontWeight.w600,
                //                     color: Colors.grey.shade600,
                //                     fontSize: 14,
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ),
                //       )
                //     : const SizedBox(),
                const SizedBox(
                  height: 2,
                ),
                TabBar(
                  controller: _tabController, // Attach controller
                  tabs: const [
                    Tab(
                      text: 'Description',
                    ),
                    Tab(
                      text: 'Contacts',
                    ),
                  ],
                  labelStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                  unselectedLabelStyle: const TextStyle(fontSize: 14),
                  labelColor: Colors.black,
                  indicatorColor: Get.theme.primaryColor,
                  indicatorSize: TabBarIndicatorSize.tab,
                  isScrollable: false,
                  dividerColor: Colors.grey.shade300,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 10),
                    child: TabBarView(
                      controller: _tabController, // Attach controller
                      children: [
                        SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                widget.company.description!.trim() != ''
                                    ? Text(
                                        widget.company.description!,
                                        style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      )
                                    : SizedBox(
                                        height: 150,
                                        child: Center(
                                          child: Text(
                                            'No description provided',
                                            style: TextStyle(
                                              color: Colors.grey.shade800,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                widget.company.contacts!.isNotEmpty
                                    ? _buildContacts()
                                    : SizedBox(
                                        height: 150,
                                        child: Center(
                                          child: Text(
                                            'No contact provided',
                                            style: TextStyle(
                                              color: Colors.grey.shade800,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                          ),
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

                _buildReportCompanyBtn(),

                // Text.rich(
                //   maxLines: 2,
                //   style: const TextStyle(
                //     overflow: TextOverflow.ellipsis,
                //   ),
                //   TextSpan(
                //     children: [
                //       const TextSpan(
                //         text: 'Address 1 : ',
                //         style: TextStyle(
                //           fontWeight: FontWeight.w600,
                //           color: Colors.black87,
                //           fontSize: 14,
                //         ),
                //       ),
                //       TextSpan(
                //         text: company.companyAddress1!.trim() != ''
                //             ? company.companyAddress1
                //             : 'unknown',
                //         style: const TextStyle(
                //           overflow: TextOverflow.ellipsis,
                //           // fontWeight: FontWeight.w600,
                //           color: Colors.black54,
                //           fontSize: 14,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // const SizedBox(
                //   height: 2,
                // ),
                // widget.company.companyAddress2!.trim() != ''
                //     ? Text.rich(
                //         maxLines: 2,
                //         style: const TextStyle(
                //           overflow: TextOverflow.ellipsis,
                //         ),
                //         TextSpan(
                //           children: [
                //             const TextSpan(
                //               text: 'Address 2 : ',
                //               style: TextStyle(
                //                 fontWeight: FontWeight.w600,
                //                 color: Colors.black87,
                //                 fontSize: 14,
                //               ),
                //             ),
                //             TextSpan(
                //               text: widget.company.companyAddress2!.trim() != ''
                //                   ? widget.company.companyAddress2
                //                   : 'unknown',
                //               style: const TextStyle(
                //                 overflow: TextOverflow.ellipsis,
                //                 // fontWeight: FontWeight.w600,
                //                 color: Colors.black54,
                //                 fontSize: 14,
                //               ),
                //             ),
                //           ],
                //         ),
                //       )
                //     : const SizedBox(),
                // const SizedBox(
                //   height: 6,
                // ),
                // Text(
                //   maxLines: 2,
                //   overflow: TextOverflow.ellipsis,
                //   company.domain ?? 'unknown',
                //   style: const TextStyle(
                //     fontWeight: FontWeight.w600,
                //     color: Colors.black87,
                //     fontSize: 14,
                //   ),
                // ),

                // const Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 10),
                //   child: Divider(
                //     thickness: 1.5,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContacts() {
    final contacts = widget.company.contacts ?? [];
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: contacts.asMap().entries.map(
          (entry) {
            final index = entry.key;
            final contact = entry.value;
            return _buildContact(contact, index);
          },
        ).toList());
  }

  Widget _buildContact(CompanyContact contact, int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact ${index + 1} :',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        contact.firstName!.trim() != '' || contact.lastName!.trim() != ''
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.person_outline,
                    color: Get.theme.primaryColor,
                    size: 18,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Flexible(
                    child: Text(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      ' ${contact.honorific ?? ''} ${contact.lastName} ${contact.firstName}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              )
            : const SizedBox(),
        SizedBox(
            height: (contact.firstName!.trim() != '' ||
                    contact.lastName!.trim() != '')
                ? 5
                : 0),
        contact.position!.trim() != ''
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Icon(
                      Icons.work_outline,
                      color: Get.theme.primaryColor,
                      size: 18,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Flexible(
                    child: Text(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      '${contact.position}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              )
            : const SizedBox(),
        SizedBox(height: contact.position!.trim() != '' ? 5 : 0),
        contact.email!.trim() != ''
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Icon(
                      Icons.email_outlined,
                      color: Get.theme.primaryColor,
                      size: 18,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Flexible(
                    child: Text(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      'Email: ${contact.email}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              )
            : const SizedBox(),
        SizedBox(height: contact.email!.trim() != '' ? 5 : 0),
        SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    String phoneNumber = contact.fax!;
                    _makePhoneCall(phoneNumber);
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Icon(
                          Icons.fax_outlined,
                          color: Get.theme.primaryColor,
                          size: 18,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text.rich(
                        maxLines: 1,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                        ),
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '${contact.fax}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                contact.phone1!.trim() != ''
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Center(
                          child: Container(
                            height: 20,
                            width: 1,
                            color: Colors.grey.shade300,
                          ),
                        ),
                      )
                    : const SizedBox(),
                contact.phone1!.trim() != ''
                    ? InkWell(
                        onTap: () {
                          String phoneNumber =
                              contact.phone1Extension! + contact.phone1!;
                          _makePhoneCall(phoneNumber);
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Icon(
                                Icons.phone_outlined,
                                color: Get.theme.primaryColor,
                                size: 18,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text.rich(
                              maxLines: 1,
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                              ),
                              TextSpan(
                                children: [
                                  contact.phone1Extension!.trim() != ''
                                      ? TextSpan(
                                          text: ' ${contact.phone1Extension} ',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black87,
                                            fontSize: 14,
                                          ),
                                        )
                                      : const TextSpan(),
                                  TextSpan(
                                    text: '${contact.phone1}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),
                widget.company.companyPhone2!.trim() != ''
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Center(
                          child: Container(
                            height: 20,
                            width: 1,
                            color: Colors.grey.shade300,
                          ),
                        ),
                      )
                    : const SizedBox(),
                widget.company.companyPhone2!.trim() != ''
                    ? InkWell(
                        onTap: () {
                          String phoneNumber =
                              widget.company.companyPhone2Extension! +
                                  widget.company.companyPhone2!;
                          _makePhoneCall(phoneNumber);
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Icon(
                                Icons.phone_outlined,
                                color: Get.theme.primaryColor,
                                size: 18,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text.rich(
                              maxLines: 1,
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                              ),
                              TextSpan(
                                children: [
                                  widget.company.companyPhone2Extension!
                                              .trim() !=
                                          ''
                                      ? TextSpan(
                                          text:
                                              ' ${widget.company.companyPhone2Extension} ',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black87,
                                            fontSize: 14,
                                          ),
                                        )
                                      : const TextSpan(),
                                  TextSpan(
                                    text: '${widget.company.companyPhone2}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
        Center(
          child: Container(
            width: 200,
            padding: const EdgeInsets.only(top: 14, left: 15, right: 15),
            child: Divider(
              thickness: 1,
              color: Colors.grey.shade400,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildReportCompanyBtn() {
    return Obx(() {
      if (!_currentUserCompanyController
              .isLoadingCurrentUserCompanyController() &&
          (userCanReportCompany == true) &&
          !isCompanyReportSent) {
        return Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  _showConfirmReportCompanyDialog();
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Get.theme.primaryColor,
                      width: 1,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.lightbulb_outline_rounded,
                          size: 20,
                          color: Get.theme.primaryColor,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "It's My company",
                          style: TextStyle(
                            color: Get.theme.primaryColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      } else {
        if (isCompanyReportSent == true) {
          return Container(
            height: 40,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.green,
            ),
            child: const Center(
              child: Text(
                'This Company has been Reported.',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      }
    });
  }

  void _showConfirmReportCompanyDialog() async {
    await Get.bottomSheet<void>(
      Container(
        padding: const EdgeInsets.all(0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 14, bottom: 8),
                child: Row(
                  children: [
                    Icon(
                      Icons.repeat_rounded,
                      color: Get.theme.primaryColor,
                      size: 22,
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    const Text(
                      'Report this Company : ',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 1,
                color: Colors.grey.shade300,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Form(
                  key: _currentUserCompanyController.reportCompanyFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Manager Note (optional) :',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        height:
                            100, // Set the height to mimic a textarea with 2 lines
                        child: TextFormField(
                          controller: _currentUserCompanyController
                              .managerDescriptionController,
                          onSaved: (value) => _currentUserCompanyController
                              .managerDescriptionController.text = value!,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return null;
                            }
                            if (GetUtils.isLengthGreaterThan(value, 255)) {
                              return 'Maximum characters allowed is 255';
                            }
                            return null;
                          },
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade700,
                                width: 1,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 16.0,
                            ),
                            hintStyle: Get.theme.textTheme.bodyMedium?.copyWith(
                              fontSize: 15,
                              color: Colors.black26,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                                width: 1.0,
                              ),
                            ),
                            hintText: 'Manager Note',
                          ),
                          maxLines: null,
                          expands:
                              true, // Allow the TextField to expand vertically
                          textAlignVertical: TextAlignVertical
                              .top, // Start the text from the top
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomBtn(
                        text: 'Submit',
                        textColor: Colors.white,
                        backgroundColor: Colors.blueGrey[700],
                        height: 45,
                        onTab: () {
                          onSubmitReportCompany();
                        },
                        isEnabled: !_currentUserCompanyController.isLoading(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

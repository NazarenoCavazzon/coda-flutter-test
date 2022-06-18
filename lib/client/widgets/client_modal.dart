import 'dart:io';

import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_coda/client/models/client.dart';
import 'package:test_coda/common/app_size.dart';
import 'package:test_coda/common/validators.dart';
import 'package:test_coda/common/widgets/coda_button.dart';
import 'package:test_coda/l10n/l10n.dart';
import 'package:test_coda/login/widgets/coda_text_form_field.dart';

class ClientModal extends StatefulWidget {
  const ClientModal({
    super.key,
    this.client,
  });
  final Client? client;

  @override
  State<ClientModal> createState() => _ClientModalState();
}

class _ClientModalState extends State<ClientModal> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final ImagePicker _picker = ImagePicker();
  XFile? image;

  @override
  void initState() {
    super.initState();
    if (widget.client != null) {
      setState(() {
        _firstNameController.text = widget.client?.firstname ?? '';
        _lastNameController.text = widget.client?.lastname ?? '';
        _emailController.text = widget.client?.email ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: AlertDialog(
          contentPadding: EdgeInsets.zero,
          insetPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppSize(context).pixels(10),
            ),
          ),
          content: Column(
            children: [
              Builder(
                builder: (context) {
                  final clientNull = widget.client == null;
                  return Form(
                    key: _formKey,
                    child: Container(
                      height: AppSize(context).pixels(500),
                      width: AppSize(context).pixels(300),
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSize(context).pixels(25),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: AppSize(context).pixels(25),
                            ),
                            child: Text(
                              clientNull
                                  ? context.l10n.addNewClient
                                  : context.l10n.editClient,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: AppSize(context).pixels(18),
                              ),
                            ),
                          ),
                          SizedBox(height: AppSize(context).pixels(20)),
                          Center(
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                _picker
                                    .pickImage(source: ImageSource.gallery)
                                    .then((image) {
                                  setState(() {
                                    this.image = image;
                                  });
                                });
                              },
                              child: Container(
                                width: AppSize(context).pixels(120),
                                height: AppSize(context).pixels(120),
                                alignment: Alignment.center,
                                decoration: DottedDecoration(
                                  shape: Shape.circle,
                                  color: const Color(0xffE4F353),
                                ),
                                child: Builder(
                                  builder: (context) {
                                    if (!clientNull &&
                                        widget.client?.photo != null &&
                                        widget.client?.photo?.isNotEmpty ==
                                            true) {
                                      return Image.network(
                                        widget.client?.photo ?? '',
                                        height: AppSize(context).pixels(120),
                                        width: AppSize(context).pixels(120),
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Icon(
                                            Icons.person,
                                            size: AppSize(context).pixels(
                                              120,
                                            ),
                                          );
                                        },
                                      );
                                    }
                                    if (image != null) {
                                      return SizedBox(
                                        width: AppSize(context).pixels(120),
                                        height: AppSize(context).pixels(120),
                                        child: CircleAvatar(
                                          backgroundImage: AssetImage(
                                            image!.path,
                                          ),
                                        ),
                                      );
                                    }
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/landscape.svg',
                                          height: AppSize(context).pixels(32),
                                        ),
                                        SizedBox(
                                          height: AppSize(context).pixels(10),
                                        ),
                                        Text(
                                          context.l10n.uploadImage,
                                          style: TextStyle(
                                            color: const Color(0xff080816)
                                                .withOpacity(
                                              0.38,
                                            ),
                                            fontWeight: FontWeight.w400,
                                            fontSize:
                                                AppSize(context).pixels(14),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: AppSize(context).pixels(15)),
                          CodaTextFormField(
                            controller: _firstNameController,
                            validator: emptyFieldValidator,
                            hintText: context.l10n.firstName,
                          ),
                          SizedBox(height: AppSize(context).pixels(15)),
                          CodaTextFormField(
                            controller: _lastNameController,
                            validator: emptyFieldValidator,
                            hintText: context.l10n.lastName,
                          ),
                          SizedBox(height: AppSize(context).pixels(15)),
                          CodaTextFormField(
                            inputType: TextInputType.emailAddress,
                            controller: _emailController,
                            validator: validateEmail,
                            hintText: context.l10n.emailAddress,
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(null);
                                },
                                child: Text(
                                  context.l10n.cancel,
                                  style: TextStyle(
                                    color: const Color(0xff080816)
                                        .withOpacity(0.38),
                                    fontSize: AppSize(context).pixels(14),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              CodaButton(
                                onPressed: submit,
                                height: AppSize(context).pixels(40),
                                width: AppSize(context).pixels(160),
                                title: context.l10n.save,
                              )
                            ],
                          ),
                          SizedBox(height: AppSize(context).pixels(15)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void submit([dynamic _]) {
    final validForm = _formKey.currentState?.validate();
    FocusScope.of(context).requestFocus(FocusNode());
    if (validForm ?? false) {
      final client = Client(
        id: widget.client?.id,
        email: _emailController.text,
        firstname: _firstNameController.text,
        lastname: _lastNameController.text,
      );
      Navigator.of(context).pop(client);
    }
  }
}

import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_coda/common/app_size.dart';
import 'package:test_coda/common/widgets/coda_button.dart';
import 'package:test_coda/l10n/l10n.dart';
import 'package:test_coda/login/widgets/coda_text_form_field.dart';

class AddNewClientModal extends StatefulWidget {
  const AddNewClientModal({super.key});

  @override
  State<AddNewClientModal> createState() => _AddNewClientModalState();
}

class _AddNewClientModalState extends State<AddNewClientModal> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppSize(context).pixels(10),
        ),
      ),
      content: Container(
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
                context.l10n.addNewClient,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: AppSize(context).pixels(18),
                ),
              ),
            ),
            SizedBox(height: AppSize(context).pixels(20)),
            Center(
              child: Container(
                width: AppSize(context).pixels(120),
                height: AppSize(context).pixels(120),
                alignment: Alignment.center,
                decoration: DottedDecoration(
                  shape: Shape.circle,
                  color: const Color(0xffE4F353),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/landscape.svg',
                      height: AppSize(context).pixels(32),
                    ),
                    SizedBox(height: AppSize(context).pixels(10)),
                    Text(
                      context.l10n.uploadImage,
                      style: TextStyle(
                        color: const Color(0xff080816).withOpacity(0.38),
                        fontWeight: FontWeight.w400,
                        fontSize: AppSize(context).pixels(14),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: AppSize(context).pixels(15)),
            CodaTextFormField(
              controller: _firstNameController,
              validator: (value, _) => '',
              onChanged: () {},
              hintText: context.l10n.firstName,
            ),
            SizedBox(height: AppSize(context).pixels(15)),
            CodaTextFormField(
              controller: _lastNameController,
              validator: (value, _) => '',
              onChanged: () {},
              hintText: context.l10n.lastName,
            ),
            SizedBox(height: AppSize(context).pixels(15)),
            CodaTextFormField(
              controller: _emailController,
              validator: (value, _) => '',
              onChanged: () {},
              hintText: context.l10n.emailAddress,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    context.l10n.cancel,
                    style: TextStyle(
                      color: const Color(0xff080816).withOpacity(0.38),
                      fontSize: AppSize(context).pixels(14),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                CodaButton(
                  padding: EdgeInsets.symmetric(
                    vertical: AppSize(context).pixels(12),
                  ),
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
  }
}

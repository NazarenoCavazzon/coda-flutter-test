import 'package:flutter/material.dart';
import 'package:test_coda/client/models/client.dart';
import 'package:test_coda/client/widgets/add_new_modal.dart';
import 'package:test_coda/common/app_size.dart';

class ClientTile extends StatelessWidget {
  const ClientTile({super.key, required this.client});
  final Client client;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: AppSize(context).pixels(16),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: AppSize(context).pixels(15),
        vertical: AppSize(context).pixels(20),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(),
        borderRadius: BorderRadius.circular(
          AppSize(context).pixels(20),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            height: AppSize(context).pixels(50),
            width: AppSize(context).pixels(50),
            child: CircleAvatar(
              child: Image.network(
                client.photo ?? '',
                height: AppSize(context).pixels(50),
                width: AppSize(context).pixels(50),
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.person,
                    size: AppSize(context).pixels(
                      50,
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            width: AppSize(context).pixels(16),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${client.firstname} ${client.lastname}',
                style: TextStyle(
                  color: const Color(0xff0D0D0D),
                  fontSize: AppSize(context).pixels(14),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                client.email ?? '',
                style: TextStyle(
                  color: const Color(0xff434545),
                  fontSize: AppSize(context).pixels(12),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              showDialog<void>(
                barrierColor: Colors.transparent,
                context: context,
                builder: (BuildContext innerContext) {
                  return AddNewClientModal();
                },
              );
            },
            icon: const Icon(
              Icons.more_vert,
            ),
          ),
        ],
      ),
    );
  }
}

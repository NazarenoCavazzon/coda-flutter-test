import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_coda/client/bloc/client_bloc.dart';
import 'package:test_coda/client/models/client.dart';
import 'package:test_coda/client/widgets/client_modal.dart';
import 'package:test_coda/common/app_size.dart';
import 'package:test_coda/l10n/l10n.dart';
import 'package:text_scroll/text_scroll.dart';

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
          SizedBox(
            width: AppSize(context).pixels(170),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextScroll(
                  '${client.firstname} ${client.lastname}',
                  velocity: const Velocity(
                    pixelsPerSecond: Offset(25, 0),
                  ),
                  delayBefore: const Duration(milliseconds: 500),
                  style: TextStyle(
                    color: const Color(0xff0D0D0D),
                    fontSize: AppSize(context).pixels(14),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextScroll(
                  client.email ?? '',
                  velocity: const Velocity(
                    pixelsPerSecond: Offset(25, 0),
                  ),
                  delayBefore: const Duration(milliseconds: 500),
                  style: TextStyle(
                    color: const Color(0xff434545),
                    fontSize: AppSize(context).pixels(12),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          PopupMenuButton(
            color: Colors.black,
            onSelected: (PopUpOptions option) async {
              if (option == PopUpOptions.edit) {
                await showDialog<Client?>(
                  barrierColor: Colors.transparent,
                  context: context,
                  builder: (BuildContext innerContext) {
                    return ClientModal(
                      client: client,
                    );
                  },
                ).then((client) {
                  if (client != null) {
                    context.read<ClientBloc>().editClient(client);
                  }
                });
              } else {
                context.read<ClientBloc>().deleteClient(client);
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem<PopUpOptions>(
                height: AppSize(context).pixels(35),
                padding: EdgeInsets.symmetric(
                  horizontal: AppSize(context).pixels(20),
                ),
                value: PopUpOptions.edit,
                child: Text(
                  context.l10n.edit,
                  style: TextStyle(
                    fontSize: AppSize(context).pixels(14),
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              PopupMenuItem<PopUpOptions>(
                height: AppSize(context).pixels(30),
                padding: EdgeInsets.symmetric(
                  horizontal: AppSize(context).pixels(20),
                ),
                value: PopUpOptions.delete,
                child: Text(
                  context.l10n.delete,
                  style: TextStyle(
                    fontSize: AppSize(context).pixels(14),
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

enum PopUpOptions {
  edit,
  delete,
}

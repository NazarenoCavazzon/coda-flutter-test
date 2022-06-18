import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_coda/client/bloc/client_bloc.dart';
import 'package:test_coda/client/models/client.dart';
import 'package:test_coda/client/widgets/client_modal.dart';
import 'package:test_coda/client/widgets/client_tile.dart';
import 'package:test_coda/common/app_size.dart';
import 'package:test_coda/common/box_keys.dart';
import 'package:test_coda/common/widgets/background_paint.dart';
import 'package:test_coda/common/widgets/coda_button.dart';
import 'package:test_coda/common/widgets/coda_snackbar.dart';
import 'package:test_coda/l10n/l10n.dart';
import 'package:test_coda/login/view/login_page.dart';

class PageClient extends StatelessWidget {
  const PageClient({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ClientBloc(),
      child: const ViewClient(),
    );
  }
}

class ViewClient extends StatefulWidget {
  const ViewClient({super.key});

  @override
  State<ViewClient> createState() => _ViewClientState();
}

class _ViewClientState extends State<ViewClient> {
  int clientsShowed = 5;
  bool noMoreClients = false;
  List<Client> clients = [];
  String query = '';

  @override
  void initState() {
    super.initState();
    context.read<ClientBloc>().loadClients();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Stack(
          children: [
            Blur(
              blur: 20,
              blurColor: Colors.white.withOpacity(0.5),
              child: Stack(
                children: const [
                  BackgroundPaint(
                    svg: 'assets/top-left-vector.svg',
                    alignment: Alignment.topLeft,
                  ),
                  BackgroundPaint(
                    svg: 'assets/center-right-vector.svg',
                    alignment: Alignment.centerRight,
                  ),
                  BackgroundPaint(
                    svg: 'assets/bottom-right-vector.svg',
                    alignment: Alignment.bottomRight,
                  ),
                  BackgroundPaint(
                    svg: 'assets/bottom-left-vector.svg',
                    alignment: Alignment.bottomLeft,
                  ),
                ],
              ),
            ),
            BlocConsumer<ClientBloc, ClientState>(
              listener: (context, state) {
                if (state.isSuccesful) {
                  setState(() {
                    clients = state.clients;
                  });
                }
                if (state.cudStatus == ClientCudStatus.createdSuccessfully) {
                  context.read<ClientBloc>().initialClient();
                  const CodaSnackbar.success(message: 'Success').show(context);
                } else if (state.cudStatus ==
                    ClientCudStatus.updatedSuccessfully) {
                  context.read<ClientBloc>().initialClient();
                  const CodaSnackbar.success(message: 'Updated').show(context);
                } else if (state.cudStatus == ClientCudStatus.failure) {
                  context.read<ClientBloc>().initialClient();
                  const CodaSnackbar.error(message: 'Error').show(context);
                }
              },
              builder: (context, state) {
                return SafeArea(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                      top: AppSize(context).pixels(32),
                      left: AppSize(context).pixels(36),
                      right: AppSize(context).pixels(36),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Align(
                              child: Image.asset(
                                'assets/login-title.png',
                                width: AppSize(context).pixels(120),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                onPressed: () {
                                  Hive.box<dynamic>(BoxKeys.token).clear();
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute<void>(
                                      builder: (context) => const PageLogin(),
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.logout,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppSize(context).pixels(32)),
                        Text(
                          context.l10n.clients,
                          style: TextStyle(
                            fontSize: AppSize(context).pixels(20),
                            fontWeight: FontWeight.w700,
                            color: const Color(0xff434545),
                          ),
                        ),
                        SizedBox(height: AppSize(context).pixels(24)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: AppSize(context).pixels(42),
                              width: AppSize(context).pixels(220),
                              child: TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    query = value;
                                    if (value.isEmpty) {
                                      clients = state.clients;
                                    } else {
                                      clients = state.clients
                                          .where(
                                            (client) =>
                                                (client.firstname ?? '')
                                                    .toLowerCase()
                                                    .contains(
                                                      value.toLowerCase(),
                                                    ) ||
                                                (client.lastname ?? '')
                                                    .toLowerCase()
                                                    .contains(
                                                      value.toLowerCase(),
                                                    ) ||
                                                (client.email ?? '')
                                                    .toLowerCase()
                                                    .contains(
                                                      value.toLowerCase(),
                                                    ),
                                          )
                                          .toList();
                                    }
                                    if (clients.length > 5) {
                                      clientsShowed = 5;
                                      noMoreClients = false;
                                    } else {
                                      clientsShowed = clients.length;
                                      noMoreClients = true;
                                    }
                                  });
                                },
                                decoration: InputDecoration(
                                  hintText: '${context.l10n.search}...',
                                  fillColor: Colors.white,
                                  filled: true,
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    color: Color(0xff434545),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: AppSize(context).pixels(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black.withOpacity(0.75),
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      AppSize(context).pixels(70),
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          const Color(0xff1F1D2B).withOpacity(
                                        0.61,
                                      ),
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      AppSize(context).pixels(70),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            CodaButton(
                              height: AppSize(context).pixels(30),
                              width: AppSize(context).pixels(95),
                              title: context.l10n.addNew,
                              onPressed: () async {
                                await showDialog<Client?>(
                                  barrierColor: Colors.transparent,
                                  context: context,
                                  builder: (BuildContext innerContext) {
                                    return const ClientModal();
                                  },
                                ).then((client) {
                                  if (client != null) {
                                    context
                                        .read<ClientBloc>()
                                        .createClient(client);
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                        BlocConsumer<ClientBloc, ClientState>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            if (state.isSuccesful ||
                                state.isLoadingMoreClients) {
                              return ClientListWidget(
                                clients: clients,
                                clientsShowed: clientsShowed,
                                state: state,
                                noMoreClients: noMoreClients,
                                onPressed: () {
                                  if (clientsShowed + 5 >= clients.length) {
                                    if (state.isLastPage || query.isEmpty) {
                                      setState(() {
                                        clientsShowed = clients.length;
                                        noMoreClients = true;
                                      });
                                    } else {
                                      context
                                          .read<ClientBloc>()
                                          .loadMoreClients();
                                      setState(() {
                                        clientsShowed += 5;
                                      });
                                    }
                                  } else {
                                    setState(() {
                                      clientsShowed += 5;
                                    });
                                  }
                                },
                              );
                            } else if (state.isFailure) {
                              return Expanded(
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        context.l10n.randomError,
                                        style: TextStyle(
                                          fontSize: AppSize(context).pixels(20),
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xff434545),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          context
                                              .read<ClientBloc>()
                                              .loadClients();
                                        },
                                        child: Text(context.l10n.retry),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                            return const Expanded(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ClientListWidget extends StatelessWidget {
  const ClientListWidget({
    super.key,
    this.onPressed,
    this.noMoreClients = false,
    required this.clientsShowed,
    required this.state,
    required this.clients,
  });
  final int clientsShowed;
  final ClientState state;
  final List<Client> clients;
  final bool noMoreClients;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    if (clients.isEmpty) {
      return Expanded(
        child: Center(
          child: Text(
            context.l10n.noClientsFound,
            style: TextStyle(
              fontSize: AppSize(context).pixels(20),
              fontWeight: FontWeight.w700,
              color: const Color(0xff434545),
            ),
          ),
        ),
      );
    }
    return Expanded(
      child: RefreshIndicator(
        color: Colors.black,
        onRefresh: () async {
          context.read<ClientBloc>().loadClients();
        },
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: clientsShowed + 1,
          itemBuilder: (context, index) {
            if (index == clientsShowed && !noMoreClients) {
              return Container(
                margin: EdgeInsets.symmetric(
                  vertical: AppSize(context).pixels(16),
                ),
                child: CodaButton(
                  onPressed: onPressed,
                  height: AppSize(context).pixels(52),
                  width: MediaQuery.of(context).size.width * 0.7,
                  title: context.l10n.loadMore,
                ),
              );
            }
            try {
              return ClientTile(
                client: clients[index],
              );
            } catch (_) {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}

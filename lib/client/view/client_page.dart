import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_coda/client/bloc/client_bloc.dart';
import 'package:test_coda/client/widgets/client_tile.dart';
import 'package:test_coda/common/app_size.dart';
import 'package:test_coda/common/widgets/background_paint.dart';
import 'package:test_coda/common/widgets/coda_button.dart';
import 'package:test_coda/l10n/l10n.dart';

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
            SafeArea(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  vertical: AppSize(context).pixels(32),
                  horizontal: AppSize(context).pixels(36),
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/login-title.png',
                          width: AppSize(context).pixels(120),
                        ),
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
                                    color: const Color(0xff1F1D2B).withOpacity(
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
                            padding: EdgeInsets.symmetric(
                              vertical: AppSize(context).pixels(8),
                            ),
                            width: AppSize(context).pixels(95),
                            title: context.l10n.addNew,
                            onPressed: () {},
                          ),
                        ],
                      ),
                      BlocConsumer<ClientBloc, ClientState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          if (state.isSuccesful) {
                            return Column(
                              children: [
                                ...state.clients
                                    .map(
                                      (client) => ClientTile(client: client),
                                    )
                                    .toList()
                              ],
                            );
                          }
                          return const Text('Loading');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

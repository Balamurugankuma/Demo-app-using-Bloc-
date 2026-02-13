import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_1/Features/home/presentation/view/notification_tab.dart';
import 'package:project_1/Features/home/presentation/view/search_tab.dart';
import '../viewmodel/home_bloc.dart';
import '../viewmodel/home_event.dart';
import '../viewmodel/home_state.dart';
import 'app_drawer.dart';
import 'home_tab.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => HomeBloc(), child: const _HomeView());
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "I am Home page !",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          drawer: const AppDrawer(),

          body: IndexedStack(
            index: state.currentIndex,

            children: const [HomeTab(), SearchTab(), NotificationTab()],
          ),

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.currentIndex,
            onTap: (index) {
              context.read<HomeBloc>().add(ChangeTabEvent(index));
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: "Search",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: "Notification",
              ),
            ],
          ),
        );
      },
    );
  }
}

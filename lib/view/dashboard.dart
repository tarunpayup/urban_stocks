import 'package:flutter/material.dart';
import 'package:stock_market/models/user_model.dart';
import 'package:stock_market/viewmodel/dashboard_viewmodel.dart';

class Dashboard extends StatefulWidget{
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>{
  DashboardViewModel viewModel = DashboardViewModel(); //Object

  Future<void> loadData() async{
    setState(() {
      viewModel.isLoading = true;      
    });

    await viewModel.loadUsers();

    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('Dashboard'),
      ),

      body: Column(

        children: [

          const SizedBox(height: 20),

          // API BUTTON
          ElevatedButton(

            onPressed: loadData,

            child: const Text(
              'Call API',
            ),

          ),

          const SizedBox(height: 20),

          // LOADING
          if (viewModel.isLoading)

            const CircularProgressIndicator(),

          // ERROR
          if (viewModel.errorMessage.isNotEmpty)

            Text(
              viewModel.errorMessage,
              style: const TextStyle(
                color: Colors.red,
              ),
            ),

          // LIST
          Expanded(

            child: ListView.builder(

              itemCount: viewModel.users.length,

              itemBuilder: (context, index) {

                UserModel user =
                    viewModel.users[index];

                return ListTile(

                  leading: CircleAvatar(
                    child: Text(
                      user.id.toString(),
                    ),
                  ),

                  title: Text(
                    user.name,
                  ),

                  subtitle: Text(
                    user.email,
                  ),

                );

              },

            ),

          ),

        ],

      ),

    );

  }
}
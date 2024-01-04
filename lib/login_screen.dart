import 'package:flutter/material.dart';
import 'dashboard.dart'; // Make sure to import the correct file
import 'register_screen.dart'; // Import the register_screen.dart file

class LoginScreen extends StatelessWidget {
  // Controllers for email and password text fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.blue, // Set app bar background color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Logo above the email field
              Image.asset(
                'logoku.jpg', // Replace with the path to your logo image
                height: 80, // Adjust the height as needed
              ),
              SizedBox(height: 16), // Add some spacing

              // Login form with email and password fields
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email), // Add email icon
                ),
              ),
              SizedBox(height: 16), // Add some spacing

              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock), // Add lock icon
                ),
              ),
              SizedBox(height: 24), // Add some spacing

              // "Login" button
              ElevatedButton(
                onPressed: () {
                  // Perform login authentication, and if successful, navigate to the dashboard
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => DashboardPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue, // Set button background color
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),

              SizedBox(height: 20), // Add some spacing

              // Button to navigate to the RegisterScreen
              TextButton(
                onPressed: () {
                  // Navigate to the RegisterScreen when the "Register" button is pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                },
                child: Text(
                  'Don\'t have an account? Register',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              // Add other UI elements if needed
            ],
          ),
        ),
      ),
    );
  }
}

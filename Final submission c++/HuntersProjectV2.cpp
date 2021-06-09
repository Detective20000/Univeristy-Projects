//============================================================================
// Name        : MohanadProject.cpp
// Author      : Hunters by Mahanad, .....
// Version     : Final
// Copyright   : This project built for EOP subject as a semester project
// Description : A guess game built for EOP project in C++, Ansi-style
//============================================================================

#include <iostream>
#include <sstream>
#include <cstdlib>
#include "UserHandler.h"
#include "GameOfColors.h"
#include "ScoreHandler.h"

using namespace std;

string username;  // the username to sign in / up with
string password;  // the password to sign in / up with

int signIn();

int main() {
	int signInState = signIn();
	// user failed to obtain username and password, so force user to exit
	if (signInState == 1) {
		string temp;
		cout << "Press enter to exit";
		cin >> temp;
		return 0;
	}
	string playAgain = "y"; // play again initiated as 'y' so automatically the game will start
	// every time the user will enter 'y' the game will restart
	while (playAgain == "y" || playAgain == "Y") {
		// start the game
		start(username);
		cout << "Would you like to play again ('y' or anything for no)";
		cin >> playAgain;
	}
	return 0;
}

int signIn() {
	int is = 2; // initiate as if the information is wrong so the user has to enter it
	// as long as the username and password do not match keep looping and asking user for the correct username and password
	while (is == 2) {
		cout << "Please enter your username: ";
		cin >> username;  // get username from user
		cout << "Please enter your password: ";
		cin >> password;  // get password from user
		// check the information entered
		is = signIn(username, password);
		// if username does not exist
		if (is == 0) {
			// ask user whether they want to register a new account
			cout << "We could not find your account! Would you like to sign up with these details?";
			cout << endl;
			cout << "type 'y' or 'Y' for yes or anything else for no: ";
			string yes;
			cin >> yes; // get user response
			// if user want to register then sign up
			if (yes == "y" || yes == "Y") {
				// append new user with password to the users file
				signUp(username, password);
			} else {
				// stop here
				system("CLS");
				// thank the user
				cout << "Thank you for stopping by!";
				// return a state of 1 to differentiate it from the normal state
				return 1;
			}
		}
		else if (is == 1) {
			// here where both username and password matches
			// could be used later
		}
		else if (is == 2) {
			// tell user that the password was wrong
			cout << "You have entered wrong password. Please try again!" << endl;
		}
	}
	// standard state whereby the game will start
	return 0;
}

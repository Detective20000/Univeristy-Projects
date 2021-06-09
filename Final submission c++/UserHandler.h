/*
 * UserHandler.h
 *
 *  Created on: May 8, 2018
 *      Author: Hunters
 */

#include <iostream>
#include <fstream>
using namespace std;

int signIn(string username, string password) {
	string userDetails = username + "," + password;
	username += ",";
	fstream file;
	file.open("users.csv", ios::in | ios::out | ios::app);
	if (!file.is_open()) return 0;
	while (!file.eof()) {
		string line;
		getline(file, line);
		if (line.find(username) != std::string::npos && line.find(username) == 0) {
			if (userDetails == line) {
				return 1;
			}
			else {
				return 2;
			}
		}
	}
	return 0;
}

bool isUserExist(string username) {
	username += ",";
	fstream file;
	file.open("users.csv", ios::in | ios::out | ios::app);
	if (!file.is_open()) return NULL;
	while (!file.eof()) {
		string line;
		getline(file, line);
		if (line.find(username) != std::string::npos && line.find(username) == 0) {
			return true;
		}
	}
	return false;
}

void signUp(string username, string password) {
	string toBeAppended = username + "," + password;
	toBeAppended = "\n" + toBeAppended;
	fstream file;
	file.open("users.csv", ios::in | ios::out | ios::app);
	if (!file.is_open()) return;
	file << toBeAppended;
	file.close();
}

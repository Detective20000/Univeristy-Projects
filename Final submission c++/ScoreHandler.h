/*
 * UserHandler.h
 *
 *  Created on: May 8, 2018
 *      Author: Hunters
 */

#include <iostream>
#include <fstream>
using namespace std;

// 3 for top 3
const int topN = 3;

float getTotalScore(string username);
void addScore(string username, float score);
string* getTopScores(string username);
string* sortScores(string username, string* players, float* scores);

float getTotalScore(string username) {
	float score = 0.0;
	int hits = 0.0;
	username += ",";
	fstream file;
	file.open("scores.csv", ios::in | ios::out | ios::app);
	if (!file.is_open()) return 0.0;
	while (!file.eof()) {
		string line;
		getline(file, line);
		if (line.find(username) != std::string::npos && line.find(username) == 0) {
			int from = line.find(",");
			from += 1;
			string temp = line.substr(from);
			score += stof(temp, 0);
			hits++;
		}
	}
	return score / hits;
}

void addScore(string username, float score) {
	string toBeAppended = username + "," + to_string(score);
	toBeAppended = "\n" + toBeAppended;
	fstream file;
	file.open("scores.csv", ios::in | ios::out | ios::app);
	if (!file.is_open()) return;
	file << toBeAppended;
	file.close();
}

string* getTopScores(string username) {
	string players = "";
	string scores = "";
	//
	//
	fstream file;
	file.open("users.csv", ios::in | ios::out | ios::app);
	if (!file.is_open()) {
		string *failed;
		failed = new string[1];
		failed[0] = "FAILED";
		return failed;
	}
	int counter = 0;
	while (!file.eof()) {
		string line;
		getline(file, line);
		if (line.find(",") != std::string::npos) {
			string username = line.substr(0, line.find(","));
			players += username + ",";
			scores += to_string(getTotalScore(username)) + ",";
		}
		counter++;
	}
	players = players.substr(0, players.length() - 1);
	scores = scores.substr(0, scores.length() - 1);
	//
	//
	string *arrayPlayers;
	arrayPlayers = new string[counter + 1];
	arrayPlayers[0] = to_string(counter);
	float *arrayScores;
	arrayScores = new float[counter + 1];
	arrayScores[0] = counter;
	//
	//
	for (int index = 1 ; index < counter + 1 ; index++) {
		if (players.find(",") == std::string::npos) {
			arrayPlayers[index] = players;
			arrayScores[index] = stof(scores, 0);
			//
			// test
			//cout << arrayPlayers[index] << "\t" << arrayScores[index] << endl;
			break;
		}
		else {
			string line;
			int indexOfCommaInPlayers = players.find(",");
			line = players.substr(0, indexOfCommaInPlayers);
			arrayPlayers[index] = line;
			players = players.substr(indexOfCommaInPlayers + 1);
			//
			//
			int indexOfCommaInScores = scores.find(",");
			line = scores.substr(0, indexOfCommaInScores);
			arrayScores[index] = stof(line, 0);
			scores = scores.substr(indexOfCommaInScores + 1);
			//
			// test
			//cout << arrayPlayers[index] << "\t" << arrayScores[index] << endl;
		}
	}
	string *array;
	array = sortScores(username, arrayPlayers, arrayScores);
	return array;
}

string* sortScores(string username, string* players, float* scores) {
	int lastIndex = scores[0];
	for (int i = 1 ; i < lastIndex - 1 ; i++) {
		for (int j = i + 1 ; j < lastIndex ; j++) {
			if (scores[j] > scores[i]) {
				string tempP = "" + players[i];
				players[i] = "" + players[j];
				players[j] = "" + tempP;
				//
				//
				float tempS = 0 + scores[i];
				scores[i] = 0 + scores[j];
				scores[j] = 0 + tempS;
			}
		}
	}
	string *array;
	array = new string[lastIndex + 1];
	array[0] = to_string(lastIndex);
	bool isInTopN = false;
	for (int i = 1 ; i < lastIndex ; i++) {
		if (i <= topN) {
			array[i] = to_string(i) + "- " + players[i] + " with total score of " + to_string(scores[i]);
			if (username == players[i]) {
				isInTopN = true;
			}
		}
		else if (isInTopN) {
			break;
		}
		else if (username == players[i]) {
			array[topN + 1] = to_string(i) + "- " + players[i] + " with total score of " + to_string(scores[i]);
		}
	}
	return array;
}

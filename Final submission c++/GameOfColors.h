/*
 * GameOfColors.h
 *
 *  Created on: May 8, 2018
 *      Author: Hunters
 */

#include <iostream>
#include <ctime>
#include <cmath>
#include <Windows.h>
using namespace std;

const int length = 5;

string colorsOriginalOrder[length] = { "Blue", "Green", "Red", "Pink", "Yellow" };
string colorsShuffled[length] = { "Blue", "Green", "Red", "Pink", "Yellow" };

void shuffle();
void setConsoleColor(string color);
void printDisplayColors();
void printArrayOfColors(string colors[]);
int getIntOfString(string strInt);
//
//
void addScore(string username, float score);
float getTotalScore(string username);
string* getTopScores(string username);

void start(string username) {
	int mistakes = 0;
	string colorsUserInput[length] = { "", "", "", "", "" };
	shuffle(); // shuffle the colors
	shuffle(); // shuffle again to make sure the colors been shuffled fair enough
	printDisplayColors();
	int at = 0;
	while (at < length) {
		string colorGuess;
		cin >> colorGuess;
		if (colorsShuffled[at] == colorGuess) {
			colorsUserInput[at] = colorGuess;
			at++;
		}
		else {
			printDisplayColors();
			cout << "Your guess was wrong, try again and remember your entries are:" << endl;
			printArrayOfColors(colorsUserInput);
			mistakes++;
		}
	}
	int total = 5 + mistakes;
	float score = 5.0 / total;
	score *= 100;
	cout << "Your score for this attempt is " << score << "%" << endl;
	addScore(username, score);
	float totalScore = getTotalScore(username);
	cout << "Your total score is " << totalScore << "%" << endl;
	string *array;
	array = getTopScores(username);
	int indexOfEnd = getIntOfString(array[0]);
	int onlyTop = 4;
	for (int i = 1 ; i <= onlyTop ; i++) {
		cout << array[i] << endl;
	}
}

void shuffle() {
	srand(time(0)); // initial randomness
	int indexes [length] = {-1, -1, -1, -1, -1}; // initiate random indexes to shuffle the colors
	int generated = 0; // counting the number of random indexes generated
	while (generated < length) { // as long as the the system did not generate all required indexes it must keep looping
		int random = ceil(rand() % length); // get random number with maximum of 4 and minimum of 0
		if (generated == 0) { // for the first index whatever the generated index is we will accept
			indexes[generated] = random; // assign the generated index and go on
			generated++; // increment the counter of generated indexes
			continue; // go next iteration if possible
		}
		else { // since it is not the first index
			bool hasBeenUsed = false; // keep track whether the generated number been used or not
			for (int index = 0 ; index < generated ; index++) { // iterate from index 0 till the current counter -1
				if (indexes[index] == random) { // if this random been used
					hasBeenUsed = true; // update the tracker and break
					break;
				}
			}
			if (!hasBeenUsed) { // if the tracker says the random not been used
				indexes[generated] = random; // assign the generated index and go on
				generated++; // increment the counter of generated indexes
				continue; // go next iteration if possible
			}
		}
	}
	// generate temporary array to hold the new data
	string temp[length] = { "Blue", "Green", "Red", "Pink", "Yellow" };
	for (int index = 0 ; index < length ; index++) {
		// assign the colors into new positions
		temp[index] = colorsShuffled[indexes[index]];
	}
	for (int index = 0 ; index < length ; index++) {
		// set the global colors to hold the new positions
		colorsShuffled[index] = temp[index];
	}
}

void setConsoleColor(string color) {
	string colors[] = {"Blue","Green","Red","Pink","Yellow", "Black"};
	int colorIndex = -1;
	for (int index = 0 ; index < 6 ; index++) {
		if (colors[index] == color) {
			colorIndex = index;
			break;
		}
	}
	HANDLE console = GetStdHandle(STD_OUTPUT_HANDLE); // required for SetConsoleTextAttribute()
	// depends on the color requested the console will prepare the needed colors
	switch (colorIndex) {
		case 0: //Blue
			SetConsoleTextAttribute(console,9); // set color for the next print #rgb
			break;
		case 1: //Green
			SetConsoleTextAttribute(console,10); // set color for the next print #rgb
			break;
		case 2: //Red
			SetConsoleTextAttribute(console,12); // set color for the next print #rgb
			break;
		case 3: //Pink
			SetConsoleTextAttribute(console,13); // set color for the next print #rgb
			break;
		case 4: //Yellow
			SetConsoleTextAttribute(console,14); // set color for the next print #rgb
			break;
		case 5: // Black
		default:
			SetConsoleTextAttribute(console, 7); // to return to the original color to black background, white chars
			break;
	}
}

void printDisplayColors() {
	system("CLS");
	cout << "We will Give you 5 colors." << endl;
	cout << "You will have to guess how is the correct arrangement." << endl;
	cout << "If you guess all the colors in the correct position you win." << endl;
	printArrayOfColors(colorsOriginalOrder);
}

void printArrayOfColors(string colors[]) {
	// to display the colors that user have to arrange
	for(int i = 0; i < length; i++){
		// ask this function to prepare the required color for the console depending of the color passed
		setConsoleColor(colors[i]);
		// to print the name of the color with it color
		cout << colors[i] << "\t";
		// pause between strings
		Sleep(250);
	}
	setConsoleColor("Black");
	cout << endl;
}

int getIntOfString(string strInt) {
	stringstream geek(strInt);
	int x = 0;
	geek >> x;
	return x;
}

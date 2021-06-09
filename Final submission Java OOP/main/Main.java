package main;

import java.util.Scanner;

import games.GuessColorGame;
import games.GuessJobGame;
import games.GuessNumberGame;

public class Main {
	static Scanner input = new Scanner(System.in);
	
	public static boolean IS_NEW = true;
	
	public static final String NEW_LINE = "\n";
	public static final String OPTION_1 = "1: To play guess the color";
	public static final String OPTION_2 = "2 :To play guess the number";
	public static final String OPTION_3 = "3: To play guess the job";
	public static final String OPTION_5 = "5: To exit";
	
	public static void main(String[] args) {
		
		int choice = 0;
		
		while(choice != 4) {
			
			System.out.print(
				"Please choose one of the following options" + NEW_LINE
				+ OPTION_1 + NEW_LINE
				+ OPTION_2 + NEW_LINE
				+ OPTION_3 + NEW_LINE
				+ OPTION_5 + NEW_LINE
				+ "Type your option: "
			);
			
			choice = input.nextInt();
			
			if (choice == 5) {
				input.close();
				System.out.println("Thank you for using our system.");
				break;
			}
			
			switch (choice) {
				case 1:
					GuessColorGame guessColorGame = new GuessColorGame();
					guessColorGame.start();
					break;
				case 2:
					GuessNumberGame guessNumberGame = new GuessNumberGame();
					guessNumberGame.start();
//					guessNumberGame.start(minimum, maximum);
					break;
				case 3:
					GuessJobGame guessJobGame = new GuessJobGame();
					guessJobGame.start();
					break;
				default:
					System.out.println("Sorry, you have entered an invalid value. Please try again!");
			}
			
			IS_NEW = false;
		}
	}
}

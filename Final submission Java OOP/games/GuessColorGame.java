package games;

import java.util.Scanner;

import main.Values;

public class GuessColorGame {

	Scanner input = new Scanner(System.in);

	private String[] shuffledColors = Values.COLORS.clone();

	private String[] typedColors = new String[Values.COLORS.length];
	private int currentPosition = 0;

	@SuppressWarnings("unused")
	private int attempts;

	public void start() {
		initializeGame();
		takeInput();
	}

	private void initializeGame() {
		this.attempts = 0;
		shuffle();
		shuffle();
	}

	private void shuffle() {
		for (int index = 0; index < shuffledColors.length; index++) {
			int random = (int) (Math.random() * shuffledColors.length);
			String temp = shuffledColors[index];
			shuffledColors[index] = shuffledColors[random];
			shuffledColors[random] = temp;
		}
	}

	private void takeInput() {
		System.out.flush();
		System.out.println("Guess the correct order of the colors: ");

		for (String color : Values.COLORS) {
			System.out.print(color + " ");
		}
		System.out.println();
		
		String guess = "";
		
		while (this.currentPosition != Values.COLORS.length) {
			guess = input.next();
			if (guess.equals(this.shuffledColors[this.currentPosition])) {
				this.typedColors[this.currentPosition] = guess;
				this.currentPosition++;
			} else {
				this.attempts++;
				System.out.println("Sorry, wrong answer. Try again.");
			}
		}
	}

}

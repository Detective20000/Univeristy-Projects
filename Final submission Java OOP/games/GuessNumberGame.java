package games;

import java.util.Scanner;

public class GuessNumberGame {

	Scanner input = new Scanner(System.in);

	private int minimum = 0;
	private int maximum = 100;

	private int hiddenNumber;
	private int attempts;
	
	private static final int MAX_ATTEMPTS = 5;

	public void start() {
		initializeGame();
		takeInput();
	}

	public void start(int minimum, int maximum) {
		this.minimum = minimum;
		this.maximum = maximum;
		start();
	}

	private void initializeGame() {
		this.hiddenNumber = this.minimum + (int) (Math.random() * this.maximum);
		this.attempts = 0;
	}

	private void takeInput() {
		int guess = -1;
		while (this.attempts < MAX_ATTEMPTS) {
			System.out.flush();
			System.out.print("Guess the hidden number between " + minimum + " - " + maximum + ": ");
			guess = input.nextInt();
			if (guess != hiddenNumber) {
				this.attempts++;
				if (this.attempts >= MAX_ATTEMPTS) {
					System.out.println("Sorry, you lost. you can still try again!");
				} else if (guess > hiddenNumber) {
					System.out.println("Sorry, wrong answer. Try smaller number.");
				} else {
					System.out.println("Sorry, wrong answer. Try bigger number.");
				}
			} else {
				System.out.println("Good Job Correct Answer.");
				break;
			}
		}
	}
}

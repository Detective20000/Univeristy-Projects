package games;

import java.util.Scanner;

import classes.Job;
import main.Values;

public class GuessJobGame {

	Scanner input = new Scanner(System.in);

	private Job job;
	private int attempts;
	
	private static final int MAX_ATTEMPTS = 3;

	public void start() {
		initializeGame();
		takeInput();
	}

	private void initializeGame() {
		int random = 0 + (int) (Math.random() * Values.JOBS.length);
		this.job = Values.JOBS.clone()[random];
		this.attempts = 0;
	}

	private void takeInput() {
		String guess = "";
		while (this.attempts < MAX_ATTEMPTS) {
			System.out.flush();
			System.out.println(this.job.question);
			System.out.print("Please answer using small letters and no spaces: ");
			guess = input.next();
			if (guess.equals(this.job.answer)) {
				System.out.println("Good Job Correct Answer.");
				break;
			} else {
				this.attempts++;
				if (this.attempts >= MAX_ATTEMPTS) {
					System.out.println("Sorry, you lost. you can still try again!");
				} else {
					System.out.println("Sorry, wrong answer. Try again!");
					if (this.attempts == 1) {
						System.out.println(this.job.hint1);
					} else {
						System.out.println(this.job.hint2);
					}
				}
			}
		}
	}
}

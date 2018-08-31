package com.capgemini.thread;

public class Application {

	
	public static void main(String[] args) {
		//thread1(2);
		thread2(20);
	}
	
	private static void thread2(int loop) {
		System.out.println(Thread.currentThread().getName());
		for (int i = 0; i < loop; i++) {
			new Thread("" + i) {
				public void run() {
					System.out.println("Thread: " + getName() + " running");
				}
			}.start();
		}
	}

	private static void thread1(int loop) {
		Thread t1 = new Thread(new Runnable() {

			@Override
			public void run() {
				for (int i = 0; i < loop; i++) {
					System.out.println("Stuff 1" + Thread.currentThread().getName());
				}
			}
		});
		
		Thread t2 = new Thread(new Runnable() {

			@Override
			public void run() {
				for (int i=0; i < loop; i++) {
					System.out.println("Stuff 2" + Thread.currentThread().getName());
				}
			}
		});
		
		System.out.println("start");
		t1.start();
		t2.start();
		System.out.println("run");
		t1.run();
		t2.run();
	}
}

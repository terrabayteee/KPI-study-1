
public class Lab7 {
	final static byte[] ProducersNum = new byte[]{4};
	final static Thread[] Threads = new Thread[5];
	final static ResStack stack = new ResStack(1000, Threads);
	final static ResBasic basic = new ResBasic();

	public static void main(String[] args) {
		int j = 0;
		for (byte i = 0; i < 10; i++){
			stack.push(-1);
		}
		
		for (byte i = 0; i < Threads.length; i++){
			if (i == ProducersNum[j]){
				Threads[i] = new Thread(new Producer(i, stack, basic, Threads));
				if (j != ProducersNum.length){
					j++;
				}
			}
			else{
				Threads[i] = new Thread(new Consumer(i, stack, basic));
			}
		}
		
		for (byte i = 0; i < Threads.length; i++){
			Threads[Threads.length-1-i].start();
		}

		while(!stack.isStop());
		for (byte i = 0; i < Threads.length; i++){
				Threads[i].stop();
				//if (Threads[i].getState() == Thread.State.NEW)
					System.out.format("Thread %d stopped.\n", i);
		}

		System.out.format("All threads stopped\n", null);
/*
		j = 0;
		for (byte i = 0; i < 10; i++){
			stack.push(-1);
		}

		for (byte i = 0; i < Threads.length; i++){
			if (i == ProducersNum[j]){
				Threads[i] = new Thread(new Producer(i, stack, basic, Threads));
				if (j != ProducersNum.length){
					j++;
				}
			}
			else{
				Threads[i] = new Thread(new Consumer(i, stack, basic));
			}
		}
		for (byte i = 0; i < Threads.length; i++){
			Threads[Threads.length-1-i].start();
		}

		while(!stack.isStop());
		for (byte i = 0; i < Threads.length; i++){
				Threads[i].stop();
				//if (Threads[i].getState() == Thread.State.NEW)
					System.out.format("Thread %d stopped.\n", i);
		}*/
	}

}

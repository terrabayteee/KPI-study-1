
public class Producer extends LabSynchronize implements Runnable{
	private int Number;
	private ResStack CR1;
	private ResBasic CR2;
	private boolean run;
	private Thread[] Threads;

	public Producer(int number, ResStack s, ResBasic b, Thread[] t){
		Number = number;
		CR1 = s;
		CR2 = b;
		run = true;
		Threads = t;
	}
	
	@Override
	public void run() {
		System.out.format("Thread %d start.\n", Number);
		
		while(run){
			if (CR1.isStop()){
				continue;
			}
			if (Number == 1){
				try {
					Sem2.release();
					Sem1.acquire();
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if (Number == 2){
				try {
					Sem1.release();
					Sem2.acquire();
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			
			CR1.push(Number);
			
			if ((Number == 0)||(Number == 3)||(Number == 4)){
				Mutex.lock();
				System.out.format("Thread %d lock mutex.\n", Number);
				CR2.setValues(Number);
				System.out.format("Thread %d unlock mutex.\n", Number);
				Mutex.unlock();
			}
			try {
				Thread.sleep(100);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	public void setRunning(boolean r){
		run = r;
	}
}

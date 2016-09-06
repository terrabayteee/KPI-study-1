import java.util.concurrent.BrokenBarrierException;

public class Consumer extends LabSynchronize implements Runnable{
	private int Number;
	private ResStack CR1;
	private ResBasic CR2;
	private boolean run;
	
	public Consumer(int number, ResStack s, ResBasic b){
		Number = number;
		CR1 = s;
		CR2 = b;
		run = true;
	}

	@Override
	public void run() {
		System.out.format("Thread %d start.\n", Number);
		
		while(run){
			if (CR1.isStop()){
				continue;
			}
			//Semaphore synchronization
			if (Number == 1){
				try {
					System.out.format("Thread %d release Sem2.\n", Number);
					Sem2.release();
					System.out.format("Thread %d waiting Sem1.\n", Number);
					Sem1.acquire();
					System.out.format("Thread %d check Sem1.\n", Number);
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if (Number == 2){
				try {
					System.out.format("Thread %d release Sem1.\n", Number);
					Sem1.release();
					System.out.format("Thread %d waiting Sem2.\n", Number);
					Sem2.acquire();
					System.out.format("Thread %d check Sem2.\n", Number);
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			//Monitor synchronization
			/*if (CR1.isStop()){
				if ((Number == 0)||(Number == 1)){
					if (CB1.getNumberWaiting() != 0) try {
						System.out.format("Thread %d wait CB1.\n", Number);
						CB1.await();
						System.out.format("Thread %d check CB1.\n", Number);
					} catch (InterruptedException | BrokenBarrierException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				if ((Number == 2)||(Number == 3)){
					if (CB2.getNumberWaiting() != 0) try {
						System.out.format("Thread %d wait CB2.\n", Number);
						CB2.await();
						System.out.format("Thread %d check CB2.\n", Number);
					} catch (InterruptedException | BrokenBarrierException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}

				if (Number == 1){
					System.out.format("Thread %d release Sem2.\n", Number);
					Sem2.release();
				}
				if (Number == 2){
					System.out.format("Thread %d release Sem1.\n", Number);
					Sem1.release();
				}
				break;
			}*/

			CR1.pop(Number);
			
			if ((Number == 0)||(Number == 3)||(Number == 4)){
				Mutex.lock();
				System.out.format("Thread %d lock mutex.\n", Number);
				CR2.setValues(Number);
				System.out.format("Thread %d unlock mutex.\n", Number);
				Mutex.unlock();
			}
			try {
				Thread.sleep(10);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			//CycleBarrier synchronization
			if ((Number == 0)||(Number == 1)){
				try {
					System.out.format("Thread %d wait CB1.\n", Number);
					CB1.await();
				} catch (InterruptedException | BrokenBarrierException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if ((Number == 2)||(Number == 3)){
				try {
					System.out.format("Thread %d wait CB2.\n", Number);
					CB2.await();
				} catch (InterruptedException | BrokenBarrierException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
		}
		
		System.out.format("Thread %d stopped.\n", Number);
	}

	public void setRunning(boolean r){
		run = r;
	}
}

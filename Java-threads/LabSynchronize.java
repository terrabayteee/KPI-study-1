import java.util.concurrent.CyclicBarrier;
import java.util.concurrent.Semaphore;
import java.util.concurrent.locks.ReentrantLock;

public abstract class LabSynchronize {
	protected static final ReentrantLock Mutex = new ReentrantLock();
	protected static final Semaphore Sem1 = new Semaphore(0);
	protected static final Semaphore Sem2 = new Semaphore(0);
	protected static final CyclicBarrier CB1 = new CyclicBarrier(2);
	protected static final CyclicBarrier CB2 = new CyclicBarrier(2);
}

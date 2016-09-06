import java.util.Stack;

public class ResStack {
	private Stack<Integer> stack;
	private int MaxSize;
	private boolean isStop;
	private Thread[] Threads;
	
	public ResStack(int maxSize, Thread[] threads){
		System.out.format("Creating stack.\n", 0);
		stack = new Stack<Integer>();
		MaxSize = maxSize;
		isStop = false;
		Threads = threads;
	}
	
	public synchronized int pop(int Num){
		if (!stack.isEmpty()){
			System.out.format("Thread %d pop stack %d.\n", Num, stack.size()-1);
			return stack.pop();
		}

		System.out.format("Thread %d pop from empty stack .\n", Num, stack.size()-1);
		isStop = true;
		/*for (int i = 0; i < Threads.length; i++){
			Threads[i].interrupt();
		}*/
		return -1;
	}
	
	public synchronized int push(int Num){
		stack.push(stack.size());
		isStop = stack.size() == MaxSize;
		System.out.format("Thread %d push stack %d.\n", Num, stack.size()-1);
		return stack.size()-1;
	}
	
	public synchronized boolean isStop(){
		return isStop;
	}
}

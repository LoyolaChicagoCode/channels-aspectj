package channel;

public aspect Logging {

	private boolean logging = true;
	
	pointcut anyCallChannel():
		call(* Channel+.*(..)) || call(Channel+.new(..));
	
	pointcut anyCallSemaphore():
		call(* java.util.concurrent.Semaphore+.*(..));
	
	pointcut anyCallOfInterest():
		anyCallChannel() || anyCallSemaphore();
	
	before(): anyCallOfInterest() {
		if (logging) System.out.println("calling " + thisJoinPoint + " on " + thisJoinPoint.getTarget());
	}

	after() returning: anyCallOfInterest() {
		if (logging) System.out.println("returning from " + thisJoinPoint + " on " + thisJoinPoint.getTarget());
	}
	
	after() throwing: anyCallOfInterest() {
		if (logging) System.out.println("exception in " + thisJoinPoint + " on " + thisJoinPoint.getTarget());
	}
	
	before(): adviceexecution() && !within(Logging) {
		if (logging) System.out.println("performing " + thisJoinPoint + " on " + thisJoinPoint.getTarget());
	}
}

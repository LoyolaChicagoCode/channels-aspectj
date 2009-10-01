package channel;

import java.util.concurrent.Semaphore;

import org.aspectj.lang.SoftException;

/**
 * An aspect that adds proper concurrency control to a channel. 
 */
aspect Sync {

  declare precedence: Sync, Bound, Storage, Balking;

//  declare soft: InterruptedException : call(void Channel.put(*));

  private Semaphore Channel.putPermits = null;
  private Semaphore Channel.takePermits = null;

  after(Channel b):
    target(b) && initialization(ChannelImpl.new(int))
  {
    b.putPermits = new Semaphore(b.capacity);
    b.takePermits = new Semaphore(0);
  }

  void around(Channel b):
    target(b) && call(void Channel.put(Object))
  {
    try {
      b.putPermits.acquire();
    } catch (InterruptedException e) {
      throw new SoftException(new InterruptedException());
    }
    proceed(b);
    b.takePermits.release();
  }

  Object around(Channel b):
    target(b) && call(Object Channel.take())
  {
    try {
      b.takePermits.acquire();
    } catch (InterruptedException e) {
      throw new SoftException(new InterruptedException());
    }
    Object result = proceed(b);
    b.putPermits.release();
    return result;
  }
}

package channel;

/*
 * You should be able to run this program
 * even though the Eclipse Java editor thinks
 * it has syntax errors.  
 */

/**
 * A single producer and a single consumer communicate
 * via a channel instance. 
 */
public class Main {
  public static void main(String[] args) {
    final Channel b = new ChannelImpl(5);
    new Thread(new Runnable() {
      public void run() {
        while (true) {
          try {
            Thread.sleep(1000);
            Object item = new java.util.Date();
            b.put(item);
            System.out.println("Producer: " + item + " size = " + b.size() + " cap = " + b.capacity());
          } catch (InterruptedException e) {
            System.err.println("BoundedBuffer: interrupted in producer");
          }
        }
      }
    }).start();
    new Thread(new Runnable() {
      public void run() {
        try {
          Thread.sleep(2000);
        } catch (InterruptedException e) {
          System.err.println("BoundedBuffer: interrupted in consumer");
          return;
        }
        while (true) {
          try {
            Thread.sleep(800);
            Object item = b.take();
            System.out.println("Consumer: " + item + " size = " + b.size() + " cap = " + b.capacity());
          } catch (InterruptedException e) {
            System.err.println("BoundedBuffer: interrupted in consumer");
            return;
          }
        }
      }
    }).start();
  }
}

package channel;

/**
 * An abstraction of a channel through which
 * multiple actors can communicate.
 */
public interface Channel {
  int size();
  void put(Object x);
  Object take();
}

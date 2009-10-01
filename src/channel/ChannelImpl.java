package channel;

/**
 * An empty channel implementation.  All functionality
 * will be added later through aspects.
 */
public class ChannelImpl implements Channel {

  public ChannelImpl(int capacity) {
    if (capacity <= 0) throw new IllegalArgumentException();
  }

  public int size() { return 0; }

  public void put(Object x) { }

  public Object take() { return null; }
}

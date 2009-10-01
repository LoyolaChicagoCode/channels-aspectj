package channel;


/**
 * An aspect for imposing a capacity upon a channel.
 */
aspect Bound {

  declare precedence: Bound, Storage, Balking;

  int Channel.capacity;

  public int Channel.capacity() { return capacity; }

  after(Channel b, int capacity):
    target(b) && args(capacity) && initialization(ChannelImpl.new(int))
  {
    b.capacity = capacity;
  }

  before(Channel b, Object item):
    target(b) && args(item) && call(void Channel.put(Object))
  {
    if (b.size() >= b.capacity) {
      throw new IndexOutOfBoundsException();
    }
  }
}

package channel;

import java.util.LinkedList;
import java.util.List;

/**
 * An aspect for equipping a channel with (unbounded) storage.
 */
aspect Storage {

  declare precedence: Storage, Balking;

  private List<Object> Channel.items;

  after(Channel b): target(b) && initialization(ChannelImpl.new(int))
  {
    b.items = new LinkedList<Object>();
  }

  after(Channel b, Object item):
    target(b) && args(item) && call(void Channel.put(Object))
  {
    b.items.add(item);
  }

  Object around(Channel b):
    target(b) && call(Object Channel.take())
  {
    return b.items.remove(0);
  }

  int around(Channel b):
    target(b) && call(int Channel.size())
  {
    return b.items.size();
  }
}

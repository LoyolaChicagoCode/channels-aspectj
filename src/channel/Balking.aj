package channel;

import java.util.NoSuchElementException;

/**
 * An aspect for having the take method raise
 * an exception on an empty channel.
 */
aspect Balking {
  before(Channel b):
    target(b) && call(Object Channel.take())
  {
    throw new NoSuchElementException();
  }
}

require '../../lib/ThreadPool'

# Create thread pool with 5 threads.
tp = ThreadPool.new(5)
tp.debug = true
mutex = Mutex.new

out = lambda do |msg|
  mutex.synchronize do
    puts msg
      # 'puts' needs to be synchronzied.
  end
end

# Schedule 15 jobs to be run asynchronously.

1.upto(15) do |i|
  out.call "dispatching job-#{i}..."
  tp.dispatch do
    sleep(Kernel.rand(7))
      # Simulate load.
    out.call "async job-#{i} (#{Thread.current})"
  end
end

# Now schedule 3 jobs to be run synchronously.

sq = ThreadPool::SyncQueue.new
1.upto(3) do |j|
  sq.dispatch do
    sleep(4-j)
      # Simulate load, longest first.
    out.call "synchronous job-#{j} (duration was #{4-j} secs)"
  end
end


# Get us to wait for all the threads in thread
# pool to finish.
# This will terminate the threads and empty
# the thread pool as a result.

tp.join
sq.join


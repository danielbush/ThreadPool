require '../../lib/ThreadPool'
include ThreadPooling

# Create thread pool with 5 threads.
tp = ThreadPool.new(5)
tp.debug = true
mutex = Mutex.new
i=0

# Called at end of job.

out = lambda do
  mutex.synchronize do
    puts "async job (#{i+=1} of 15) (#{Thread.current})"  
      # 'puts' needs to be synchronzied.
      # 'i+=1' needs to be synchronized.
      # If we said: out.call "...#{i+=1}..."
      # it would not be inside this mutex.
      # This will lead to numbering errors eg
      # 1 of 15
      # 1 of 15
      # 2 of 15
      # ...
      # 14 of 15
  end
end

# Generate a new lambda each time...

gen_func = lambda do
  lambda do
    sleep(Kernel.rand(7))
      # Simulate load.
    out.call
  end
end

# Use the same old lambda...

func = lambda do
    sleep(Kernel.rand(7))
      # Simulate load.
    out.call
end

# Schedule 15 jobs to be run asynchronously.

mutex.synchronize do
  puts "dispatching 15 jobs..."
end

15.times do
  tp.dispatch gen_func.call
  #tp.dispatch func
    # Not sure if there are any mutex issues here.
end

# Call join on all the threads in thread pool which
# gets us to wait for them to finish.
# This will set them to terminate and empty the pool.

tp.join

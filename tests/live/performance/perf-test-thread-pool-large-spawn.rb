require '../../lib/ThreadPool'

# Note: you may get out of memory errors as you increase
# the thread pool.
# You may want to run this with optional:
# % [time] jruby [-J-Xmx1g] thread-pool-large-spawn.rb
# % [time] ruby [-J-Xmx1g] thread-pool-large-spawn.rb
#   # For ruby 1.9
#
# This test will also show up synchronization errors
# on the internal array used to keep track of the threads
# A mutex has been added to the #increment and #decrement
# functions.

tp = ThreadPool.new(2000)
#tp.debug = true
mutex = Mutex.new
i=0

func = lambda do
    sleep(0.5)
      # Simulate load.
    mutex.synchronize do
      i+=1
      # Yes, you have to synchronize it.
    end
end

100000.times do
  tp.dispatch func
end

tp.join
puts i

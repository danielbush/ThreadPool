require '../../lib/ThreadPool'

# We probably don't need to mutex here because
# everything is synchronous.
# We may have to be more careful in an environment
# where we have a ThreadPool instance as well as
# other SyncQueue instances.

mutex = Mutex.new

# Schedule 3 jobs to be run synchronously.

sq = ThreadPool::SyncQueue.new
1.upto(3) do |j|
  sq.dispatch do
    sleep(4-j)
      # Simulate load, longest first.
    mutex.synchronize do
      puts "synchronous job-#{j} (duration was #{4-j} secs)"
    end
  end
end


# Wait for the SyncQueue to finish its jobs
# and let its thread exit.

sq.join


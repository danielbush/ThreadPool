require '../ThreadPool'

SQ=ThreadPool::SyncQueue
TP=ThreadPool

describe ThreadPool::SyncQueue do

  it "should finish current job and return the rest if terminating" do
    sq = SQ.new
    10.times do
      sq.dispatch do
        sleep(4)
      end
    end
    sleep 0.3
      # Allow the first synchronous job to get started.
    jobs=sq.terminate
    jobs.class.should == Array
    jobs.size.should == 9
    sq.join
  end

  it "should finish all remaining jobs if being stopped"
  it "should throw an error if job is pushed on queue whilst stopping"
  it "should have a normally exited thread if terminated"
    # TODO: Need way to access @thread to check its status.

  it "should return true for stopping? but false for other flags when stopping"
  it "should return true for running? only if not terminated or not stopping"
  it "should return true for stopped? only if not stopping, running or processing"
  it "can return true for processing? if running or stopping but nowhere else"
    # TODO: Need to add processing?

  it "should start a new thread if terminated and then started again"
end

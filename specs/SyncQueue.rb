require '../ThreadPool'

SQ=ThreadPool::SyncQueue
TP=ThreadPool

describe ThreadPool::SyncQueue do
  it "should terminate on current job and return the rest" do
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
end

require '../lib/ThreadPool'
include ThreadPooling

TP=ThreadPool

describe ThreadPool do

  describe "dispatching lambdas" do

    it "should work with no arguments" do
      result=nil
      tp = TP.new(1)
      tp.dispatch lambda {result='hi'}
      tp.join
      result.should == 'hi'
    end

  end

end

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

    it "should work with arguments provided in an array" do
      result=nil
      tp = TP.new(1)
      tp.dispatch lambda {|a,b,c| result=a+b+c} , ['foo' , 'bar' , 'baz' ]
      tp.join
      result.should == 'foobarbaz'
    end


  end

end

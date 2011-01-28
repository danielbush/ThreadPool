ThreadPool
==========

ThreadPool is a class that you can instantiate to build a pool of running
threads.  The threads wait on a Ruby Queue object for jobs - in the form of
ruby blocks or lambdas - to perform.

ThreadPool was written with the intention of being used on JRuby but
will work on other rubies too especially Ruby 1.9+.
**Note:** At the moment *no effort* has been made to patch Ruby 1.8.* for
any threading issues.

Send errors or issues to: Daniel Bush < dlb.id.au -at- gmail.com >

Basic Workflow
--------------

ThreadPool uses a `dispatch` method with a block for putting jobs in
the queue to be processed asynchronously:

    # Create 5 threads
    tp = ThreadPool.new(5)
    
    # Dispatch an asynchronous task.
    tp.dispatch do
      # your task
    end
    
    # Wait for all threads to finish
    tp.join

Or lambdas/procs

    func = lambda { ... your task ... }
    tp.dispatch func

In fact as long as it responds to `call` you're probably ok.

You can also pass arguments to `dispatch` and they will be handed to the block when it is taken from the queue:

    tp.dispatch(foo, bar) do |foo, bar|
      print "foo: #{foo}; bar: #{bar}\n"
    end

…or in the case of a Proc:

    my_proc = Proc.new { |foo, bar| print "foo: #{foo}; bar: #{bar}\n" }
    tp.dispatch(my_proc, foo, bar)
    
At the moment it's assumed that you won't try to handle or modify thread
control within the task itself.

You can add or remove threads from the thread pool using 
ThreadPool#increment and ThreadPool#decrement.  These methods
haven't been fully tested yet.

ThreadPool also has a SyncQueue class which represents a single queue and a
single thread that synchronously executes the jobs in this queue.  You can
instantiate one of these and it will run separate to the thread pool. To be
honest I'm not sure why you need it but I was looking at the Grand Central
Dispatch technique which seemed to have a similar concept.

To get the documentation, type: `rdoc --exclude=tests/` in the root directory of this project.

ThreadPool is very new at this stage and there may still be some obvious
errors.  Whilst the code is very simple, it is relatively untested aside from
several live tests that you can use to see how it works.

You can run all the live tests like this (in linux/unix shell):

    $ cd tests/live
    $ sh test-all.sh

Some rspec tests are in `specs/`. Install rspec (`gem install rspec`) and use the `spec` command to run them.

Regards,
Daniel Bush

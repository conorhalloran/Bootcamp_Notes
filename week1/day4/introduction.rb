
Ruby is a:
- General Purpose Programming Language
- Interpreted Language
  - Compiled Languages (C, C++, Java) have to be compiled prior to execution

Installing Ruby:
 - Terminal:
    which ruby # /Users/conorhalloran/.rvm/rubies/ruby-2.4.1/bin/ruby
    ruby - v # ruby 2.4.1p111 (2017-03-22 revision 58053) [x86_64-darwin16]
    RVM allows us to keep old versions of Ruby to support previous projects. No need to update old projects to new bersion of Ruby.
    rvm.io #copy url to download
    rvm rubies
    rvm install <ruby version>
    rvm use 2.4.2 --default
    rvm use <ruby version> will use that version of Ruby.

Interacting with Ruby in Terminal
  irb # Interact Ruby
  pry # is a better way to interact with Ruby <gem install pry>
    - will need to reinstall for each version of Ruby. Gems as specific(dependant) to each version of Ruby.

To execute a file in terminal:
  - ruby <filename.rb>

In pry to Load a file: load ./<filename.rb>

Everything in Ruby is an Object
1.class #integer
"adad".class #string
false.class #FalseClass
"fdfadsf".object_id #3423423453234

Garbage Collection:
- Goes through unused variables to clean up and empty the memory.
- If you make a copy of a variable but do not save it to another variable... the copy gets deleted.

How to repeat a code x number of times:
  10.times { puts "Hello CodeCore" } # prints 

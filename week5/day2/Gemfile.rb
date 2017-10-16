Uses a Gem called Bundler. Is a Gem used to manage other gems. 
    - Deciding which gem and what version we need to use. 

gem 'rails', '~> 5.1.4'
5 = major - major changes that will require app update. 
1 = minor - implimenting minor feature.
4 = batch - usually a fix / security feature. 
~> = accepts changes in the last didget

Add Gem to Gemfile: Example:
gem 'cowsay', '~> 0.3.0'
To Install it: 
Stop the server to make changes
Run 'bundle' in terminal
When you run 'bundle' Bundler will update 'Gemfile.lock' automatically.
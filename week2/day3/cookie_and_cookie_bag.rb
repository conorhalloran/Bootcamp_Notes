require './cookie.rb'
require './cookie_bag.rb'

cb = CookieBag.new

c1 = Cookie.new 5, 6
c2 = Cookie.new 5, 4
c3 = Cookie.new 5, 7
c4 = Cookie.new 5, 8

cb.add c1
cb.add c2
cb.add c3
cb.add c4

cb.details

cb.take
cb.take
cb.take
cb.take

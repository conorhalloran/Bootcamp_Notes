# http:// protocalls 
All devices connected to the internet must agree on specific set of protocalls.
OSI vs TCP/IP model

Internet: 
IPv4 is a 32bit address. 
4 * 8 bits or 4 bytes.

traceroute www.reddit.com
Routing Table:
A routeer looks at incoming packets destination IPs and routes them according to a routing table. 

IPv6 uses hexadecimal addresses
2001:0DB8:AC10:FE01:: (when followed by all zeros use "::")

localhost (loopback)
IPv4: 127.0.0.1 or 0.0.0.0
IPv6: 0:0:0:0:0:0:0:1 or ::1

DNS: Domain Name System: translate a url into an ip address. Is provided by your ISP. 

Transport: 
TCP: Reliable, Ordered, Error Checked, Connection Based. TCP Ports have to be unique. 
UDP: Unreliable, No Order Checking, Best Effort, Faster than TCP. Used for trasmitting Audio/Video files.

HTTP: Verbs (or Request Methods)
GET: To receive particular data
POST: To send form submission data. 

HTTP Response Code: 
200 OK
301 Moved Permanently
302 Found
400 Bad Request
401 Unauthorized
403 Forbidden
404 Not found.
500 Internal Server Error

Parameters: 
What goes through a router is a frame. 
TCP Layer = packet.

TCP Client with Node.js
NVM: brew uninstall node, brew update, brew install nvm
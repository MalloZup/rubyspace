#! /usr/bin/ruby

require 'xmlrpc/client'
require 'securerandom'

class Auth

 def initialize(space_url, space_login, space_pwd)
   @@space_url = space_url
   @@space_login = space_login
   @@space_pwd = space_pwd
   @@client = nil
   @@key = nil
 end
 
 def genkey
    @@client = XMLRPC::Client.new2(@@space_url)
    @@key = @@client.call('auth.login', @@space_login, @@space_pwd)
 end

 def logout
   @@client.call('auth.logout', @@key)
 end
end


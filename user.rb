#! /usr/bin/ruby

require 'xmlrpc/client'

TESTHOST = ..
MINION = "head-minsles12sp1.tf.local"
@SATELLITE_URL = "http://#{TESTHOST}/rpc/api"
@SATELLITE_LOGIN = "admin"
@SATELLITE_PASSWORD = "admin"

@client = XMLRPC::Client.new2(@SATELLITE_URL)

def CrUserReadOnly()
  @client.call('user.create', @key, "ReadOnly", "ReadOnly", "Readonly", "Verde", "pino@foo.com")
rescue XMLRPC::FaultException => detail
  puts "Got an exception :" 
  puts detail
  @client.call('user.setReadOnly', @key, "ReadOnly", true)
  @client.call('auth.logout', @key)
end

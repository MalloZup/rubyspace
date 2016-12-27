#! /usr/bin/ruby

require 'xmlrpc/client'

TESTHOST = 'foo'.freeze
MINION = 'head-minsles12sp1.tf.local'.freeze
@space_url = "http://#{TESTHOST}/rpc/api"
@space_login = 'admin'
@space_pwd = 'admin'

@client = XMLRPC::Client.new2(@space_url)

def cr_user_readonly
  @client.call('user.create', @key, 'readonly', 'readonly',
               'readonly', 'Verde', 'pino@foo.com')
rescue XMLRPC::FaultException => detail
  puts 'Got an exception :'
  puts detail
  @client.call('user.setReadOnly', @key, 'readonly', true)
  @client.call('auth.logout', @key)
end

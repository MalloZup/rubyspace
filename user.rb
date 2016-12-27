#! /usr/bin/ruby

require 'xmlrpc/client'
require 'securerandom'

TESTHOST = 'head-suma3pg.mgr.suse.de'.freeze
MINION = 'head-minsles12sp1.tf.local'.freeze
@space_url = "http://#{TESTHOST}/rpc/api"
@space_login = 'admin'
@space_pwd = 'admin'

@client = XMLRPC::Client.new2(@space_url)
@key = @client.call('auth.login', @space_login, @space_pwd)

def cr_user_readonly
  @client.call('user.create', @key, 'readonly', 'readonly',
               'readonly', 'Verde', 'pino@foo.com')
rescue XMLRPC::FaultException => detail
  puts 'Got an exception :'
  puts detail
  @client.call('user.setReadOnly', @key, 'readonly', true)
  @client.call('auth.logout', @key)
end

def create_users(user_number)
  user_number.times do
    pwd = SecureRandom.urlsafe_base64(10)
    f_name = SecureRandom.urlsafe_base64(5)
    l_name = SecureRandom.urlsafe_base64(6)
    mail = SecureRandom.urlsafe_base64(4) + '@' + SecureRandom.urlsafe_base64(3)
    @client.call('user.create', @key, pwd, pwd, f_name, l_name, "#{mail}.com")
  end
end

# create_users(100)
@key = @client.call('auth.logout', @space_login, @space_pwd)

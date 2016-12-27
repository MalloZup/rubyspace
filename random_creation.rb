#! /usr/bin/ruby

require 'xmlrpc/client'
require 'securerandom'

TESTHOST = 'headref-suma3pg.mgr.suse.de'.freeze
MINION = 'head-minsles12sp1.tf.local'.freeze
@space_url = "http://#{TESTHOST}/rpc/api"
@space_login = 'admin'
@space_pwd = 'admin'

@client = XMLRPC::Client.new2(@space_url)
@key = @client.call('auth.login', @space_login, @space_pwd)

def random_create_users(user_number)
  user_number.times do
    pwd = SecureRandom.urlsafe_base64(10)
    f_name = SecureRandom.urlsafe_base64(5)
    l_name = SecureRandom.urlsafe_base64(6)
    mail = SecureRandom.urlsafe_base64(4) + '@' + SecureRandom.urlsafe_base64(3)
    @client.call('user.create', @key, pwd, pwd, f_name, l_name, "#{mail}.com")
  end
end

def random_create_sysgroup(group_number)
  group_number.times do
    desc = SecureRandom.urlsafe_base64(9)
    name = SecureRandom.urlsafe_base64(7)
    @client.call('systemgroup.create', @key, name, desc)
  end
end

number = 1000
# random_create_users(10000)
random_create_sysgroup(number)
@client.call('auth.logout', @key)

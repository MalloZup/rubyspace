#! /usr/bin/ruby

require 'xmlrpc/client'
require 'securerandom'
require_relative 'auth_lib.rb'

TESTHOST = 'headref-suma3pg.mgr.suse.de'.freeze
MINION = 'head-minsles12sp1.tf.local'.freeze
$space_url = "http://#{TESTHOST}/rpc/api"
$space_login = 'admin'
$space_pwd = 'admin'

class Randomize < Auth

  def initialize()
  end
  def create_users(user_number)
    user_number.times do
      pwd = SecureRandom.urlsafe_base64(10)
      f_name = SecureRandom.urlsafe_base64(5)
      l_name = SecureRandom.urlsafe_base64(6)
      mail = SecureRandom.urlsafe_base64(4) + '@' + SecureRandom.urlsafe_base64(3)
      @@client.call('user.create', @@key, pwd, pwd, f_name, l_name, "#{mail}.com")
    end
  end

  def create_sysgroup(group_number)
    group_number.times do
      desc = SecureRandom.urlsafe_base64(9)
      name = SecureRandom.urlsafe_base64(7)
      @@client.call('systemgroup.create', @@key, name, desc)
    end
  end
 
  def tasko_test
     # ary = ["BaseChanne"]
     # scheduleSingleRepoSync(Channel chan, User user)
     puts @@client.call('api.getApiNamespaceCallList', @@key, "taskomatic")
  end

end 

number = 1000

xmlrpc_client = Auth.new($space_url, $space_login, $space_pwd)
xmlrpc_client.genkey
t = Randomize.new
t.create_sysgroup(20)
t.create_users(40)

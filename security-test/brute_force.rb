#! /usr/bin/ruby

require 'xmlrpc/client'
require 'securerandom'
require_relative 'auth_lib.rb'

TESTHOST = 'headref-suma3pg.mgr.suse.de'.freeze
MINION = 'head-minsles12sp1.tf.local'.freeze
$space_url = "http://#{TESTHOST}/rpc/api"
$space_login = 'admin'
$space_pwd = 'admin'

def brute_force(user, pwd)
  for n in 0..user.length do
    puts "=========="
    puts "user :  #{user[n]}" + " password: #{pwd[n]}"
    puts "=========="
    xmlrpc_client = Auth.new($space_url, $space_login, $space_pwd)
    begin
      puts xmlrpc_client.genkey_from(user[n], pwd[n])
    rescue XMLRPC::FaultException => msg
      puts "caught an ex: #{msg}"
    else 
      puts "**************************************************"
      puts "**************************************************"
      puts "password is : " + pwd[n] + "user is: " +  user[n]
      puts "**************************************************"
      puts "************ HAPPY HACKING ***********************"
      break
    end  
  end
end

user = Array.new
pwd = Array.new

#brute force pwd. (simulate a dictionary pwd, generate random pwd)
100.times do
  user.push(SecureRandom.urlsafe_base64(8))
  pwd.push(SecureRandom.urlsafe_base64(8))
end
# put at the end the right pwd :)
user.push('admin')
pwd.push('admin')
brute_force(user, pwd)

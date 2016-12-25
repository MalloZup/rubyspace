#! /usr/bin/ruby
require 'xmlrpc/client'

@TESTHOST = "TEST"
@SATELLITE_URL = "http://#{TESTHOST}/rpc/api"
@SATELLITE_LOGIN = "admin"
@SATELLITE_PASSWORD = "admin"

@client = XMLRPC::Client.new2(@SATELLITE_URL)

@key = @client.call('auth.login', @SATELLITE_LOGIN, @SATELLITE_PASSWORD)
channels = @client.call('channel.listAllChannels', @key)
for channel in channels do
   p channel["label"]
end

@client.call('auth.logout', @key)

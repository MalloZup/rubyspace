#! /usr/bin/ruby
require 'xmlrpc/client'

TESTHOST = "test"
@SATELLITE_URL = "http://#{TESTHOST}/rpc/api"
@SATELLITE_LOGIN = "admin"
@SATELLITE_PASSWORD = "admin"

@client = XMLRPC::Client.new2(@SATELLITE_URL)
@key = @client.call('auth.login', @SATELLITE_LOGIN, @SATELLITE_PASSWORD)

# Print and return List all channels
def listAllChannels(key)
  channels = @client.call('channel.listAllChannels', key)
  channels.each { |ch| puts ch["label"] }
end



listAllChannels(@key)
@client.call('auth.logout', @key)

#! /usr/bin/ruby
require 'xmlrpc/client'

TESTHOST = "headref-suma3pg.mgr.suse.de/"
@SATELLITE_URL = "http://#{TESTHOST}/rpc/api"
@SATELLITE_LOGIN = "admin"
@SATELLITE_PASSWORD = "admin"

@client = XMLRPC::Client.new2(@SATELLITE_URL)
@key = @client.call('auth.login', @SATELLITE_LOGIN, @SATELLITE_PASSWORD)

# Print and return List all channels
def listAllChannels()
  channels = @client.call('channel.listAllChannels', @key)
  channels.each { |ch| puts ch["label"] }
end

# List and return all pkg from a channel label given.
def listAllPackages(channelLabel)
  puts "list packages in channel"
  @client.call('channel.software.listAllPackages', @key,  channelLabel)
end

# Sync a repo 
def SyncRepo(channelLabel)
  @client.call('channel.software.syncRepo', @key,  channelLabel)
end



### Main ## 
listAllChannels()
# SyncRepo("sles12-sp1-pool-x86_64")
# listAllPackages("sles12-sp1-pool-x86_64")
puts @client.call('schedule.listInProgressActions', @key)
puts @client.call('schedule.listFailedActions', @key)
@client.call('auth.logout', @key)

#! /usr/bin/ruby
require 'xmlrpc/client'

TESTHOST = ...
MINION = "head-minsles12sp1.tf.local"

@SATELLITE_URL = "http://#{TESTHOST}/rpc/api"
@SATELLITE_LOGIN = "admin"
@SATELLITE_PASSWORD = "admin"
@client = XMLRPC::Client.new2(@SATELLITE_URL)
@key = @client.call('auth.login', @SATELLITE_LOGIN, @SATELLITE_PASSWORD)

  # channel actions.
  # Print and return List all channels
  def listAllChannels()
    channels = @client.call('channel.listAllChannels', @key)
    channels.each { |ch| puts ch["label"] }
  end
  # set base channel for system id 
  def setBaseChannel(channelLabel, system)
    @client.call('system.setBaseChannel' , @key, system, channelLabel)
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


  # list systems
  def listSystems()
    @client.call('system.listSystems' , @key)
  end

  def getSystemID_ByName(name)
    systems = listSystems()
    sid = nil
    systems.each {  |s| s['name']
      sid = s["id"]  if s["name"] == name 
    }
    return sid
  end


  def listInProgAction()
     @client.call('schedule.listInProgressActions', @key)
  end



def main()
  puts listSystems
#  sys_id = System.getSystemID_ByName(MINION)
#  Channel.setBaseChannel("sles12-sp1-pool-x86_64", sys_id)
  # Action list for all sys
#  puts Schedule.listInProgAction()
#  @client.call('auth.logout', @key)
end

main()

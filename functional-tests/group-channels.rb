#! /usr/bin/ruby
require 'xmlrpc/client'

TESTHOST = 'headref-suma3pg.mgr.suse.de'.freeze
MINION = 'head-minsles12sp1.tf.local'.freeze

@space_url = "http://#{TESTHOST}/rpc/api"
@space_login = 'admin'
@space_pwd = 'admin'
@client = XMLRPC::Client.new2(@space_url)
@key = @client.call('auth.login', @space_login, @space_pwd)

# channel actions.
# Print and return List all channels
def list_all_channels
  channels = @client.call('channel.listAllChannels', @key)
  channels.each { |ch| puts ch['label'] }
end

# set base channel for system id
def set_base_channel(channel_label, system)
  @client.call('system.setBaseChannel', @key, system, channel_label)
end

# List and return all pkg from a channel label given.
def list_all_packages(channel_label)
  puts 'list packages in channel'
  @client.call('channel.software.listAllPackages', @key, channel_label)
end

# Sync a repo
def sync_repo(channel_label)
  @client.call('channel.software.syncRepo', @key, channel_label)
end

def sync_all_repos
  repos = list_all_channels
  repos.each do |repo|
    puts @client.call('channel.software.syncRepo', @key, repo['label'])
  end
end

# list systems
def list_systems
  @client.call('system.listSystems', @key)
end

def get_systemid_byname(name)
  systems = list_systems
  sid = nil
  systems.each do |s|
    s['name']
    sid = s['id'] if s['name'] == name
  end
  sid
end

def list_inprog_action
  @client.call('schedule.listInProgressActions', @key)
end

def main
  sync_all_repos
  ##  sync_all_repos
  #  sys_id = System.get_systemid_bynameMINION)
  #  Channel.setBaseChannel("sles12-sp1-pool-x86_64", sys_id)
  # Action list for all sys
  #  puts Schedule.listInProgAction()
  @client.call('auth.logout', @key)
end

main

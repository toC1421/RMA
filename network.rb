require 'bundler'
require 'yaml'
require 'active_record'
require 'google_drive'
Bundler.require
Dotenv.load

ActiveRecord::Base.configurations = YAML.load_file('database.yml')
ActiveRecord::Base.establish_connection(:development)
slack = Slack::Incoming::Webhooks.new ENV['slack_hook'],channel: '#checkroom'

class Mac < ActiveRecord::Base
end

def network
  %x[nmap -sP 192.168.1.0/24]
  %x[arp -a].gsub(/\n/,'').scan(/[0-f]+:[0-f]+:[0-f]+:[0-f]+:[0-f]+:[0-f]+/)
end

session = GoogleDrive.saved_session("config.json")
ws = session.spreadsheet_by_key(ENV['spreadsheet_key']).worksheets[0]

users = Mac.where(address: network)
if users.count == 0 then
  ws[1,1] = ""
  ws.save
else
  users.each_with_index do |addr,idx|
    ws[idx+1,1] = addr.name
    if idx == users.count - 1
      ws[idx+2,1] = ""
    end
  end
  ws.save
end

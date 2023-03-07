require 'optparse'
require 'rss'
require 'uri'
require 'net/http'

# RSS url example: https://jovemnerd.com.br/feed-nerdcast/ 

options = {}

parser = OptionParser.new do |parser|
    parser.on("-u", "--url RSS_URL", "RSS feed url")
end

parser.parse!(into: options)

url = options[:url]

uri = URI(url)
res = Net::HTTP.get_response(uri)

feed = RSS::Parser.parse(res.body)

feed.items.each do |item|
    puts "Title: #{item.title}"
    puts "Description: #{item.description}"
    puts "Link: #{item.link}"
end
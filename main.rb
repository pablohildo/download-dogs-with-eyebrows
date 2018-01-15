# Downloads the dogs

require 'HTTParty'
require 'JSON'
require 'mechanize'

$api_key = 
$cse_id =
$query_size =

def get_extension(url)
  return url[url.length - 3, url.length]
end

def download_images(list)
  agent = Mechanize.new
  list.each.with_index do |item, index|
    agent.get(item).save "cachorros/#{index}.#{get_extension(item)}"
  end
end

def get_parsed_response(start)
  return JSON.parse(HTTParty.get("https://www.googleapis.com/customsearch/v1?key=#{$api_key}&cx=#{$cse_id}&q=dogs+with+eyebrows&start=#{start}", format: :plain))
end

def get_image_list
  index = 0..$query_size
  list = []
  index.each do |j|
    json=get_parsed_response(j*10+1)
    items = json["items"]
    # Why am I exception swallowing: there is a whole lot of websites (like dumb Tumblr) that won't return cse image,
    # so if I don't do this, the script will stop instead of downloading what is possible, since it indexes first and
    # only then downloads. Anyways, I'll find a better way to do that
    begin
      items.each do |i|
        list.push(i["pagemap"]["cse_image"][0]["src"])
      end
    rescue => ex
      p "Exception #{ex} caught"
    end
  end
  return list
end

download_images(get_image_list)

  

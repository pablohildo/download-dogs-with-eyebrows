# Outputs JSON as a file for debugging purposes 

require 'HTTParty'
require 'JSON'

text = JSON.parse(HTTParty.get('https://www.googleapis.com/customsearch/v1?key=AIzaSyBOzy2muWRQFeJYtivqfon5i53AGTx3xp0&cx=008346584975182908926:1jwnq8owuc0&q=dogs+with+eyebrows', format: :plain))
output = File.open("output.json", "w")
output << text
output.close
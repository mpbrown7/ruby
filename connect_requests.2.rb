require 'rest-client'
require 'json'
require 'fastimage'
require 'dogapi'

##### Configuration ##########
API_KEY = "5de155b51114b48f8174668885fbf490"
VALUE_FOR_SUCCESS = 1
VALUE_FOR_ERROR = 0
dog = Dogapi::Client.new(API_KEY)
##### End Configuration ##########

#do login
resource = RestClient::Resource.new('https://api-stage.segmint.net/v4/security/oauth/token?grant_type=client_credentials', 'pinpoint-integration', 'thush6Cu')
result = resource.post('')
token = JSON.parse(result)['access_token'];
#puts result

offer_count = 1

#partner_id = 10850157
partner_id = 170337
#ucic = '11a1224a-6de2-4c05-a8b9-2ac9f4880cf5'
ucic = 'f69d60731a7847e6ae07439e932b915d'

params = {
    :channel_type_id => 1,
    :offer_count => offer_count,
    #:zone_id => 2481,
    #:width => 728,
    #:height => 90

}

#request_url = "https://connect-qa.segmint.net/partners/#{partner_id}/ucics/#{ucic}/offers"
begin  

request_url = "https://connect-stage.segmint.net/partners/#{partner_id}/ucics/#{ucic}/offers"


beginning_time = Time.now
response = RestClient.get(request_url, :params => params, :Authorization => 'Bearer ' + token)
end_time = Time.now
puts "Time elapsed #{(end_time - beginning_time)*1000} milliseconds"

items = JSON.parse(response)
url = items[0]['image_url']

#items.each do |i|
#     puts i
#end
end

#puts url

#dog.emit_point("delivery.stage.decision", VALUE_FOR_SUCCESS, :host => "stage")

#begin
#  size = FastImage.new(url).content_length
#  #raise "expected #{offer_count} items, but got back #{items.size}"  unless items.size == offer_count
#  puts size
#  if size < 1
# puts "Image not found"
#  dog.emit_point("delivery.stage.image_delivery", VALUE_FOR_ERROR, :host => "stage")
#  else
# puts "Real image found"
#  dog.emit_point("delivery.stage.image_delivery", VALUE_FOR_SUCCESS, :host => "stage")
#  end
#rescue
#  puts "CDN Not responding"
#  dog.emit_point("delivery.stage.image_delivery", VALUE_FOR_ERROR, :host => "stage")
#end
#
#
#rescue 
#  puts "Failed to get image"
#  dog.emit_point("delivery.stage.decision", VALUE_FOR_ERROR, :host => "stage")
#  dog.emit_point("delivery.stage.image_delivery", VALUE_FOR_ERROR, :host => "stage")
#end

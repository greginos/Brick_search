require 'json'
require 'open-uri'

def import_parts_from_sets(request, url = nil)
  key = "3c19aaab1cb4a59b4776e75383e9bc2f"
  page_size = 2000
  url = "https://rebrickable.com/api/v3/lego/sets/#{request}/parts/?key=#{key}" if url.nil?
  response = open(url).read
  result = JSON.parse(response)
  if result["count"] != 0
    puts result["count"]
    result["results"].each do |part|
      p part_number = part["part"]["part_num"].to_i
      p request
      p Box.where(box_sku: request)
      p Part.where(part_sku: part_number)
    end
  else
    puts "None"
  end

  # result['results'].each do |res|
  #   if request == "colors"
  #   request.classify.constantize.create({
  #     rgb: res['rgb'],
  #     name: res['name'],
  #     is_trans: res['is_trans'],
  #     external_ids: res['external_ids']
  #     }
  #   )
  #   elsif request == "parts"
  #     request.classify.constantize.create({
  #       name: res['name'],
  #       part_sku: res['part_num'],
  #       external_ids: res['external_ids']
  #     })
  #   elsif request == "sets"
  #     Box.create({
  #       name: res['name'],
  #       box_sku: res['set_num']
  #     })
  #   end
  # end
  # unless result['next'].nil?
  #   puts "Moving to another #{request} page"
  #   url = result['next']
  #   importElement(request, url) unless result['next'].nil?
  # end
  # request == "sets" ? puts "#{Box.all.count} #{request} created" : puts "#{request.classify.constantize.all.count} #{request} created"
end

import_element("75187-1")

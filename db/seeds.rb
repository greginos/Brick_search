# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'open-uri'


def import_element(request, url = nil)
  key = "3c19aaab1cb4a59b4776e75383e9bc2f"
  page_size = 2000
  url = "https://rebrickable.com/api/v3/lego/#{request}/?key=#{key}&page_size=#{page_size}" if url.nil?
  response = open(url).read
  result = JSON.parse(response)
  result['results'].each do |res|
    if request == "colors"
    request.classify.constantize.create({
      rgb: res['rgb'],
      name: res['name'],
      is_trans: res['is_trans'],
      external_ids: res['external_ids']
      }
    )
    elsif request == "parts"
      request.classify.constantize.create({
        name: res['name'],
        part_sku: res['part_num'],
        external_ids: res['external_ids']
      })
    elsif request == "sets"
      Box.create({
        name: res['name'],
        box_sku: res['set_num']
      })
    end
  end
  unless result['next'].nil?
    puts "Moving to another #{request} page"
    url = result['next']
    import_element(request, url) unless result['next'].nil?
  end
  if request == "sets"
    puts "#{Box.all.count} #{request} created"
  else
    puts "#{request.classify.constantize.all.count} #{request} created"
  end
end


def import_parts_from_sets(request, url = nil)
  key = "3c19aaab1cb4a59b4776e75383e9bc2f"
  page_size = 5000
  url = "https://rebrickable.com/api/v3/lego/sets/#{request}/parts/?key=#{key}&page_size=2000" if url.nil?
  response = open(url).read
  result = JSON.parse(response)
  in_box = Box.where(box_sku: request).first
  if result["count"].positive?
    puts "#{in_box.box_sku} - #{in_box.name} - #{result["count"]} parts awaited"
    result["results"].each do |part|
      part_number = part["part"]["part_num"]
      part["quantity"].times do
        box_part = Part.where(part_sku: part_number).first
        in_box.parts << box_part unless box_part.nil?
      end
      in_box.save
    end
  else
    puts "No parts for this set !!!"
  end
  unless result['next'].nil?
    puts "Moving to another #{request} page"
    url = result['next']
    import_element(request, url) unless result['next'].nil?
  end
end

def add_parts_to_boxes
  Box.all.each do |box|
    if box.parts.length.positive?
      request = box.box_sku
      import_parts_from_sets(request)
      puts "#{box.box_sku} - #{box.name} - #{box.parts.length} parts added"
    end
  end
  puts "All sets done"
end

# import_element("sets")
# import_element("colors")
# import_element("parts")
add_parts_to_boxes

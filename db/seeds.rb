# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'open-uri'


def importElement(request, url = nil)
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
    puts "Moving to another page"
    url = result['next']
    importElement(request, url) unless result['next'].nil?
  end
  puts "#{request.classify.constantize.all.count} #{request} created"
end

importElement("colors")
importElement("parts")
importElement("sets")

#!/usr/bin/ruby
require 'csv'

lang = ARGV[0].to_i
quotation = [1,4.4572]
currency = ['RON','EUR']
time = Time.new
wdays = {
    0 => ['Duminica','Sunday'],
    1 => ['Luni','Monday'],
    2 => ['Marti','Tuesday'],
    3 => ['Miercuri','Wednesday'],
    4 => ['Joi','Thursday'],
    5 => ['Vineri','Friday'],
    6 => ['Sambata','Saturday'],
}
date = "#{wdays[time.wday][lang]} #{time.day}/#{time.month}/#{time.year}"

header = [
"Lista de preturi #{date}:",
"#{date} price list:"
]
qt_lang = {
    'kg'  => ['kg','kg'],
    'buc' => ['buc','piece']
}
prices = CSV.read("prices.list")
puts prices.inspect
footer = [
"Nota: preturile sunt orientative si se pot negocia direct cu producatorii, in functie de cantitatea dorita.",
"Note: prices are indicative and you can negotiate directly with the farmers, depending on quantity."
]

puts header[lang]
prices.each do |price|
    printf "%-15s  %s - %s %s/%s\n", \
            price[lang],\
            price[2].to_f > 0 ? (price[2].to_f/quotation[lang]).round(2) : '',\
            price[3].to_f > 0 ? (price[3].to_f/quotation[lang]).round(2) : '',\
            currency[lang],\
            qt_lang[price[4]][lang]
end
puts footer[lang]
if lang == 1 
    puts "BNR EXCHANGE RATE: 1 EUR = #{quotation[lang]} RON"
    puts "Pentru vorbitorii de Limba Romana, preturile in lei sunt disponibile doar daca aveti setata Limba Romana pe facebook."
end

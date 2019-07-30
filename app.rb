require 'sinatra'
require 'sinatra/reloader'
also_reload("./lib/**/*.rb")
require 'pry'
require 'pg'
require("./lib/animal")

DB = PG.connect({:dbname => "animal_shelter"})

get ('/') do
  @animal_types = [nil]
  types_result = DB.exec("SELECT * FROM animal_types;")
  types_result.each {|type| @animal_types.push(type["type"])}

  @result = DB.exec("SELECT * FROM animals;")
  @animals_avail = []
  @result.each do |result|
  animal = Animal.new({:name => result["name"], :id => result["id"], :gender => result["gender"], :date => result["date"], :type => result["type"], :breed => result["breed"]})
  @animals_avail.push(animal)
  end
  erb :default
end

get ('/animals') do
  @result = DB.exec("SELECT * FROM animals;")
  @animals_avail = []
  @result.each do |result|
  animal = Animal.new({:name => result["name"], :id => result["id"], :gender => result["gender"], :date => result["date"], :type => result["type"], :breed => result["breed"]})
  @animals_avail.push(animal)
  end
  erb :animals
end

post ('/add_animal') do
  animal_types = [nil]
  types_result = DB.exec("SELECT * FROM animal_types;")
  types_result.each {|type| animal_types.push(type["type"])}

  # inserts values based on param. the Time.new section looks terrifying, but it's just outputting the string in this format: 2019-7-30
  # .find_index here is just looking at the array we created of animal types, and it's finding the position of the string in the array. the array starts with a value of nil because in the SQL database, IDs start at 1 and not 0.
  DB.exec("INSERT INTO animals (name, gender, date, type, breed) VALUES ('#{params[:animal_name]}', '#{params[:animal_gender]}', '#{Time.new.year.to_s}-#{Time.new.month.to_s}-#{Time.new.day.to_s}', '#{animal_types.find_index(params[:animal_type])}', '#{params[:animal_breed]}');")

  redirect to ('/animals')
end

get ('/type')do
  @result = DB.exec("SELECT * FROM animals ORDER BY type")
  # binding.pry
  erb :type
end

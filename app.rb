require 'sinatra'
require 'sinatra/reloader'
also_reload("./lib/**/*.rb")
require 'pry'
require 'pg'
require("./lib/animal")

DB = PG.connect({:dbname => "animal_shelter"})

get ('/') do
  # this creates an array of animal types (cat, dog, etc)
  # this future proofs the database because we might add in lizards and turkeys in v2.0
  @animal_types = [nil]
  types_result = DB.exec("SELECT * FROM animal_types;")
  types_result.each {|type| @animal_types.push(type["type"])}

  # this grabs all the animals available
  @result = DB.exec("SELECT * FROM animals;")
  # this array exists to create animal objects to append to the page
  # it's kind of redundant, but this way we have some documentation in the program of what to expect from the database
  @animals_avail = []

  #create a bunch of animal objects
  @result.each do |result|
  animal = Animal.new({:name => result["name"], :id => result["id"], :gender => result["gender"], :date => result["date"], :type => result["type"], :breed => result["breed"]})
  #add them to the array
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
  # all same as above
  @animal_types = [nil]
  types_result = DB.exec("SELECT * FROM animal_types;")
  types_result.each {|type| @animal_types.push(type["type"])}

  #this ORDERs the animals based on their type ID, which is 1 for cats 2 for dogs etc
  @result = DB.exec("SELECT * FROM animals ORDER BY type")
  @animals_avail = []
  @result.each do |result|
  animal = Animal.new({:name => result["name"], :id => result["id"], :gender => result["gender"], :date => result["date"], :type => result["type"], :breed => result["breed"]})
  @animals_avail.push(animal)
  end
  erb :type
end

get ('/customers')do
  @animal_types = [nil]
  types_result = DB.exec("SELECT * FROM animal_types;")
  types_result.each {|type| @animal_types.push(type["type"])}

  @result = DB.exec("SELECT * FROM customers;")
  @customers = []
  # for each thing you get back from the database, create a customer object and push it to the array to be appended to the page
  @result.each {|result| @customers.push(Customer.new({:name => result["name"], :id => result["id"], :phone => result["phone"], :animal_pref => result["animal_pref"], :breed_pref => result["breed_pref"]}))}
  erb :customers
end

post ('/customers')do
  @animal_types = [nil]
  types_result = DB.exec("SELECT * FROM animal_types;")
  types_result.each {|type| @animal_types.push(type["type"])}
  DB.exec("INSERT INTO customers (name, phone, animal_pref, breed_pref) VALUES ('#{params[:customer_name]}', '#{params[:customer_phone]}', '#{params[:customer_type]}', '#{params[:breed_pref]}');")
  redirect to ('/customers')
end

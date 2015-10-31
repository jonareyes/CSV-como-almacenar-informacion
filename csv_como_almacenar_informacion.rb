require "csv"
require "faker"
require "date"

class Person
	attr_accessor :first_name, :last_name, :email, :phone, :created_at
	
	def initialize(first_name, last_name, email, phone, created_at)
		@first_name = first_name
		@last_name = last_name
		@email = email
		@phone = phone
		@created_at = created_at
	end

	def self.personas(number) 
		persons = []
		number.times do
			persons << Person.new(Faker::Name.first_name, Faker::Name.last_name, Faker::Internet.email, Faker::PhoneNumber.phone_number, Time.now)
		end
		persons
	end
end



class PersonWriter

	def initialize(file, people)
		@file = file
		@people = people
	end
	
	def create_csv 

		CSV.open(@file, "wb") do |csv|
			@people.each do |persona| 
				csv << [persona.first_name, persona.last_name, persona.email, persona.phone, persona.created_at]
			end
		end
	end
end

class PersonParser

	def initialize(file)
		@file = file
	end

	def people
		persons = []
		CSV.open(@file, "r") do |csv|
			csv.each do |person|
				persons << Person.new(person[0], person[1], person[2], person[3], person[4])
			end		
		end
		persons	
	end
end


people = Person.personas(10)
person_writer = PersonWriter.new("people.csv", people)
person_writer.create_csv

parser = PersonParser.new('people.csv')
p people = parser.people

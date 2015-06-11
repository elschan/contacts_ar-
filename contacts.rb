require 'active_record'
require 'pg'

ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  database: 'contacts',
  username: 'development',
  password: 'development',
  host: 'localhost',
  port: 5432,
  pool: 5,
  encoding: 'unicode',
  min_messages: 'error'
)
puts 'CONNECTED'

puts 'Setting up Database (recreating tables) ...'


class Contact < ActiveRecord::Base
end

def add 
  puts "Please enter the firstname"
  @first_name = gets.chomp
  puts "Please enter the lastname"
  @last_name = gets.chomp
  puts "please enter the email"
  @email = gets.chomp
  Contact.create(firstname: @first_name, lastname:@last_name, email: @email)
  puts "Contact created for #{@first_name} #{@last_name}"
end

def find(id)
  @contact = Contact.find(id)
  puts "#{@contact.firstname} #{@contact.lastname}'s email is #{@contact.email}"
end

def delete
  puts "What id would you like to delete from the database?"
  id = gets.chomp.to_i
  puts "are you sure you want to delete #{Contact.find(id).firstname}'s contact information?"
  confirm = gets.chomp.downcase
  if confirm[0] == 'y'
    Contact.find(id).destroy
    puts "Contact has been deleted"
  else
    prompt
  end
end

def update
  puts "Enter the id of the contact you wish to update"
  id = gets.chomp.to_i
  puts Contact.find(id).inspect
  puts "What field would you like to update? (first name, last name or email"
  answer = gets.chomp.downcase
  if answer[0] == 'f'
    puts "What would you like to update it to?"
    name = gets.chomp
    contact = Contact.find(id)
    contact.update(firstname: name)
    puts contact.inspect
    puts "Contact has been updated"
  end
end

def prompt
  puts "What would you like to do?"
  answer = gets.chomp
  case answer
  when "add"
    add
  when "delete"
    delete
  when "update"
    update
  when "find"
    puts "What is the id number?"
    id = gets.to_i
    find(id)
  else
    prompt
  end
end

prompt

require "zphumza_first_gem/version"
require "unirest"

module ZphumzaFirstGem
  class Employee
  	attr_reader :title, :department, :name, :salary, :last_name, :first_name


  	def initialize(input_options)
  	  @title = input_options["job_titles"]
  	  @department = input_options['department']
  	  @name = input_options['name'].to_s
  	  @salary = input_options['employee_annual_salary'].to_i
  	  @first_name = @name.split(", ")[1]
  	  @last_name = @name.split(", ")[0]
  	end

  	def self.all
  	  ruby_data = []
  	  Unirest.get('https://data.cityofchicago.org/resource/tt4n-kn4t.json').body.each do |employee|
  	  	ruby_data << Employee.new(employee)
  	  end
  	  ruby_data
  	end

  	def self.department(parameter_option)
  	  ruby_data  = []
  	  data = Unirest.get('https://data.cityofchicago.org/resource/tt4n-kn4t.json?department=#{parameter_option}').body
  	  data.each do |employee|
  	  	ruby_data << Employee.new(employee)
  	  end
  	  ruby_data
  	end

  	def self.highest_paid(int: 3)
  	  ruby_data = []
  	  Unirest.get('https://data.cityofchicago.org/resource/tt4n-kn4t.json').body.each do |employee|
  	  	ruby_data << Employee.new(employee)
  	  end
  	  ruby_data.max_by(int) {|employee| employee.salary }
  	end
  end
end

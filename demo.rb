require_relative 'lib/sql_object'

class School < SQLObject
  has_many :houses
end

class House < SQLObject
  belongs_to :school
  has_many :students
end

class Student < SQLObject
  belongs_to :house
  has_one_through :school, :house, :school
end

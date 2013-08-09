class Cat < ActiveRecord::Base
  CAT_COLORS = [
    "black",
    "white",
    "red",
    "blue"
  ]

  attr_accessible :age, :birth_date, :color, :name, :sex

  validates(
    :age,
    :birth_date,
    :color,
    :name,
    :sex,
    :presence => true
  )

  validates :color, :inclusion => CAT_COLORS
  validates :sex, :inclusion => ["M" ,"F"]

  
end

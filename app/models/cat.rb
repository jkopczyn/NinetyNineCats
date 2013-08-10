class Cat < ActiveRecord::Base
  CAT_COLORS = [
    "black",
    "white",
    "red",
    "blue"
  ]

  attr_accessible :age, :birth_date, :color, :name, :sex

  has_many(
    :rental_requests,
    :class_name => "CatRentalRequest",
    :dependent => :destroy
  )

  validates(
    :age,
    :birth_date,
    :color,
    :name,
    :sex,
    :presence => true
  )

  validates :age, :numericality => { :only_integer => true }
  validates :color, :inclusion => CAT_COLORS
  validates :sex, :inclusion => ["M" ,"F"]  
end

class Cat < ActiveRecord::Base
  CAT_COLORS = [
    "black",
    "white",
    "red",
    "blue"
  ]

  belongs_to(
    :owner,
    :class_name => "User",
    :foreign_key => :user_id
  )

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
    :user_id,
    :presence => true
  )

  validates :age, :numericality => { :only_integer => true }
  validates :color, :inclusion => CAT_COLORS
  validates :sex, :inclusion => ["M" ,"F"]
end


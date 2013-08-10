class CatRentalRequest < ActiveRecord::Base
  STATUS_STATES = [
    "APPROVED",
    "DENIED",
    "PENDING"
  ]

  attr_accessible :cat_id, :end_date, :start_date, :status

  belongs_to :cat

  validates(
    :cat_id,
    :end_date,
    :start_date,
    :status,
    :presence => true
  )

  validates :status, :inclusion => STATUS_STATES

  validate :does_not_overlap_approved_request

  private
  def does_not_overlap_approved_request
    conditions = <<-SQL
      ((cat_id = :cat_id)
        AND (start_date < :end_date)
        AND (end_date > :start_date)
        AND (status = 'APPROVED'))
    SQL
    conflicts = CatRentalRequest.where(conditions, {
      :cat_id => self.cat_id,
      :start_date => self.start_date,
      :end_date => self.end_date
    })

    unless conflicts.empty?
      errors[:base] << "Request conflicts with existing approved request"
    end
  end
end
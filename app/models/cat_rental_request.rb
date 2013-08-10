class CatRentalRequest < ActiveRecord::Base
  STATUS_STATES = [
    "APPROVED",
    "DENIED",
    "PENDING"
  ]

  attr_accessible :cat_id, :end_date, :start_date, :status

  belongs_to :cat

  before_validation :assign_pending_status

  validates(
    :cat_id,
    :end_date,
    :start_date,
    :status,
    :presence => true
  )

  validates :status, :inclusion => STATUS_STATES

  validate :does_not_overlap_approved_request

  def approve!
    raise "not pending" unless self.status == "PENDING"
    transaction do
      self.status = "APPROVED"
      self.save!

      self.overlapping_pending_requests.each do |req|
        req.status = "DENIED"
        req.save!
      end
    end
  end

  private
  def assign_pending_status
    self.status ||= "PENDING"
  end

  def overlapping_requests
    conditions = <<-SQL
      ((cat_id = :cat_id)
        AND (start_date < :end_date)
        AND (end_date > :start_date))
    SQL

    overlapping_requests = CatRentalRequest.where(conditions, {
      :cat_id => self.cat_id,
      :start_date => self.start_date,
      :end_date => self.end_date
    })

    if self.id.nil?
      overlapping_requests
    else
      overlapping_requests.where("id != ?", self.id)
    end
  end

  def overlapping_approved_requests
    overlapping_requests.where("status = 'APPROVED'")
  end

  def overlapping_pending_requests
    overlapping_requests.where("status = 'PENDING'")
  end

  def does_not_overlap_approved_request
    unless overlapping_approved_requests.empty?
      errors[:base] << "Request conflicts with existing approved request"
    end
  end
end

class Counselling < ApplicationRecord
  belongs_to :candidate
  
  def self.create(id,date,note)
    candidate = Candidate.find(id)
    candidate.counsellings.create(counselling_date: date, note: note)
  end
end

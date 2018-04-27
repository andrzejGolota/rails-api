class Attachment < ApplicationRecord
  belongs_to :user
  belongs_to :invoice

  validates :file, presence: true
    # :file_size => {
    #   :maximum => 5.megabytes.to_i
    # }
  validates_presence_of :user_id
  validates_presence_of :invoice_id

end

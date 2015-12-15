require_relative '../lib/active_records_base'

class Conversation < ActiveRecordsBase
  belongs_to :sender, :foreign_key => :sender_id, class_name: 'User'
  belongs_to :recipient, :foreign_key => :recipient_id, class_name: 'User'
  has_many :messages
  self.finalize
end

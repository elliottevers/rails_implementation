require_relative '../lib/active_record_object'

class Conversation < ActiveRecordObject
  belongs_to :sender, :foreign_key => :sender_id, class_name: 'User'
  belongs_to :recipient, :foreign_key => :recipient_id, class_name: 'User'
  has_many :messages
  self.finalize!
end

require_relative '../lib/active_record_object'

class User < ActiveRecordObject
  has_many :conversations, :foreign_key => :sender_id
  self.finalize!
end

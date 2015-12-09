require_relative '../lib/active_record_object'

class Message < ActiveRecordObject
  belongs_to :conversation
  belongs_to :user
  self.finalize!
end

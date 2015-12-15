require_relative '../lib/active_records_base'

class Message < ActiveRecordsBase
  belongs_to :conversation
  belongs_to :user
  self.finalize
end

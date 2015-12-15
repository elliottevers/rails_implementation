require_relative '../lib/active_records_base'

class User < ActiveRecordsBase
  has_many :conversations, :foreign_key => :sender_id
  self.finalize
end

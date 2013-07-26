class Station < ActiveRecord::Base
  has_many :entries
end

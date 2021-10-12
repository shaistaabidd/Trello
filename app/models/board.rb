class Board < ApplicationRecord
  belongs_to :user

  validates :name, :presence => true,
                         :length => {:maximum => 25}
end

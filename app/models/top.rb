class Top < ApplicationRecord
    validates :name, presence: true, length: { maximum: 50 }
    validates :content, presence: true, length: { maximum: 140 }
end

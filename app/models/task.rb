class Task < ApplicationRecord
    scope :due_today, -> { where(due_date: Date.current) }
    validates :name, presence: true,
                     uniqueness: true

    validates :body, presence: true

    belongs_to :category
end

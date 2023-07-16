class Category < ApplicationRecord
    validates :name, presence: true,
                     uniqueness: true

    has_many :tasks, dependent: :destroy
    belongs_to :user

    # other validations or methods here
end

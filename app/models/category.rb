class Category < ApplicationRecord
    validates :name, presence: true,
                     uniqueness: true

    has_many :tasks

    # other validations or methods here
end

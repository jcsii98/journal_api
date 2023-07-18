class Category < ApplicationRecord
    has_many :tasks, dependent: :destroy
    belongs_to :user

    validates :name, presence: true,
                     uniqueness: { scope: :user_id }

    # other validations or methods here
end

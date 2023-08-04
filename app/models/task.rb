class Task < ApplicationRecord
  scope :due_today, -> { where(due_date: Date.current) }
  validates :name, presence: true,
                   uniqueness: { scope: :category_id }

  validates :body, presence: true

  belongs_to :category

  def as_json(options = {})
    super(options.merge({ methods: [:category_id] }))
  end
end


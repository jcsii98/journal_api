require 'rails_helper'

RSpec.describe Task, type: :model do

  it 'has a valid factory' do
    expect(build(:task)).to be_valid
  end

  it 'is not valid without a name' do
    task = build(:task, name: nil)
    expect(task).not_to be_valid
  end

  it 'validates uniqueness of name within the scope of category_id' do
    category = create(:category)
    create(:task, name: 'Buy groceries', category:)

    task = build(:task, name: 'Buy groceries', category: category)
    expect(task).not_to be_valid
  end

  it 'is not valid without a body' do
    task = build(:task, body: nil)
    expect(task).not_to be_valid
  end

  it 'belongs to a category' do
    category = create(:category)
    task = create(:task, category: category)
    expect(task.category).to eq(category)
  end

  it 'returns tasks due today' do
    today_task = create(:task, due_date: Date.current)
    tomorrow_task = create(:task, due_date: Date.current + 1.day)

    expect(Task.due_today).to include(today_task)
    expect(Task.due_today).not_to include(tomorrow_task)
  end

end

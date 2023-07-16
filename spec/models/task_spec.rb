require 'rails_helper'

RSpec.describe Task, type: :model do

    it "deletes a task" do
        category = Category.create(name: "Work")
        task = category.tasks.create(name: "Task 1", body: "Do Task 1 Things")
        task2 = category.tasks.create(name: "Task 2", body: "Do Task 2 Things")
        task.delete
        
        expect(category.tasks.count).to eq(1)
end
end

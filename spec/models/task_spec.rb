require 'rails_helper'

RSpec.describe Task, type: :model do

    it "creates a task for a specific category" do
        user = User.create(
        email: "sample@email.com",
        password: "password",
        password_confirmation: "password"
        )
        category = user.categories.create(name: "Work")
        task = category.tasks.create(name: "journal_api", body: "phase 1")

        expect(task.category).to eq(category)
        expect(task.category_id).to eq(1)
        expect(task.name).to eq("journal_api")
        expect(task.body).to eq("phase 1")
        expect(category.tasks.count).to eq(1)
    end

    it "updates task details with valid values" do
        user = User.create(
        email: "sample@email.com",
        password: "password",
        password_confirmation: "password"
        )
        category = user.categories.create(name: "Work")
        task = category.tasks.create(name: "journal_api", body: "phase 1")
        task.update(name: "journal_api updated", body: "phase 1 updated")

        expect(task.name).to eq("journal_api updated")
        expect(task.body).to eq("phase 1 updated")
    end

    it "deletes a task" do
        user = User.create(
        email: "sample@email.com",
        password: "password",
        password_confirmation: "password"
        )
        category = user.categories.create(name: "Work")
        task = category.tasks.create(name: "journal_api", body: "phase 1")
        task.delete

        expect(category.tasks.count).to eq(0)
    end



    #   it "updates category details" do
#     category = Category.create(name: "Work")
#     category.update(name: "Work Updated")
#     expect(category.name).to eq("Work Updated")
#   end

#   it "creates a task for a specific category" do
#     category = Category.create(name: "Work")
#     task = category.tasks.create(name: "Task 1", body: "Do Task 1 Things")
    
#     expect(category.tasks.count).to eq(1)
#     expect(task.category).to eq(category)
#   end

#   it "increments tasks count when a task is added to a category" do
#     category = Category.create(name: "Work")

#     expect {
#       category.tasks.create(name: "Task 1", body: "Do Task 1 Things")
#       category.tasks.create(name: "Task 2", body: "Do Task 2 Things")
#     }.to change { category.tasks.count }.by(2)
#   end
  
#   it "updates task details with valid values" do
#     category = Category.create(name: "Work")
    
#     task = category.tasks.create(name: "Task 1", body: "Do Task 1 Things")
#     task.update(name: "Task 1 Updated", body: "Do Task 1 Things Updated")

#     expect(task.name).to eq("Task 1 Updated")
#     expect(task.body).to eq("Do Task 1 Things Updated")
#   end

#     it "deletes a task" do
#         category = Category.create(name: "Work")
#         task = category.tasks.create(name: "Task 1", body: "Do Task 1 Things")
#         task2 = category.tasks.create(name: "Task 2", body: "Do Task 2 Things")
#         task.delete
        
#         expect(category.tasks.count).to eq(1)
#     end

end

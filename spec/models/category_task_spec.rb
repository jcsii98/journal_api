require 'rails_helper'

RSpec.describe Category, type: :model do
  # let(:user) { User.create(name: "John Doe", email: "john@example.com", password: "password") }
  # it "creates a category that can be used to organize tasks" do
  #   category = Category.new(name: "Work")
  #   expect(category).to be_valid
  # end

  # it "updates category details" do
  #   category = Category.create(name: "Work")
  #   category.update(name: "Work Updated")
  #   expect(category.name).to eq("Work Updated")
  # end

  # it "creates a task for a specific category" do
  #   category = Category.create(name: "Work")
  #   task = category.tasks.create(name: "Task 1", body: "Do Task 1 Things")
    
  #   expect(category.tasks.count).to eq(1)
  #   expect(task.category).to eq(category)
  # end

  # it "increments tasks count when a task is added to a category" do
  #   category = Category.create(name: "Work")

  #   expect {
  #     category.tasks.create(name: "Task 1", body: "Do Task 1 Things")
  #     category.tasks.create(name: "Task 2", body: "Do Task 2 Things")
  #   }.to change { category.tasks.count }.by(2)
  # end
  
  # it "updates task details with valid values" do
  #   category = Category.create(name: "Work")
    
  #   task = category.tasks.create(name: "Task 1", body: "Do Task 1 Things")
  #   task.update(name: "Task 1 Updated", body: "Do Task 1 Things Updated")

  #   expect(task.name).to eq("Task 1 Updated")
  #   expect(task.body).to eq("Do Task 1 Things Updated")
  # end
  describe "associations" do
    it "belongs to a user" do
      user = User.create(name: "John Doe", email: "john@example.com", password: "password")
      category = user.categories.build(name: "Work")
      expect(category).to be_valid
    end

    it "has many tasks" do
      user = User.create(name: "John Doe", email: "john@example.com", password: "password")
      category = user.categories.create(name: "Work")
      task = category.tasks.create(name: "Task 1", body: "Do Task 1 Things")
      
      expect(category.tasks.count).to eq(1)
      expect(task.category).to eq(category)
    end
  end
end


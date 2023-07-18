require 'rails_helper'

RSpec.describe Category, type: :model do
    it "creates a valid category" do
        user = User.create(
        email: "sample@email.com",
        password: "password",
        password_confirmation: "password"
        )
        category = user.categories.create(name: "Work")
        expect(user.categories.count).to eq(1)
        expect(category.name).to eq("Work")
        expect(category.user_id).to eq(1)
    end

    it "updates category details" do
        user = User.create(
        email: "sample@email.com",
        password: "password",
        password_confirmation: "password"
        )
        category = user.categories.create(name: "Work")
        category.update(name: "Work Updated")

        expect(category.name).to eq("Work Updated")
    end

    it "deletes a category" do
        user = User.create(
        email: "sample@email.com",
        password: "password",
        password_confirmation: "password"
        )
        category = user.categories.create(name: "Work")
        category.delete

        expect(user.categories.count).to eq(0)
    end

end
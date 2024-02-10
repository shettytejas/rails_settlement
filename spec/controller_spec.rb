# frozen_string_literal: true

require "spec_helper"

RSpec.describe DefaultController, type: :controller do
  describe "when set_user method is called in controller and it finds the user" do
    it "finds user from the params and assigns it to #user" do
      get :show, params: { username: "admin" }

      expect(response.body).to eq("Admin User")
    end
  end

  describe "when set_user! method is called in controller and it doesnt find the user" do
    it "raises an error" do
      expect { get :edit, params: { username: "not-found" } }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end

RSpec.describe OverrideController, type: :controller do
  describe "when set_user method is called in controller and it finds the user" do
    it "fails silently" do
      get :show, params: { user_name: "admin" }

      expect(response.body).to eq("no user found")
    end
  end

  describe "when set_user! method is called in controller and it finds the user" do
    it "assigns it to #user" do
      get :edit, params: { user_name: "Admin User" }

      expect(response.body).to eq("Admin User")
    end
  end
end

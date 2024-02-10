# frozen_string_literal: true

User.find_or_create_by username: "admin", name: "Admin User"
User.find_or_create_by username: "user", name: "Normal User"

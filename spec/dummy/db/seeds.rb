# frozen_string_literal: true

User.find_or_create_by username: "admin", name: "Admin User", is_active: true
User.find_or_create_by username: "user", name: "Normal User", is_active: false
User.find_or_create_by username: "user2", name: "Normal User", is_active: true

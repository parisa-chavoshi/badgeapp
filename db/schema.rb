# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_10_10_223923) do
  create_table "badge_templates", force: :cascade do |t|
    t.string "name"
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "external_id"
  end

  create_table "badges", force: :cascade do |t|
    t.string "user_id"
    t.string "badge_template_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["badge_template_id"], name: "index_badges_on_badge_template_id"
    t.index ["user_id"], name: "index_badges_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "external_id"
    t.string "name"
    t.string "description"
    t.string "thumbnail"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end

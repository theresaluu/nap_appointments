class CreateReservations < ActiveRecord::Migration[5.0]
  def change
    create_table :reservations do |t|

      t.string            "name"
      t.string            "phone"
      t.string            "email"
      t.string            "city"
      t.string            "address1"
      t.string            "address2"
      t.string            "state"
      t.string            "zip"
      t.string            "country"
      t.boolean           "consent_to_email", null: false, default: true
      t.text              "message"
      t.integer           "admin_id"
      t.datetime          "tour_date"
      t.string            "tour_time"
      t.integer           "party_size", null: false
      t.integer           "children_u12"
      t.string            "maui_stay"
      t.timestamps
    end
  end
end

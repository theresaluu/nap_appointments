class AddAasmStateToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :aasm_state, :string
  end
end

class AddLocationGroupToLocation < ActiveRecord::Migration[5.2]
  def change
    add_reference :locations, :location_group, foreign_key: true
  end
end

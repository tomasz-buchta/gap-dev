class CreateJoinTableCountriesTargetGroups < ActiveRecord::Migration[5.2]
  def change
    create_join_table :countries, :target_groups do |t|
      t.index [:country_id, :target_group_id], name: "index_country_on_target_group"
      t.index [:target_group_id, :country_id], name: "index_target_group_on_country"
    end
  end
end

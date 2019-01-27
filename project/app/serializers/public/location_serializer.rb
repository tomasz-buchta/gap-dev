class Public::LocationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :external_id, :created_at, :updated_at, :location_group_id
end

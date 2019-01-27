class Private::LocationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :external_id, :secret_code, :created_at, :updated_at, :location_group_id
end

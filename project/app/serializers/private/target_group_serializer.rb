class Private::TargetGroupSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :secret_code, :external_id, :parent_id, :panel_provider_id, :created_at, :updated_at
end

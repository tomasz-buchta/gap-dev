module Public
  class TargetGroupSerializer
    include FastJsonapi::ObjectSerializer
    attributes :name, :external_id, :parent_id, :panel_provider_id, :created_at, :updated_at
  end
end

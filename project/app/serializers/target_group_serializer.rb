class TargetGroupSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name,  :external_id, :parent_id, :panel_provider_id, :created_at, :updated_at
  attribute :secret_code, if: proc { |_record, params| params && params[:private] == true }
end

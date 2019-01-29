require "dry/system/container"
require_relative "../../matchers/result_matcher"

class AppContainer < Dry::System::Container
  configure do |config|
    config.root = (Pathname.pwd + "app")

    config.auto_register = %w[services]
  end

  load_paths!("services")
  load_paths!("repositories")
  load_paths!("factories")
  load_paths!("matchers")

  register("serializers.private.location_serializer") { Private::LocationSerializer }
  register("serializers.private.target_group_serializer") { Private::TargetGroupSerializer }
  register("serializers.public.location_serializer") { Public::LocationSerializer }
  register("serializers.public.target_group_serializer") { Public::TargetGroupSerializer }
  register("result_matcher") { ResultMatcher }
end

AppImport = AppContainer.injector

# This will freeze the container for modifications and will eager load everything
AppContainer.finalize! if Rails.env.production?

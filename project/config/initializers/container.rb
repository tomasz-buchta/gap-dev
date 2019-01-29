require "dry/system/container"

class AppContainer < Dry::System::Container
  configure do |config|
    config.root = (Pathname.pwd + "app")

    config.auto_register = %w[services]
  end

  load_paths!("services")
  load_paths!("repositories")
  load_paths!("factories")
  load_paths!("matchers")

  register("serializers.location_serializer") { LocationSerializer }
  register("serializers.target_group_serializer") { TargetGroupSerializer }
  register("result_matcher") { ResultMatcher }
end

AppImport = AppContainer.injector

# This will freeze the container for modifications and will eager load everything
AppContainer.finalize! if Rails.env.production?

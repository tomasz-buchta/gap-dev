require "dry/system/container"

class AppContainer < Dry::System::Container
  configure do |config|
    config.root = (Pathname.pwd + "app")

    config.auto_register = %w[services]
  end

  load_paths!("services")
  load_paths!("repositories")
end

AppImport = AppContainer.injector

# This will freeze the container for modifications and will eager load everything
AppContainer.finalize! if Rails.env.production?

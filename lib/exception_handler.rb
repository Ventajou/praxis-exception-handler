# Exception Handler plugin
#
# Praxis allows overriding its default exception handler, however only one
# override is possible. This plugin replaces the default handler and allows
# attaching additional handlers that can all be called. This lets us separate
# concerns, for example we can have one handler for logging and one for errbit.

module ExceptionHandler
  include Praxis::PluginConcern

  def self.handle(&handler)
    Plugin.instance.add_handler(handler)
  end

  # This class replaces the default Praxis handler
  class Handler
    def handle!(request, exception)
      response = nil

      # Call registered handlers
      Plugin.instance.handlers.each do |h|
        r = h.call(request, exception)
        # the latest handler to return a response wins
        response = r unless r.nil?
      end

      # If no other handler returns a response, we use the default Praxis handler
      response = Praxis::ErrorHandler.new.handle!(request, exception) if response.nil?

      response
    end
  end

  class Plugin < Praxis::Plugin
    include Singleton

    attr_accessor :handlers

    def initialize
      @handlers = []
    end

    def config_key
      :error_handler
    end

    def setup!
      # Configure the application to add our custom handler
      Praxis::Application.configure do |application|
        application.error_handler = ExceptionHandler::Handler.new
      end
    end

    def add_handler(handler)
      @handlers << handler
    end

  end
end

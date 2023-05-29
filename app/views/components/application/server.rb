# frozen_string_literal: true

module Application
  class Server < ApplicationComponent
    attr_accessor :host, :version

    def initialize(server:, version:)
      @server = server
      @version = version
    end

    def template
      div(
        class:
          "px-6 py-3 text-sm font-semibold leading-6 text-skin-base hover:bg-gray-50"
      ) do
        span(aria_hidden: "true", class: "font-normal block") { t("application.server.version", version: @version) }
        span(aria_hidden: "true", class: "block") { @server }
      end
    end
  end
end

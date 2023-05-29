# frozen_string_literal: true

module Application
  class DesktopSidebar < ApplicationComponent
    def initialize(current_controller:, menu_items:, server:, version:)
      @current_controller = current_controller
      @menu_items = menu_items
      @server = server
      @version = version
    end

    def template
      div(
        class: "hidden lg:fixed lg:inset-y-0 lg:z-50 lg:flex lg:w-72 lg:flex-col"
      ) do
        div(
          class:
            "flex grow flex-col gap-y-5 overflow-y-auto border-r border-gray-200 bg-white px-6"
        ) do
          div(class: "flex h-16 shrink-0 items-center") do
            render Application::Logo.new(name: t("app_name"), css_class: "h-8 w-auto")
          end
          nav(class: "flex flex-1 flex-col") do
            render Application::Menu.new(current_controller: @current_controller, items: @menu_items)
            render Application::ResourcesMenu.new(server: @server, version: @version)
          end
        end
      end
    end
  end
end

# frozen_string_literal: true

module Application
  class ResourcesMenu < ApplicationComponent
    include Phlex::Rails::Helpers::ButtonTo
    include Phlex::Rails::Helpers::LinkTo

    def initialize(server:, version:)
      @server = server
      @version = version
    end

    def template
      ul(role: "list", class: "flex flex-1 flex-col gap-y-7") do
        li do
          div(class: "text-xs font-semibold leading-6 text-skin-dimmed") { t("resources.name") }
          ul(role: "list", class: "-mx-2 mt-2 space-y-1") do
            items = t("resources.items")
            items.each { |item| menu_item(item.last) }
          end
        end
        li(class: "-mx-6 mt-auto") do
          div(class: "px-6") do
            button_to(t("disconnect"), disconnect_path, method: :delete, class: "button w-full")
          end
          render Application::Server.new(server: @server, version: @version)
        end
      end
    end

    private

    def menu_item(item)
      li do
        link_to(item[:url], target: "_blank", class: "text-skin-muted hover:text-skin-accented hover:bg-gray-50 group flex gap-x-3 rounded-md p-2 text-sm leading-6 font-semibold") do
          span(
            class:
              "flex h-6 w-6 shrink-0 items-center justify-center rounded-lg border text-[0.625rem] font-medium bg-white text-skin-dimmed border-gray-200 group-hover:border-skin-accented group-hover:text-skin-accented"
          ) { item[:icon] }
          span(class: "truncate") { item[:name] }
        end
      end
    end
  end
end

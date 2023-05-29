# frozen_string_literal: true

module Application
  class Menu < ApplicationComponent
    include Phlex::Rails::Helpers::LinkTo
    include Phlex::Rails::Helpers::TokenList

    def initialize(current_controller:, items: {})
      @items = items
      @current_controller = current_controller
    end

    def template
      ul(role: "list", class: "-mx-2 space-y-1 mb-8") do
        @items.each { |item| menu_item(item) }
      end
    end

    private

    def menu_item(item)
      case item[:type]
      when :stroke then menu_stroke_item(item)
      else menu_fill_item(item)
      end
    end

    def menu_stroke_item(item)
      li do
        link_to(
          item[:path],
          class:
            token_list(
              "hover:text-skin-accented hover:bg-gray-50 group flex gap-x-3 rounded-md p-2 text-sm leading-6 font-semibold",
              "text-skin-muted": !active?(item),
              "bg-gray-50 text-skin-accented group": active?(item)
            )
        ) do
          svg(
            xmlns: "http://www.w3.org/2000/svg",
            class: "h-6 w-6 shrink-0 text-skin-accented",
            fill: "none",
            viewbox: "0 0 24 24",
            stroke_width: "1.5",
            stroke: "currentColor"
          ) do |s|
            s.path(
              stroke_linecap: "round",
              stroke_linejoin: "round",
              d: item[:icon]
            )
          end
          plain item[:name]
        end
      end
    end

    def active?(item)
      @current_controller == item[:controller].to_s
    end
  end
end

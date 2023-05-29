# frozen_string_literal: true

module Application
  class Mobile < ApplicationComponent
    def initialize(current_controller:, menu_items:, server:, version:)
      @current_controller = current_controller
      @menu_items = menu_items
      @server = server
      @version = version
    end

    def template
      div(class: "relative z-50 lg:hidden", role: "dialog", aria_modal: "true") do
        div(
          class: "hidden fixed inset-0 bg-gray-900/80 backdrop",
          data_controller: "backdrop",
          data_backdrop_target: "backdrop",
          data_transition_enter_active: "transition-opacity ease-linear duration-200",
          data_transition_enter_from: "opacity-0",
          data_transition_enter_to: "opacity-100",
          data_transition_leave_active: "transition-opacity ease-linear duration-200",
          data_transition_leave_from: "opacity-100",
          data_transition_leave_to: "opacity-0"
        )
        div(
          class: "hidden fixed inset-0 flex",
          data_sidebar_target: "sidebar",
          data_transition_enter_active: "transition ease-in-out duration-300 transform",
          data_transition_enter_from: "-translate-x-full",
          data_transition_enter_to: "translate-x-0",
          data_transition_leave_active: "transition ease-in-out duration-300 transform",
          data_transition_leave_from: "translate-x-0",
          data_transition_leave_to: "-translate-x-full",
          role: "menu",
          aria_orientation: "vertical"
        ) do
          div(class: "relative mr-16 flex w-full max-w-xs flex-1") do
            div(class: "absolute left-full top-0 flex w-16 justify-center pt-5") do
              # Close button
              button(type: "button", class: "-m-2.5 p-2.5", data_action: "sidebar#toggleSidebar") do
                span(class: "sr-only") { "Close sidebar" }
                svg(class: "h-6 w-6 text-white", fill: "none", viewbox: "0 0 24 24", stroke_width: "1.5", stroke: "currentColor", aria_hidden: "true") do |s|
                  s.path(stroke_linecap: "round", stroke_linejoin: "round", d: "M6 18L18 6M6 6l12 12")
                end
              end
            end

            render Application::MobileSidebar.new(
              current_controller: @current_controller,
              server: @server,
              version: @version,
              menu_items: @menu_items
            )
          end
        end
      end
    end
  end
end

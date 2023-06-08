# frozen_string_literal: true

module Application
  class Notification < ApplicationComponent
    include Phlex::Rails::Helpers::TokenList

    def initialize(flash)
      @notice = flash[:notice] || flash.now[:notice]
      @alert = flash[:alert] || flash.now[:alert]
    end

    def template
      div(data: {controller: "dismiss", dismiss_target: "notification"}) do
        div(class: "pointer-events-none fixed inset-x-0 top-4 sm:flex sm:justify-center sm:px-6 sm:pb-5 lg:px-8") do
          div(class: token_list("pointer-events-auto flex items-center justify-between gap-x-6 accented px-6 py-2.5 sm:rounded-xl sm:py-3 sm:pl-4 sm:pr-3.5", "bg-skin-accented": notice?, "bg-skin-alternate": alert?)) do
            p(class: "text-sm leading-6 text-white") { @notice || @alert }
            button(type: "button", class: "-m-1.5 flex-none p-1.5", data: {action: "dismiss#dismiss"}) do
              span(class: "sr-only") { "Dismiss" }
              svg(
                class: "h-5 w-5 text-white",
                viewbox: "0 0 20 20",
                fill: "currentColor",
                aria_hidden: "true"
              ) do |s|
                s.path(
                  d:
                    "M6.28 5.22a.75.75 0 00-1.06 1.06L8.94 10l-3.72 3.72a.75.75 0 101.06 1.06L10 11.06l3.72 3.72a.75.75 0 101.06-1.06L11.06 10l3.72-3.72a.75.75 0 00-1.06-1.06L10 8.94 6.28 5.22z"
                )
              end
            end
          end
        end
      end
    end

    private

    def flash?
      @notice.present? || @alert.present?
    end

    def notice?
      flash? && @notice.present?
    end

    def alert?
      flash? && @alert.present?
    end
  end
end

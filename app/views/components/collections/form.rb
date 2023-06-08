# frozen_string_literal: true

module Collections
  class Form < ApplicationComponent
    include Phlex::Rails::Helpers::FormWith
    include Phlex::Rails::Helpers::TurboFrameTag
    include Phlex::Rails::Helpers::TokenList

    def initialize(collection:)
      @collection = collection
    end

    def template
      turbo_frame_tag(:modal_content, src: "", data: {"modal-target": "frame"}, class: "sm:flex sm:items-start") do
        div(class: "mt-3 text-center sm:mt-0 sm:text-left w-full") do
          div do
            h3(class: "text-lg font-semibold leading-6 text-skin-base") { t("collections.new.title") }
            p(class: "text-base leading-6 text-skin-muted") { t("collections.new.description") }
          end
          div(class: "mt-4 mb-6 sm:mx-auto sm:w-full") do
            form_with model: @collection, class: "space-y-6", data: {"modal-target": :form, "turbo-frame": "_top"} do |form|
              div do
                name_error = @collection.errors[:name].any?
                plain form.label(:name, class: token_list("label text-left", "input-error": name_error))
                div(class: "mt-2") do
                  plain form.text_field(:name, maxlength: 63, class: token_list("input w-full", "input-error": name_error))
                  p(class: "help help-error") { @collection.errors[:name].first } if name_error
                end
              end
              div do
                plain form.label(:distance_method, class: "label text-left")
                div(class: "mt-2") do
                  plain form.select(:distance_method, Collection::DISTANCE_METHODS.map { |m| [m.capitalize, m] }, {}, class: "select w-full")
                end
              end
            end
          end
        end
      end
    end
  end
end

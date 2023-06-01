# frozen_string_literal: true

module Collections
  class HeaderForm < ApplicationComponent
    include Phlex::Rails::Helpers::TokenList
    include Phlex::Rails::Helpers::LinkTo
    include Phlex::Rails::Helpers::FormWith
    include Phlex::Rails::Helpers::Label
    include Phlex::Rails::Helpers::Select
    include Phlex::Rails::Helpers::TextField
    include Phlex::Rails::Helpers::TurboFrameTag

    def initialize(collection:, collection_name:)
      @collection = collection
      @collection_name = collection_name
    end

    def template
      turbo_frame_tag(:collection_header) do
        form_with model: @collection, url: collection_path(escape_name(@collection_name)), method: :patch, data: {"turbo-frame": :_top} do |form|
          div(class: "lg:flex lg:items-center lg:justify-between") do
            div(class: "min-w-0 flex-1") do
              h2(
                class:
                  "mt-2 text-2xl font-bold leading-7 text-skin-base sm:truncate sm:text-3xl sm:tracking-tight"
              ) { t("collections.edit.title", name: @collection_name) }
              div(class: "space-y-6 max-w-3xl mt-4") do
                div do
                  name_error = @collection.errors[:name].any?
                  plain form.label(:name, class: token_list("label text-left", "input-error": name_error))
                  div(class: "mt-2") do
                    plain form.text_field(:name, maxlength: 63, class: token_list("input w-full text-lg", "input-error": name_error))
                    p(class: "help help-error") { @collection.errors[:name].first } if name_error
                  end
                end
                div do
                  plain form.label(:distance_method, class: "label text-left")
                  div(class: "mt-2") do
                    plain form.select(:distance_method, Collection::DISTANCE_METHODS.map { |m| [m.capitalize, m] }, {}, class: "select w-1/2")
                  end
                end
                div do
                  metadata_error = @collection.errors[:json_metadata].any?
                  plain form.label(:json_metadata, class: token_list("label text-left", "input-error": metadata_error))
                  div(class: "mt-2") do
                    plain form.text_area(:json_metadata, class: token_list("input w-full h-52 resize-none", "input-error": metadata_error))
                    p(class: "help") { t("collections.edit.help.metadata") }
                    p(class: "help help-error") { @collection.errors[:json_metadata].first } if metadata_error
                  end
                end
              end
            end

            div(class: "mt-5 flex lg:ml-4 lg:mt-0 place-self-start py-4") do
              span(class: "sm:ml-3") do
                link_to collection_path(escape_name(@collection_name)), class: "inline-flex items-center button" do
                  plain t("collections.edit.actions.cancel")
                end
              end
              span(class: "ml-3") do
                plain form.submit t("collections.edit.actions.submit"), class: "button button-accented"
              end
            end
          end
        end

        div(class: "border-b border-gray-200 pb-5 mt-10")
      end
    end
  end
end

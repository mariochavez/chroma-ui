# frozen_string_literal: true

class CollectionsController < ApplicationController
  before_action :connected!

  def index
    @collections, _ = ChromaGateway.collections
  end

  def new
    @collection_form = Collection.new
  end

  def create
    collection_form = Collection.new(secure_params)
    if collection_form.valid?
      collection, count, error = ChromaGateway.add_collection(name: collection_form.name, metadata: collection_form.metadata)

      return create_success_response(count == 1, collection) if collection.present?

      collection_form.errors.add(:name, error.message) if error.present?
    end

    create_failure_response(collection_form)
  end

  def show
    @collection, @embeddings_count, error = ChromaGateway.get_collection(unescape_name(params[:id]))
  end

  def edit
    collection_name = unescape_name(params[:id])
    collection, @embeddings_count, error = ChromaGateway.get_collection(collection_name, include_count: false)
    collection_form = Collection.new(id: collection.id, name: collection.name, metadata: collection.metadata)

    render turbo_stream: turbo_stream.replace(:collection_header, Collections::HeaderForm.new(collection: collection_form, collection_name: collection_name))
  end

  def update
    collection_name = unescape_name(params[:id])
    collection, @embeddings_count, error = ChromaGateway.get_collection(collection_name, include_count: false)
    collection_form = Collection.new(secure_params).tap { |c| c.id = collection.id }

    if collection_form.valid?
      collection, error = ChromaGateway.modify_collection(collection, collection_form.name, collection_form.metadata)
      return redirect_to collection_path(escape_name(collection.name))
    end

    render turbo_stream: turbo_stream.replace(:collection_header, Collections::HeaderForm.new(collection: collection_form, collection_name: collection_name))
  end

  def destroy
    deleted, error = ChromaGateway.delete_collection(unescape_name(params[:id]))

    redirect_to collections_path if deleted
  end

  private

  def create_failure_response(collection_form)
    response.status = :unprocessable_entity

    render turbo_stream: turbo_stream.replace(:modal_content, Collections::Form.new(collection: collection_form))
  end

  def create_success_response(replace, collection)
    response.status = :created

    render(turbo_stream: if replace
                           turbo_stream.replace(:index, Collections::List.new(collections: ChromaGateway.collections))
                         else
                           turbo_stream.append(:collection_items, Collections::ListItem.new(collection: collection))
                         end)
  end

  def secure_params
    params.require(:collection).permit(:name, :distance_method, :json_metadata, :metadata)
  end
end

# frozen_string_literal: true

class PeekEmbeddingsController < ApplicationController
  before_action :connected!

  def new
    collection_id = params[:collection_id]
    collection_name = unescape_name(params[:collection_name])

    query = Query.new(collection_id:)
    render turbo_stream: turbo_stream.replace(:peek_embeddings, PeekEmbeddings::Form.new(query:, collection_name:))
  end

  def create
    query = Query.new(secure_params)
    collection_name = params[:collection_name]

    if query.valid?
      embeddings, error = ChromaGateway.get_embeddings(**query.to_get)

      return render turbo_stream: [
        turbo_stream.replace(:peek_embeddings, PeekEmbeddings::Form.new(query:, collection_name:)),
        turbo_stream.replace(:peek_list_embeddings, PeekEmbeddings::List.new(embeddings:, additional: query.additional, collection_id: query.collection_id, collection_name:))
      ]
    end

    render turbo_stream: turbo_stream.replace(:peek_embeddings, PeekEmbeddings::Form.new(query:, collection_name:))
  end

  def destroy
  end

  private

  def secure_params
    params.require(:query).permit(:limit, :ids, :additional, :metadata_filter, :document_filter, :collection_id)
  end
end

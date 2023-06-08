# frozen_string_literal: true

class EmbeddingsController < ApplicationController
  before_action :connected!

  def new
    collection_id = params[:collection_id]
    collection_name = unescape_name(params[:collection_name])

    embedding = Embedding.new(collection_id: collection_id)

    render turbo_stream: turbo_stream.replace(:add_embeddings, Embeddings::Form.new(embedding:, collection_name:))
  end

  def create
    embedding = Embedding.new(secure_params)
    collection_name = unescape_name(params[:collection_name])

    if embedding.valid?
      chroma_embeddings = embedding.to_chroma

      collection_id = embedding.collection_id
      result, error = ChromaGateway.add_embeddings(collection_id, chroma_embeddings)

      embedding = Embedding.new(collection_id:)

      collection, embeddings_count, error = ChromaGateway.get_collection(collection_name)

      return render turbo_stream: [
        turbo_stream.replace(:add_embeddings, Embeddings::Form.new(embedding:, collection_name:)),
        turbo_stream.replace(:collection_header, Collections::ShowHeader.new(collection:, embeddings_count:))
      ]
    end

    render turbo_stream: turbo_stream.replace(:add_embeddings, Embeddings::Form.new(embedding: embedding, collection_name:))
  end

  def destroy
    embedding_id = CGI.unescape(params[:id])
    collection_id = params[:collection_id]

    deleted, error = ChromaGateway.delete_embedding(id: embedding_id, collection_id:)

    if deleted
      collection_name = unescape_name(params[:collection_name])
      collection, embeddings_count, error = ChromaGateway.get_collection(collection_name)

      render turbo_stream: [
        turbo_stream.remove(embedding_id),
        turbo_stream.replace(:collection_header, Collections::ShowHeader.new(collection:, embeddings_count:))
      ]
    end
  end

  private

  def secure_params
    params.require(:embedding).permit(:collection_id, :documents, :embeddings, :metadatas, :ids)
  end
end

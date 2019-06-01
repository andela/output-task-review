class Paginator
  def initialize(object:, offset:, limit:)
    @object = object
    @offset = offset || 0
    @limit = limit || 20
  end

  def call
    object.order(created_at: :desc).offset(offset).limit(limit)
  end

  private

  attr_reader :object, :offset, :limit
end

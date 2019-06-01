class BatchArticlesDecorator
  STRATEGIES = {
    tag: :tagged_with,
    author: :authored_by,
    favorited: :favorited_by
  }.freeze

  def initialize(articles, params)
    @articles = articles
    @params = params
  end

  def call
    decorator_param = params.detect { |k, _v| STRATEGIES.key?(k) }

    return decorate(articles, decorator_param) if decorator_param.present?

    articles
  end

  private

  attr_reader :articles, :params

  def decorate(articles, decorator_param)
    key = decorator_param.first
    value = decorator_param.last
    callable_method = articles.method(STRATEGIES[key])

    callable_method.call(value)
  end
end

class Builders::WordCount < SiteBuilder
  def build
    log = Bridgetown.logger
    generator do
      # Fetch all posts
      @posts = site.collections.posts.resources

      @total_post_count = generate_total_posts
      @total_word_count = generate_total_words
      @average_words_per_post = generate_average_words_per_post

    end

    liquid_tag :post_count do
      "#{@total_post_count} t"
    end

    liquid_tag "word_count" do
      "#{@total_word_count} a"
    end

    liquid_tag "average_word_count" do
      "#{@average_words_per_post} b"
    end

    def generate_total_posts
      @posts.count.to_s
    end

    def generate_total_words
      # Generate word count for all posts
      @count = 0
      @posts.each do |post|
        @count += post.content.split.size
      end

      @count = @count.to_s.reverse.scan(/.{1,3}/).join(',').reverse
    end

    def generate_average_words_per_post
      counts = []
      @posts.each do |post|
        counts << post.content.split.size
      end

      counts.sum / counts.size
    end
  end
end
class Builders::SiteStats < SiteBuilder
  def build
    @total_words, @total_posts = 0
    @average_words = []
    
    generator do
      # Doing some stat collection on post content
      log.info "Site Stats:", "Generating word counts for posts"
      site.collections.posts.resources.each do |post|
        log.debug "Site Stats:", "Counting the words for #{post.data.title}"
        # Write the word count for a post to cache while writing
        @total_words += post.data[:word_count] = post.content.count(' ')
        @average_words << post.content.count(' ')
      end

      @total_posts = site.collections.posts.resources.count

      # Stat output to STDOUT
      log.info "Site Stats:", "Total posts: #{delimit(@total_posts)}"
      log.info "Site Stats:", "Total words across all posts: #{delimit(@total_words)}"
      log.info "Site Stats:", "#{@average_words.sum} / #{@average_words.size} = #{@average_words.sum / @average_words.size} "
    end

    liquid_tag :total_posts do
      delimit(@total_posts)
    end

    liquid_tag :total_post_words do
      delimit(@total_words)
    end

    liquid_tag :total_post_words_average do
      delimit(@average_words.sum / @average_words.size)
    end
  end
end
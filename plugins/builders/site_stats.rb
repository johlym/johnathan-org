class Builders::SiteStats < SiteBuilder
  def build
    liquid_tag :site_stats do |stat|
      case stat
      when "posts"
        "#{site.collections.posts.resources.count}"
      when "words"
        c = 0
        site.collections.posts.resources.each do |post|
          c += post.content.split.count
        end
        "#{c}"
      when "average"
        ""
      else
        "<!-- #{stat} not implemented -->"
      end
    end
  end
end
require "reverse_markdown"

class Builders::JohnathanOrgGhost < SiteBuilder
  def build
    get "https://johnathan.org/ghost/api/v3/content/posts/?key=1b800d5eea1ea0464f0a6ceedf&limit=all" do |data|
      data.posts.each do |post|
        add_resource :posts, "#{post[:slug]}.md" do
          ___ post
          layout :post
          title post[:title]
          categories :posts
          date Bridgetown::Utils.parse_date(post[:published_at])
          content ReverseMarkdown.convert post[:html], unknown_tags: :pass_through, github_flavored: true
        end
      end
    end
  end
end
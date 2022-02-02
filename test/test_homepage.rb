require_relative "./helper"

class TestHomepage < Minitest::Test
  context "homepage" do
    setup do
      page = site.collections.pages.resources.find { |doc| doc.relative_url == "/" }
      document_root page
    end

    should "exist" do
      assert_select "body"
    end

    should "contain the navbar" do
      assert_select "nav"
    end

    should "contain the site title" do
      assert_select "h2", /Johnathan Lyman/
    end

    should "contain ad script" do
      assert_select "#ad-placement"
    end

    should "contain latest post header" do
      assert_select "h2", /Latest Posts/
    end

    should "contain latest post content" do
      assert_select "ul li div h3"
    end

  end
end

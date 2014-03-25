require 'spec_helper'

describe Article do
  
  before { @article = Article.new(title: "Example Title", description: "Description of the article",
                                  content: "Content of the article") }

  subject { @article }

  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:content) }

  it { should be_valid }

  describe "when title is not present" do
    before { @article.title = " " }
    it { should_not be_valid }
  end
  describe "when description is not present" do
    before { @article.description = " " }
    it { should_not be_valid }
  end
  describe "when content is not present" do
    before { @article.content = " " }
    it { should_not be_valid }
  end

end

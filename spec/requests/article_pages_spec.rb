require 'spec_helper'

describe "Article Pages" do
  
  subject { page }

  describe "content page" do
    before { visit content_path }

    it { should have_content('Добавление статьи') }
    it { should have_title(full_title('Добавление статьи')) }
  end

end

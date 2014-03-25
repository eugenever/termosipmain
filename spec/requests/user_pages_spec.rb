require 'spec_helper'

describe "User Pages" do
  
  subject { page }

  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Регистрация пользователя') }
    it { should have_title(full_title('Регистрация пользователя')) }
  end

end

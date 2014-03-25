require 'spec_helper'

describe "Static Pages" do
  
  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should have_content('Термопанели') }
    it { should have_content('Пеноизол') }
    it { should have_content('Пенополиуретан') }
    it { should have_title(full_title('Утепление фасадов, термопанели, пеноизол, пенополиуретан')) }
    it { should_not have_title('| Главная') }
  end

  describe "About page" do
    before { visit about_path }
    
    it { should have_content('О нас') }
    it { should have_title('ТермоСИП | О нас') }    
  end

  describe "Contact page" do
    before { visit contact_path }

    it { should have_content('Контакты') }
    it { should have_title('ТермоСИП | Контакты') }
  end

end

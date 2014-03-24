require 'spec_helper'

describe "Static Pages" do
  
  describe "Home page" do
    it "should have the content 'Термопанели, пеноизол, пенополиуретан'" do
      visit '/static_pages/home'
      expect(page).to have_content('Термопанели')
      expect(page).to have_content('Пеноизол')
      expect(page).to have_content('Пенополиуретан')
    end
    it "should have the title 'ТермоСИП | Утепление фасадов, термопанели, пеноизол, пенополиуретан'" do
      visit '/static_pages/home'
      expect(page).to have_title('Утепление фасадов, термопанели, пеноизол, пенополиуретан')
    end
  end

  describe "About page" do
    it "should have the content 'О нас'" do
      visit '/static_pages/about'
      expect(page).to have_content('О нас')
    end
    it "should have the title 'ТермоСИП | О нас'" do
      visit '/static_pages/about'
      expect(page).to have_title('ТермоСИП | О нас')
    end
  end

end

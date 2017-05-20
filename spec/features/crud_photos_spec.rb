require "rails_helper"

feature "PHOTOS" do
  context "index" do
    it "has the source of every row", points: 5 do
      test_photos = create_list(:photo, 5)

      visit "/photos"

      test_photos.each do |current_photo|
        expect(page).to have_content(current_photo.source)
      end
    end
  end

  context "index" do
    it "has the caption of every row", points: 5 do
      test_photos = create_list(:photo, 5)

      visit "/photos"

      test_photos.each do |current_photo|
        expect(page).to have_content(current_photo.caption)
      end
    end
  end

  context "index" do
    it "has a link to the details page of every row", points: 5 do
      test_photos = create_list(:photo, 5)

      visit "/photos"

      test_photos.each do |current_photo|
        expect(page).to have_css("a[href*='#{current_photo.id}']", text: "Show details")
      end
    end
  end

  context "details page" do
    it "has the correct source", points: 3 do
      photo_to_show = create(:photo)

      visit "/photos"
      find("a[href*='#{photo_to_show.id}']", text: "Show details").click

      expect(page).to have_content(photo_to_show.source)
    end
  end

  context "details page" do
    it "has the correct caption", points: 3 do
      photo_to_show = create(:photo)

      visit "/photos"
      find("a[href*='#{photo_to_show.id}']", text: "Show details").click

      expect(page).to have_content(photo_to_show.caption)
    end
  end

  context "index" do
    it "has a link to the new photo page", points: 2 do
      visit "/photos"

      expect(page).to have_css("a", text: "Add a new photo")
    end
  end

  context "new form" do
    it "saves the source when submitted", points: 2, hint: h("label_for_input") do
      visit "/photos"
      click_on "Add a new photo"

      test_source = "A fake source I'm typing at #{Time.now}"
      fill_in "Source", with: test_source

      click_on "Create photo"

      last_photo = Photo.order(created_at: :asc).last
      expect(last_photo.source).to eq(test_source)
    end
  end

  context "new form" do
    it "saves the caption when submitted", points: 2, hint: h("label_for_input") do
      visit "/photos"
      click_on "Add a new photo"

      test_caption = "A fake caption I'm typing at #{Time.now}"
      fill_in "Caption", with: test_caption

      click_on "Create photo"

      last_photo = Photo.order(created_at: :asc).last
      expect(last_photo.caption).to eq(test_caption)
    end
  end

  context "new form" do
    it "redirects to the index when submitted", points: 2, hint: h("redirect_vs_render") do
      visit "/photos"
      click_on "Add a new photo"

      click_on "Create photo"

      expect(page).to have_current_path("/photos")
    end
  end

  context "edit form" do
    it "redirects to the details page with a notice", points: 3, hint: h("copy_must_match") do
      visit "/photos"

      expect(page).to_not have_content("Photo created successfully.")

      click_on "Add a new photo"
      click_on "Create photo"

      expect(page).to have_content("Photo created successfully.")
    end
  end

  context "details page" do
    it "has a 'Delete photo' link", points: 2 do
      photo_to_delete = create(:photo)

      visit "/photos"
      find("a[href*='#{photo_to_delete.id}']", text: "Show details").click

      expect(page).to have_css("a", text: "Delete")
    end
  end

  context "delete link" do
    it "removes a row from the table", points: 5 do
      photo_to_delete = create(:photo)

      visit "/photos"
      find("a[href*='#{photo_to_delete.id}']", text: "Show details").click
      click_on "Delete photo"

      expect(Photo.exists?(photo_to_delete.id)).to be(false)
    end
  end

  context "delete link" do
    it "redirects to the index", points: 3, hint: h("redirect_vs_render") do
      photo_to_delete = create(:photo)

      visit "/photos"
      find("a[href*='#{photo_to_delete.id}']", text: "Show details").click
      click_on "Delete photo"

      expect(page).to have_current_path("/photos")
    end
  end

  context "delete link" do
    it "redirects to the index with a notice", points: 3, hint: h("copy_must_match") do
      photo_to_delete = create(:photo)

      visit "/photos"
      find("a[href*='#{photo_to_delete.id}']", text: "Show details").click

      expect(page).to_not have_content("Photo deleted successfully.")

      click_on "Delete photo"

      expect(page).to have_content("Photo deleted successfully.")
    end
  end

  context "details page" do
    it "has an 'Edit photo' link", points: 5 do
      photo_to_edit = create(:photo)

      visit "/photos"
      find("a[href*='#{photo_to_edit.id}']", text: "Show details").click

      expect(page).to have_css("a", text: "Edit photo")
    end
  end

  context "edit form" do
    it "has source pre-populated", points: 3, hint: h("value_attribute") do
      photo_to_edit = create(:photo)

      visit "/photos"
      find("a[href*='#{photo_to_edit.id}']", text: "Show details").click
      click_on "Edit photo"

      expect(page).to have_css("input[value='#{photo_to_edit.source}']")
    end
  end

  context "edit form" do
    it "has caption pre-populated", points: 3, hint: h("value_attribute") do
      photo_to_edit = create(:photo)

      visit "/photos"
      find("a[href*='#{photo_to_edit.id}']", text: "Show details").click
      click_on "Edit photo"

      expect(page).to have_content(photo_to_edit.caption)
    end
  end

  context "edit form" do
    it "updates source when submitted", points: 5, hint: h("label_for_input button_type") do
      photo_to_edit = create(:photo, source: "Boring old source")

      visit "/photos"
      find("a[href*='#{photo_to_edit.id}']", text: "Show details").click
      click_on "Edit photo"

      test_source = "Exciting new source at #{Time.now}"
      fill_in "Source", with: test_source

      click_on "Update photo"

      photo_as_revised = Photo.find(photo_to_edit.id)

      expect(photo_as_revised.source).to eq(test_source)
    end
  end

  context "edit form" do
    it "updates caption when submitted", points: 5, hint: h("label_for_input button_type") do
      photo_to_edit = create(:photo, caption: "Boring old caption")

      visit "/photos"
      find("a[href*='#{photo_to_edit.id}']", text: "Show details").click
      click_on "Edit photo"

      test_caption = "Exciting new caption at #{Time.now}"
      fill_in "Caption", with: test_caption

      click_on "Update photo"

      photo_as_revised = Photo.find(photo_to_edit.id)

      expect(photo_as_revised.caption).to eq(test_caption)
    end
  end

  context "edit form" do
    it "redirects to the details page", points: 3, hint: h("embed_vs_interpolate redirect_vs_render") do
      photo_to_edit = create(:photo)

      visit "/photos"
      find("a[href*='#{photo_to_edit.id}']", text: "Show details").click
      details_page_path = page.current_path

      click_on "Edit photo"
      click_on "Update photo"

      expect(page).to have_current_path(details_page_path, only_path: true)
    end
  end

  context "edit form" do
    it "redirects to the details page with a notice", points: 3, hint: h("copy_must_match") do
      photo_to_edit = create(:photo)

      visit "/photos"
      find("a[href*='#{photo_to_edit.id}']", text: "Show details").click

      expect(page).to_not have_content("Photo updated successfully.")

      click_on "Edit photo"
      click_on "Update photo"

      expect(page).to have_content("Photo updated successfully.")
    end
  end
end

class PhotosController < ApplicationController
  def index
    all_photos = Photo.all.order(:created_at => :desc)

    render("photo_templates/index.html.erb", :locals => {
      :list_of_photos => all_photos
    })
  end

  def show
    photo_to_show = Photo.find(params["id_to_display"])

    render("photo_templates/show.html.erb", :locals => {
      :the_photo => photo_to_show
    })
  end

  def new_form
    dummy_photo = Photo.new

    render("photo_templates/new_form.html.erb", :locals => {
      :photo_with_errors => dummy_photo
    })
  end

  def create_row
    photo_to_add = Photo.new

    photo_to_add.source = params["form_source"]
    photo_to_add.caption = params["form_caption"]

    save_status = photo_to_add.save

    if save_status == true
      redirect_to("/photos", :notice => "Photo created successfully.")
    else
      render("photo_templates/new_form.html.erb", :locals => {
        :photo_with_errors => photo_to_add
      })
    end
  end

  def edit_form
    existing_photo = Photo.find(params["prefill_with_id"])

    render("photo_templates/edit_form.html.erb", :locals => {
      :photo_to_prefill => existing_photo
    })
  end

  def update_row
    photo_to_change = Photo.find(params["id_to_modify"])

    photo_to_change.source = params["form_source"]
    photo_to_change.caption = params["form_caption"]

    save_status = photo_to_change.save

    if save_status == true
      redirect_to("/photos/#{photo_to_change.id}", :notice => "Photo updated successfully.")
    else
      render("photo_templates/edit_form.html.erb", :locals => {
        :photo_to_prefill => photo_to_change
      })
    end
  end

  def destroy_row
    photo_to_delete = Photo.find(params["id_to_remove"])

    photo_to_delete.destroy

    redirect_to("/photos", :notice => "Photo deleted successfully.")
  end
end

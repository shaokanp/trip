class NotesController < ApplicationController
  before_action :correct_user, only:[:update, :destroy, :attach_image]

  api :POST, '/notes', 'Create a new note.'
  param :note, Hash, required: true, desc: 'The note to create.' do
    param :title, String, required: true, desc: 'The title of this note.'
    param :content, String, required: true, desc: 'The content of this note.'
  end
  def create
    @pin = Pin.find(params[:note][:pin_id])
    @note = @pin.notes.build(note_params)
    if @note.save
      flash[:success] = 'Note created !'
      respond_to do |format|
        format.json { render json: @note }
      end
    else
      respond_to do |format|
        format.json { render @note.errors }
      end
    end
  end

  api :GET, '/notes/:id', 'Get a specified note.'
  param :id, String, required: true, desc: 'The numeric id of the desired note.'
  def show
    @note = Note.find(params[:id])
    render json: @note
  end

  api :GET, '/notes', 'Get all notes belong to a specified pin with pin_id.'
  param :pin_id, String, required: true, desc: 'The numeric id of the pin.'
  def index
    @notes = Note.where('pin_id = ?', params[:pin_id])
    render json: @notes.to_json(include: :note_images)
  end

  def update
    if @note.update_attributes(note_params)
      respond_to do |format|
        format.html
        format.json { render nothing: true, status: 204 }
      end
    else
      respond_to do |format|
        format.html
        format.json { render nothing: true, status: 400 }
      end
    end
  end

  api :POST, 'notes/:id/image', 'Attach a new image to the specified note.'
  def attach_image
    @note_image = @note.note_images.build(image: params[:file])

    if @note_image.save!
      respond_to do |format|
        format.html
        format.json { render json: @note_image.image, status: 200 }
      end
    else
      respond_to do |format|
        format.html
        format.json { render nothing: true, status: 400 }
      end
    end

  end

  api :Delete, '/notes/:id', 'Delete a note.'
  param :id, String, required: true, desc: 'The numeric id of the desired note.'
  def destroy
    @note.destroy
    # flash[:success] = 'Pin destroyed.'
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private

  def note_params
    params.require(:note).permit(:title, :content, :pin_id, :image)
  end

  def correct_user
    @note = Note.find(params[:id])
    @pin = @note.pin
    @trip = @pin.trip
    unless @trip.user_id == current_user.id
      flash[:error] = 'Sorry, you do not have the permission to do that.'
      head :forbidden
    end
  end
end

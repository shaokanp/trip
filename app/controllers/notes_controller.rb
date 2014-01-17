class NotesController < ApplicationController


  api :POST, '/notes', 'Create a new note.'
  param :note, Hash, required: true, desc: 'The note to create.' do
    param :content, String, required: true, desc: 'The content of this note.'
    param :image, String, required: false
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
    render json: @notes
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
    params.require(:note).permit(:content, :pin_id, :image)
  end

  def correct_user
    @note = Note.find(params[:id])
    @pin = @note.pin
    unless @pin.user_id == current_user.id
      flash[:error] = 'Sorry, you do not have the permission to do that.'
      head :forbidden
    end
  end
end

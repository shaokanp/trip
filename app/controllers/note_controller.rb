class NoteController < ApplicationController


  api :POST, '/notes', 'Create a new note.'
  param :note, Hash, required: true, desc: 'The note to create.' do
    param :title, String, required: true, desc: 'The title of this note.'
  end
  def create
    @pin = Pin.find(params[:note][:pin_id])
    @note = @pin.notes.build(note_params)
    if @pin.save
      flash[:success] = 'Pin created !'
      respond_to do |format|
        format.json { render json: @pin }
      end
    else
      respond_to do |format|
        format.json { render @pin.errors }
      end
    end
  end

  api :GET, '/notes/:id', 'Get a specified note.'
  param :id, String, required: true, desc: 'The numeric id of the desired note.'
  def show
    @note = Note.find(params[:id])
    render json: @note
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

  def pin_params
    params.require(:note).permit(:title, :pin_id)
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

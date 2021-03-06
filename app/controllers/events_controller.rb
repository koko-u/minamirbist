class EventsController < ApplicationController
  before_filter :authorize
  # GET /events
  # GET /events.xml
  def index
    @events = Event.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
    end
  end

  # GET /events/1
  # GET /events/1.xml
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/1/for_organizer
  # GET /events/1/for_organizer.xml
  def for_organizer
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.organizer == current_member
        format.html
        format.xml  { render :xml => @event }
      else
        format.html { redirect_to events_path, :notice => I18n.t(:cannot_edit) }
        format.xml { render :xml => @event }
      end
    end
    if @event.organizer == current_member
    else
    end
  end

  # GET /events/new
  # GET /events/new.xml
  def new
    @event = Event.new(:organizer => current_member)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
    unless @event.organizer == current_member
      flash[:notice] = I18n.t(:cannot_edit)
      redirect_to events_path 
    end
  end

  # POST /events
  # POST /events.xml
  def create
    params[:event].update(:organizer => current_member)
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to for_organizer_event_path(@event), :notice => 'Event was successfully created.' }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.xml
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to for_organizer_event_path(@event), :notice => 'Event was successfully updated.' }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to my_events_path }
      format.xml  { head :ok }
    end
  end

  # GET /events/1/join
  def join
    @event = Event.find(params[:id])
    @event.join(current_member)

    respond_to do |format|
      format.html { redirect_to event_path(@event) }
      format.xml  { render :xml => @event }
    end
  end

  # PUT /events/1/cancel
  def cancel
    @event = Event.find(params[:id])
    @event.cancel(current_member)

    respond_to do |format|
      format.html { redirect_to profile_path }
      format.xml  { render :xml => @event }
    end
  end
end

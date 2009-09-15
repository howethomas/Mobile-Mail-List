class SubscribersController < ApplicationController
  # GET /subscribers
  # GET /subscribers.xml
  def index
    @subscribers = Subscriber.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @subscribers }
    end
  end

  # GET /subscribers/1
  # GET /subscribers/1.xml
  def show
    @subscriber = Subscriber.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @subscriber }
    end
  end

  # GET /subscribers/new
  # GET /subscribers/new.xml
  def new
    @subscriber = Subscriber.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @subscriber }
    end
  end

  # GET /subscribers/1/edit
  def edit
    @subscriber = Subscriber.find(params[:id])
  end

  # POST /subscribers
  # POST /subscribers.xml
  def create
    @subscriber = Subscriber.new(params[:subscriber])    
    respond_to do |format|
      if @subscriber.save
        flash[:notice] = 'Subscriber was successfully created.'
        # Send a note to the cell phone
        send_text_message("Thanks for signing up!", @subscriber.callerid)
        
        format.html { redirect_to(@subscriber) }
        format.xml  { render :xml => @subscriber, :status => :created, :location => @subscriber }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @subscriber.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /subscribers/1
  # PUT /subscribers/1.xml
  def update
    @subscriber = Subscriber.find(params[:id])

    respond_to do |format|
      if @subscriber.update_attributes(params[:subscriber])
        flash[:notice] = 'Subscriber was successfully updated.'
        format.html { redirect_to(@subscriber) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @subscriber.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /subscribers/1
  # DELETE /subscribers/1.xml
  def destroy
    @subscriber = Subscriber.find(params[:id])
    @subscriber.destroy

    respond_to do |format|
      format.html { redirect_to(subscribers_url) }
      format.xml  { head :ok }
    end
  end
end

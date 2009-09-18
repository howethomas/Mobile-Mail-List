class CouponsController < ApplicationController
  # GET /coupons
  # GET /coupons.xml
  def index
    @coupons = Coupon.paginate :page => params[:page], :order => 'created_at DESC', :per_page => 25

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @coupons }
    end
  end

  # GET /coupons/1
  # GET /coupons/1.xml
  def show
    @coupon = Coupon.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @coupon }
    end
  end

  # GET /coupons/new
  # GET /coupons/new.xml
  def new
    @coupon = Coupon.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @coupon }
    end
  end

  # GET /coupons/1/edit
  def edit
    @coupon = Coupon.find(params[:id])
  end

  # POST /coupons
  # POST /coupons.xml
  def create
    @coupon = Coupon.new(params[:coupon])
    @coupon.generate_coupon_code if @coupon.coupon_code.nil?
    
    respond_to do |format|
      if @coupon.save
        flash[:notice] = 'Coupon was successfully created.'
        format.html { redirect_to(@coupon) }
        format.xml  { render :xml => @coupon, :status => :created, :location => @coupon }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @coupon.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /coupons/1
  # PUT /coupons/1.xml
  def update
    @coupon = Coupon.find(params[:id])

    respond_to do |format|
      if @coupon.update_attributes(params[:coupon])
        flash[:notice] = 'Coupon was successfully updated.'
        format.html { redirect_to(@coupon) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @coupon.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /coupons/1
  # DELETE /coupons/1.xml
  def destroy
    @coupon = Coupon.find(params[:id])
    @coupon.destroy

    respond_to do |format|
      format.html { redirect_to(coupons_url) }
      format.xml  { head :ok }
    end
  end
  
  def redeem
    c = Coupon.find_by_coupon_code(params[:coupon_code])
    if c.nil?
      flash[:notice] = 'Coupon not found'
      redirect_to :back
    else
      if c.qty == 0
        flash[:notice] = 'No coupons left'
        redirect_to :back
      else
        c.qty -= 1
        c.save
        flash[:notice] = 'Coupon redeemed'
        redirect_to :back
      end
    end  
  end
end

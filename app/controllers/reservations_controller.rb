class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.all
  end
  def create
    @reservation = Reservation.new(ressie_params)

    #31 lines of code to format the Tour Date
    #TODO: if it is the only thing you do at work this year, please refactor
    #this, Theresa. This is bananas.
    logger.info @reservation.tour_date.inspect
    logger.info params[:reservation][:tour_date].inspect

    if !@reservation.tour_date.nil?
      logger.info "Ressie Tour Date not nil"
      logger.info "Ressie Tour Date data type is = |#{@reservation.tour_date.class}|"
      if @reservation.tour_date.class == Date
        logger.info "Reservation Tour Date class is DATE - no change needed"
        else
          if params[:reservation][:tour_date].to_s.start_with?("#{Date.current.year}")
            logger.info "Reservation Tour Date class is year first"
            @reservation.tour_date =
              Date.strptime(params[:reservation][:tour_date].to_s, "%Y-%m-%d")
          else
            logger.info "Reservation Tour Date class is year last"
            @reservation.tour_date = Date.strptime(params[:reservation][:tour_date].to_s, "%m/%d/%Y")
          end
        end
    elsif !params[:reservation][:tour_date].nil?
      if params[:reservation][:tour_date].to_s.start_with?("#{Date.current.year}")
        logger.info "Reservation Tour Date class is year first"
        @reservation.tour_date = Date.strptime(params[:reservation][:tour_date].to_s, "%Y-%m-%d")
      else
        logger.info "Reservation Tour Date class is year last"
        @reservation.tour_date = Date.strptime(params[:reservation][:tour_date].to_s, "%m/%d/%Y")
      end
    else
      logger.info "Reservation Tour Date is NIL"
      @reservation.tour_date = nil
    end

    logger.info "TOUR DATE = |#{@reservation.tour_date}|"

    respond_to do |format|
      if @reservation.save
        format.html { redirect_to reservations_path, notice: 'Reservation was successfully created.' }
      end
    end

  end

  def new
    @reservation = Reservation.new
    @reservation.country = "UNITED STATES"

    respond_to do |format|
      format.html
    end

  end


  private

  def ressie_params
    params.require(:reservation).permit(:name, :phone, :email, :city, :email,
                                        :city, :address1, :address2, :state,
                                        :zip, :country, :consent_to_email,
                                        :message, :admin_id, :tour_date,
                                        :tour_time, :party_size, :children_u12,
                                        :maui_stay, :aasm_state)
  end
end

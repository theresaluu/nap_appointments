class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.all
  end
  def create
    @reservation = Reservation.new(ressie_params)
    @tour_times = Reservation.tour_times

    if !params[:reservation][:tour_date].nil?
      logger.info "Reservation Tour Date class is year last"
      reservation_string_date_time = params[:parsed_date_from_form].to_s + " " + params[:reservation][:tour_time].to_s + " " + "-10:00"
      @reservation.tour_date = DateTime.strptime(reservation_string_date_time, "%m/%d/%Y %I:%M %p %:z")
    else
      logger.info "Reservation Tour Date is NIL"
      @reservation.tour_date = nil
    end

    logger.info "TOUR DATE = |#{@reservation.tour_date}|"

    respond_to do |format|
      if @reservation.save
        format.html { redirect_to reservations_path, notice: 'Reservation was successfully created.' }
      else
        logger.debug @reservation.errors.full_messages.join(", ")
        format.html {render "new"}
      end
    end

  end

  def new
    @reservation = Reservation.new
    @reservation.country = "UNITED STATES"
    @tour_times = Reservation.tour_times

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
                                        :maui_stay, :aasm_state, :utc_offset,
                                        :parsed_date_from_form)
  end
end

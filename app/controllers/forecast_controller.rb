require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================

    wurl = 'https://api.forecast.io/forecast/592ac17e5e342d46ae1ecddf22c69ca6/'+@lat+","+@lng
    parsed_data_w = JSON.parse(open(wurl).read)

    @current_temperature = parsed_data_w["currently"]["temperature"]

    @current_summary = parsed_data_w["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data_w["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data_w["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data_w["daily"]["summary"]

    render("coords_to_weather.html.erb")
  end
end

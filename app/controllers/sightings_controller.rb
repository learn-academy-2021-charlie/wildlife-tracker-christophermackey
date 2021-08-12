class SightingsController < ApplicationController
    def update
        sighting = Sighting.find(params[:id])
        sighting.update(sighting_params)
        if sighting.valid?
            render json: sighting
        else
            render json: sighting.errors
        end
    end
    def destroy
        sighting = Sighting.find(params[:id])
        if sighting.destroy
            render json: sighting
        else
            render sighting.errors
        end
    end

    private
    def sighting_params
        params.require(:sighting).permit(:date, :latitude, :longitude, :start_date, :end_date)
    end
end

### The API Stories

## The Forest Service is considering a proposal to place in conservancy a forest of virgin Douglas fir just outside of Portland, Oregon. Before they give the go-ahead, they need to do an environmental impact study. They've asked you to build an API the rangers can use to report wildlife sightings.

# Story: As a developer I can create an animal model in the database. An animal has the following information: common name, latin name, kingdom (mammal, insect, etc.).
```
rails g resource Animal common_name:string latin_name:string kingdom:string
```

# Story: As the consumer of the API I can see all the animals in the database.
Hint: Make a few animals using Rails Console
rails c
create 3 animals
=> Animal.create common_name:'Brown Marmorated Stink Bug', latin_name:'Halyomorpha halys', kingdom:'Insect'

Inside of controller create index method. Inside of index method create animal variable to hold all instances off Animal table. Then, render json: animal
run rails server and open postman 
in headers tab add content-type to key, and add application/json to value
type localhost:3000/animals in url to render json version of table

Inside of controller create show method. Inside of show method create animal variable to hold a single instance of Animal using .find(params[:id])
add render json: animal

# Story: As the consumer of the API I can update an animal in the database.
- create update method in application_controller
```
def update
  animal = Animal.find(params[:id])
  animal.update(animal_params)
  if animal.valid?
    render json: animal
  else   
    render animal.errors
  end
end
```

# Story: As the consumer of the API I can destroy an animal in the database.
- create destroy method in application_controller
```
def destroy
        animal = Animal.find(params[:id])
        if animal.destroy
            render json: animal
        else
            render animal.errors
        end
    end
```

# Story: As the consumer of the API I can create a new animal in the database.
- create create method in animals controller
```
def create
        animal = Animal.create(params[:id])
        if animal.valid?
            render json: animal
        else
            render json: animal.errors
        end
    end

    private
    def animal_params
        params.require(:animal).permit(:common_name, :latin_name, :kingdom)
    end
```
- add auth token to application_controller 
```
skip_before_action :verify_authenticity_token

```

### Story: As the consumer of the API I can create a sighting of an animal with date (use the datetime datatype), a latitude, and a longitude.
## Hint: An animal has_many sightings. (rails g resource Sighting animal_id:integer ...)
- create sighting model with animal_id, date, latitude, longitude
```
rails g resource Sighting animal_id:integer date:datetime latitude:string longitude:string
```
- create association between animal and sighting but adding code below to Sighting model
```
belongs_to :animal
```
# Story: As the consumer of the API I can update an animal sighting in the database.
- create update method in Sightings Controller
```
def update
        sighting = Sighting.find(params[:id])
        sighting.update(sighting_params)
        if sighting.valid?
            render json: sighting
        else
            render json: sighting.errors
        end
    end

    private
    def sighting_params
        params.require(:sighting).permit(:date, :latitude, :longitude, :start_date, :end_date)
    end
```

# Story: As the consumer of the API I can destroy an animal sighting in the database.
- create destroy method in SightingsController
```
def update
        sighting = Sighting.find(params[:id])
        sighting.update(sighting_params)
        if sighting.valid?
            render json: sighting
        else
            render json: sighting.errors
        end
    end

    private
    def sighting_params
        params.require(:sighting).permit(:date, :latitude, :longitude, :start_date, :end_date)
    end
```

# Story: As the consumer of the API, when I view a specific animal, I can also see a list sightings of that animal.
Hint: Checkout the Ruby on Rails API docs on how to include associations.

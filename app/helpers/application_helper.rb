module ApplicationHelper
    def updated_at(model)
        model.updated_at.strftime("%B %e %Y")
    end

    def all_cities
        [ { name: 'Cities', destination: nil } ] +
        City.all.map { |city| { name: city.name, destination: articles_path(city: city) } } 
    end

    def all_cuisines
        [ { name: 'Cuisines', destination: nil } ] +
        Cuisine.all.map { |cuisine| { name: cuisine.name, destination: articles_path(cuisine: cuisine) } } 
    end

    def all_ratings
        [ { name: 'Ratings', destination: nil } ] +
        FoodReview.ratings.map { |rating| { name: rating[0].titleize, destination: articles_path(rating: rating[1]) } } 
    end

    def search_preposition(category)
        case category[0]
        when "city"
            return "in #{City.find(category[1]).name}"
        when "rating"
            return "with a rating of #{FoodReview.ratings.key(category[1].to_i).titleize}"
        when "cuisine"
            return "for #{Cuisine.find(category[1]).name} cuisine"
        else
            return "for #{category[1]}"
        end
    end
end

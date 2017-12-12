require "spec_helper"

include FoodGem
include DLLModule

FOOD_DATA_FILENAME = "input/food-data.txt"
RECIPE_FILENAME = "input/dish_recipes.txt"

RSpec.describe DLLModule do
  
  before :all do
    @recipe_ingredient_hash_array = read_recipe(RECIPE_FILENAME)
    @example_dish_title = "Lentejas con arroz, salsa de tomate, huevo y plátano a la plancha"
    @example_dish_ingredients = @recipe_ingredient_hash_array["Lentejas con arroz, salsa de tomate, huevo y plátano a la plancha"]

    
  end
  
  context "Lectura de una receta HarvardDishDSL." do
    it "Lectura de receta" do
      read_recipe(RECIPE_FILENAME)
    end
    it "Comprobar que lee bien los títulos" do
      expect(@recipe_ingredient_hash_array["Lentejas con arroz, salsa de tomate, huevo y plátano a la plancha"]).not_to be_nil
      expect(@recipe_ingredient_hash_array["Paella a la valenciana"]).not_to be_nil
    end
  end
  

  
end
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
    
    # puts "Ingredientes"
    # @example_dish_ingredients.each{ |x| puts x}
    
    @example_dish = HarvardDishDSL.new(@example_dish_title) do
      vegetal "Tomate", :porcion => "2 piezas pequeñas"
      fruta "Plátano", :gramos => 20
      cereal "Arroz",  :porcion => "1 taza"
      proteina "Lentejas", :porcion => "1/2 cucharon"
      proteina "Huevo frito", :porcion => "1 pieza"
      aceite "Aceite de oliva", :porcion => "1/2 cucharada"
      
      personas 2
    end
    
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
  
  context "Creación objeto HarvardDishDSL." do
    it "Creación de un plato." do
      HarvardDishDSL.new("Lentejas con arroz, salsa de tomate, huevo y plátano a la plancha")
    end
    it "Mostrar título de un plato." do
      expect(@example_dish.dish_title).to eq("Lentejas con arroz, salsa de tomate, huevo y plátano a la plancha")
    end
    it "Contar instrucciones de un plato." do
      expect(@example_dish.ingredient_quantity_array.size).to eq(6)
    end
    it "Mostrar tabla de la receta." do
      puts @example_dish.to_s
    end
  end
  
end
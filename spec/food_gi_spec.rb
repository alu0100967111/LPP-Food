require "spec_helper"

include FoodGem
include DLLModule

FOOD_DATA_FILENAME = "docs/input/food-data.txt"
SAMPLES_DATA_FILENAME = "docs/input/samples-data.txt"

RSpec.describe Food do
  
  before :all do
    @food_array = read_data(FOOD_DATA_FILENAME, SAMPLES_DATA_FILENAME)
    @apple_food = @food_array[0]
  end
  
  it "Calcular el índice glucémico de la Manzana" do
    expect(@apple_food.glucemic_index).to eq(5)
  end
end
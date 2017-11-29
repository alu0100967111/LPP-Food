require "spec_helper"

include FoodGem
include DLLModule

FOOD_DATA_FILENAME = "docs/input/food-data.txt"
SAMPLES_DATA_FILENAME = "docs/input/samples-data.txt"

RSpec.describe Food do
  
  before :all do
    @food_array = read_data(FOOD_DATA_FILENAME, SAMPLES_DATA_FILENAME)
    
    @hash_group_list = Hash.new() #Hash de nombre de lista y lista
    
    @food_array.each{ |food| # Rellenamos el Hash
      if (@hash_group_list.has_key?(food.group_name)) # Si existe la lista con ese grupo, insertamos
        @hash_group_list[food.group_name].insert_tail(food)
      else
        @hash_group_list[food.group_name] = DLL.new(food)
      end
    }
  end
  
  context "Sort" do
    it "Comprobar que swap funciona." do
      expect([6,5].swap(0,1)).to eq([5,6])
    end
    it "Representación de la tabla." do
      @hash_group_list.each { |group_name, food_group|
        puts group_name
        food_group.each { |food|
          puts food
        }
        puts "\n"
      }
    end
    it "Ordenar elementos con el método personalizado bubble sort imperativo." do
      expect(@food_array.sort).to eq(@food_array.bubble_sort_imp())
    end
    it "Ordenar elementos con el método personalizado bubble sort declarativo." do
      expect(@food_array.sort).to eq(@food_array.bubble_sort())
    end
    it "Ordenar elementos con el método personalizado merge sort imperativo." do
      expect(@food_array.sort).to eq(@food_array.merge_sort_imp())
    end
    it "Ordenar elementos con el método personalizado merge sort declarativo." do
      expect(@food_array.sort).to eq(@food_array.merge_sort())
    end
  end
  
  context "Benchmarks" do
    before :all do
      @food_array = read_data(FOOD_DATA_FILENAME, SAMPLES_DATA_FILENAME)
    end
    
    it "Benchmark normal" do
      Benchmark.bm(10) do |x|
        x.report("Bubble Sort Imperativo: ") { @food_array.bubble_sort_imp() }
        x.report("Bubble Sort Declarativo: ") { @food_array.bubble_sort() }
        x.report("Merge Sort Imperativo: ") { @food_array.merge_sort_imp() }
        x.report("Merge Sort Declarativo: ") { @food_array.merge_sort() }
        x.report("Sort con Sort: ") { @food_array.sort }
      end
    end
    
    it "Benchmark con más información:" do
      Benchmark.ips do |x|
        x.report("Bubble Sort Imperativo: ") { @food_array.bubble_sort_imp() }
        x.report("Bubble Sort Declarativo: ") { @food_array.bubble_sort() }
        x.report("Merge Sort Imperativo: ") { @food_array.merge_sort_imp() }
        x.report("Merge Sort Declarativo: ") { @food_array.merge_sort() }
        x.report("Sort con Sort: ") { @food_array.sort }
      end
    end
  end
  
end
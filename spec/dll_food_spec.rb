require "spec_helper"

include FoodGem
include DLLModule

FOOD_DATA_FILENAME = "input/food-data.txt"
SAMPLES_DATA_FILENAME = "input/samples-data.txt"

RSpec.describe DLLModule do
  
  before :all do
    @food_array = read_data(FOOD_DATA_FILENAME, SAMPLES_DATA_FILENAME)
    
    @list_array = Hash.new() #H ash de nombre de lista y lista
    
    @food_array.each{ |food| # Rellenamos el Hash
      if (@list_array.has_key?(food.group_name)) # Si existe la lista con ese grupo, insertamos
        @list_array[food.group_name].insert_tail(food)
      else
        @list_array[food.group_name] = DLL.new(food)
      end
    }
  end
  
  context "Instanciación de un Nodo" do
    before:all do
      @node_2 = Node.new(4)
      @node_1 = Node.new(3, @node_2)
      @node_3 = Node.new(5, nil, @node_2)
    end
    
    it "Crear un nuevo nodo con valor 5" do
      expect(Node.new(5).value).to eq(5)
    end
    it "Acceder al elemento siguiente de un nodo" do
      expect(@node_1.next).to eq(@node_2)
    end
    it "Acceder al elemento anterior de un nodo" do
      expect(@node_3.prev).to eq(@node_2)
    end
    it "Modificar el elemento anterior de un nodo" do
      @node_2.prev = @node_1
      expect(@node_2.prev.value).to eq(3)
    end
    it "Modificar el elemento siguiente de un nodo" do
      @node_2.next = @node_3
      expect(@node_2.next.value).to eq(5)
    end
  end
  
  context "Instanciación de una Lista Doblemente Enlazada" do
    before:all do
      @list = DLL.new(4) # Lista final deseada: 0-> 1 -> 2 -> 3 -> 4 -> 5
    end
    
    it "Crear una nueva lista vacía" do
      DLL.new()
    end
    it "Crear una nueva lista con un sólo nodo" do
      DLL.new(4)
    end
    it "Comprobamos que exista cabeza" do
      expect(@list.get_head).to eq(4)
    end
    it "Comprobamos que exista cola" do
      expect(@list.get_tail).to eq(4)
    end
    it "Insertar un nuevo nodo en la lista por el frente" do
      @list.insert_head(3)
    end
    it "Insertar un nuevo nodo en la lista por la cola" do
      @list.insert_tail(5)
    end
    it "Comprobamos que se han insertado varios elementos en la lista" do
      expect(@list.size).to eq(3)
    end
    it "Comprobamos que se puedan insertar varios elementos de una vezen la lista" do
      @list.insert_head(2, 1, 0)
      expect(@list.size).to eq(6)
    end
    it "Extraer el primer elemento de la lista" do
      expect(@list.extract_head).to eq(0)
    end
    it "Extraer último elemento de la lista" do
      expect(@list.extract_tail).to eq(5)
    end
    it "Eliminar un elemento con un valor elegido de la lista" do
      @list.delete(4)
      expect(@list.size).to eq(3)
    end
  end
  
  context "Creación de listas de alimentos" do
    describe "Comprobar que existan las 7 listas" do
      it "Comprobar que existan elemento de la lista sea de grupo Huevos, lacteos y helados" do
        expect(@list_array["Huevos, lacteos y helados"]).not_to be_empty
      end
      it "Comprobar que existan elemento de la lista sea de grupo Carnes y derivados" do
        expect(@list_array["Carnes y derivados"]).not_to be_empty
      end
      it "Comprobar que existan elemento de la lista sea de grupo Pescados y mariscos" do
        expect(@list_array["Pescados y mariscos"]).not_to be_empty
      end
      it "Comprobar que existan elemento de la lista sea de grupo Alimentos grasos" do
        expect(@list_array["Alimentos grasos"]).not_to be_empty
      end
      it "Comprobar que existan elemento de la lista sea de grupo Alimentos ricos en carbohidratos" do
        expect(@list_array["Alimentos ricos en carbohidratos"]).not_to be_empty
      end
      it "Comprobar que existan elemento de la lista sea de grupo Verduras y Hortalizas" do
        expect(@list_array["Verduras y Hortalizas"]).not_to be_empty
      end
      it "Comprobar que existan elemento de la lista sea de grupo Frutas" do
        expect(@list_array["Frutas"]).not_to be_empty
      end
    end
  end

  context "Enumerando la lista de alimentos" do
    before :all do
      @hlh_list = @list_array["Huevos, lacteos y helados"]
      @cd_list = @list_array["Carnes y derivados"]
      @pm_list = @list_array["Pescados y mariscos"]
    end
    
    it "Usamos el método each de la lista doblemente enlazada" do
      @hlh_list.each{ |food| expect(food.group_name).to eq ("Huevos, lacteos y helados")}
    end
    it "Usamos el método all de la lista doblemente enlazada" do
      expect(@hlh_list.all?{ |food| food.group_name == "Huevos, lacteos y helados"}).to be_truthy
    end
    it "Usamos el método any de la lista doblemente enlazada" do
      expect(@hlh_list.any?{ |food| food.name == "Yogurt"}).to be_truthy
    end
    it "Usamos el método max de la lista doblemente enlazada" do
      expect(@hlh_list.max.name).to eq("Yogurt")
    end
    it "Usamos el método min de la lista doblemente enlazada" do
      expect(@hlh_list.min.name).to eq("Huevo frito")
    end
    it "Usamos el método first de la lista doblemente enlazada" do
      expect(@hlh_list.first).to eq(@hlh_list.get_head)
    end
    it "Usamos el método count de la lista doblemente enlazada" do
      expect(@hlh_list.count).to eq(3)
    end
    it "Usamos el método find de la lista doblemente enlazada" do
      expect(@hlh_list.find{ |food| food.name == "Huevo frito"}).to eq(@hlh_list.get_head)
    end
    it "Usamos el método drop de la lista doblemente enlazada" do
      expect(@hlh_list.drop(2)).to eq([@hlh_list.get_tail])
    end
  end
end
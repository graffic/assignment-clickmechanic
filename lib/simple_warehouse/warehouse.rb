module SimpleWarehouse
  ##
  # Warehouse storage. Coordinates 0, 0 are bottom left
  #  height (y)
  #  .
  #  2
  #  1
  #  0 1 2 . width (x)
  #
  #  The position 0,0 is valid
  class Warehouse
    attr_accessor :width, :height

    def initialize(width, height)
      @width = width
      @height = height
      @crates = []
    end

    def can_store?(to_store)
      # Doesn't go outbounds
      if to_store.min_x < 0 or to_store.min_y < 0 or
        to_store.max_x >= @width or to_store.max_y >= @height then
        return false
      end
      
      not @crates.any? { |crate| crate.overlaps? to_store}
    end

    def store(x, y, crate)
      to_store = StoredCrate.new(x, y, crate)
      if can_store?(to_store) then
        @crates.push(to_store)
        true
      else
        false
      end
    end

    def find(product)
      @crates
        .select {|c| c.crate.product == product}
        .reduce([]) {|acc, c| acc + c.fill_coordinates}
    end

    ##
    # Removes the crate at position x, y. The position doesn't need to be the
    # initial position
    def remove(x, y)
      removed = @crates.reject! {|sc| x >= sc.min_x &&
                                   x <= sc.max_x &&
                                   y >= sc.min_y &&
                                   y <= sc.max_y }
      !removed.nil?
    end

    ##
    # Creates a matrix with indicators for :empty and :filled spaces
    # in the warehouse. 
    def space
      canvas = (1..@height).to_a.collect {|_| [:empty] * @width}
      @crates.each do |sc|
        range_y = (sc.min_y..sc.max_y)
        range_x = (sc.min_x..sc.max_x)
        sc.fill_coordinates.each do |x, y|
          canvas[y][x] = :filled
        end
      end
      canvas
    end

    private :can_store? 
  end

  class Crate
    attr_reader :width, :height, :product

    def initialize(width, height, product)
      @width = width
      @height = height
      @product = product
    end
  end

  class StoredCrate
    attr_reader :min_x, :min_y, :crate

    def initialize(x, y, crate)
      @min_x = x
      @min_y = y
      @crate = crate
    end

    def fill_coordinates
      (@min_x..max_x).to_a.product((@min_y..max_y).to_a)
    end

    def overlaps?(other)
      if max_x < other.min_x then 
        false
      elsif min_x > other.max_x then
        false
      elsif max_y < other.min_y then
        false
      elsif min_y > other.max_y then
        false
      else
        true
      end
    end

    def max_x
      min_x + @crate.width - 1
    end

    def max_y
      min_y + @crate.height - 1
    end
  end
end

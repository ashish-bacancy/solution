class ShoppingCart
  PRICES = {"milk" => 3.97, "bread" => 2.17, "banana" => 0.99, "apple" => 0.89}
  DISCOUNTS = {"milk" => [5.0, 2], "bread" => [6.0, 3]}

  def initialize(str)
    @items = str.split(",").tally
    @bill_items = {}
    @total_price = 0
    @total_saved = 0
  end

  def calculate_price
    @items.each do |item, count|
      if PRICES[item]
        if DISCOUNTS[item] && count >= DISCOUNTS[item][1]
          discounted_price = DISCOUNTS[item][0] * (count / DISCOUNTS[item][1])
          non_discounted_price = PRICES[item] * (count % DISCOUNTS[item][1])
          item_total = discounted_price + non_discounted_price
          @total_saved += (PRICES[item] * count) - item_total
        else
          item_total = PRICES[item] * count
        end
        @bill_items[item] = [count, item_total]
        @total_price += item_total
      end
    end
  end

  def print_receipt
    puts "Item  Quantity Price"
    puts "--------------------"
    @bill_items.each do |item, (count, total)|
      puts "#{item}    #{count}   $#{total}"
    end
    puts "Total Price: $#{@total_price.round(2)}"
    puts "You saved $#{(-@total_saved).round(2)} today!"
  end
end

puts "Please enter all the items purchased separated by a comma:"
input = gets.chomp.downcase
cart = ShoppingCart.new(input)
cart.calculate_price
cart.print_receipt

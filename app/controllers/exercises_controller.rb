class ExercisesController < ApplicationController

  def exercise1
    # 【要件】注文されていないすべての料理を返すこと
    #   * left_outer_joinsを使うこと
    @foods = Food.left_outer_joins(:order_foods).where(order_foods: {order_id: nil}).distinct()
  end

  def exercise2
    # 【要件】注文されていない料理を提供しているすべてのお店を返すこと
    #   * left_outer_joinsを使うこと
    @shops = Shop.left_outer_joins(foods: :order_foods).where(order_foods: {order_id: nil}).distinct()
  end

  def exercise3 
    # 【要件】配達先の一番多い住所を返すこと
    #   * joinsを使うこと
    #   * 取得したAddressのインスタンスにorders_countと呼びかけると注文の数を返すこと
    @address = Address.joins(:orders).select('addresses.*, COUNT(orders.id) as order_count').where(addressable_type: "Customer")
    .group('addresses.id')
  end

  def exercise4 
    # 【要件】一番お金を使っている顧客を返すこと
    #   * joinsを使うこと
    #   * 取得したCustomerのインスタンスにfoods_price_sumと呼びかけると合計金額を返すこと
    @customer = Customer.joins(orders: {foods: :order_foods}).select('customers.id, customers.name, orders.id,order_foods.id, SUM(foods.price) as custom_price')
    .group('customers.id, orders.id, order_foods.id').order('custom_price DESC')
  end
end

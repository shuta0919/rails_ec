# frozen_string_literal: true

class OrderMailer < ApplicationMailer
  def order_confirmation(order)
    @order = order
    mail(
      to: @order.email, # フォームで登録されたメールアドレスを使用
      subject: "注文確認 #{@order.id}"
    )
  end
end

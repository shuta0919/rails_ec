namespace :promotion_code do
  desc 'Generate 10 new promotion codes'
  task generate: :environment do
    generate_codes = []

    10.times do
      code = PromotionCode.generate_code
      discount_amount = PromotionCode.generate_discount_amount

      promotion = PromotionCode.create!(
        code: code,
        discount_amount: discount_amount,
        used: false
      )

      generate_codes << "#{promotion.code} - ¥#{promotion.discount_amount}"
    end

    puts generate_codes
  end
end

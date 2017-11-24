1.) gem 'aasm'
    1.1) rails g migration add_aasm_state_to_products aasm_state
    1.2) rails db:migrate
2.) product.rb:
    include AASM 

    aasm whiny_transitions: false do
        state :pending, initial: true 
        state :published
        state :outOfStock
        state :soldOut

        event :publish do 
        transitions from: :pending, to: :published
        end 

        event :mark_out_of_stock do 
        transitions from: :published, to: :outOfStock
        end

        event :archive do 
        transitions from: [:published, :outOfStock], to: :soldOut
        end 

    end
3.) product_controller:
    3.1) 
        def index
            @products = Product.where(aasm_state: [:published, :soldOut]).order(created_at: :desc)
        end
    3.2) 
        def create 
            ...
            if product.save 
                @product.published!
                ...
            end
        end
4.) Product.all.each {|p| p.publish!}

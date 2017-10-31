def update
    campaign_params = params.require(:campaign).permit(:title,
                                                    :description,
                                                    :goal,
                                                    :end_date)
    @campaign.update campaign_params
end

(byebug) params
<ActionController::Parameters {"campaign"=>{"title"=>"abc"}, "id"=>"64", "controller"=>"campaigns", "action"=>"update"} permitted: false>
(byebug) @campaign
#<Campaign id: 64, title: "All browsers support the hex definitions #chuck an...", description: "Magnam qui nulla velit odit veniam. Ullam voluptat...", goal: 249782, end_date: "2018-02-01 17:44:28", created_at: "2017-10-24 16:44:28", updated_at: "2017-10-24 16:44:28">
(byebug) n #enter 'n' to move to the next line. 
enter continue to exit

rails g model user first_name last_name email password_digest
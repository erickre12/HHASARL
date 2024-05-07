function tour_length=fitness_evaluation(routes,distances)
    tour_length=0;
    for i=1:length(routes)-1
        tour_length=tour_length+distances(routes(i)+1,routes(i+1)+1);
    end
end

